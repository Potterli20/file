import json
import asyncio
from pyppeteer import launch
from datetime import datetime, timedelta
import aiofiles
import random
import requests
import os

# 从环境变量中获取 Telegram Bot Token 和 Chat ID
TELEGRAM_BOT_TOKEN = os.getenv('TELEGRAM_BOT_TOKEN')
TELEGRAM_CHAT_ID = os.getenv('TELEGRAM_CHAT_ID')

def format_to_iso(date):
    return date.strftime('%Y-%m-%d %H:%M:%S')

async def delay_time(ms):
    await asyncio.sleep(ms / 1000)

# 全局浏览器实例
browser = None

async def login(username, password, panelnum):
    global browser

    page = None  # 确保 page 在任何情况下都被定义

    try:
        if not browser:
            browser = await launch(headless=True, args=['--no-sandbox', '--disable-setuid-sandbox'])

        page = await browser.newPage()
        url = f'https://panel{panelnum}.serv00.com/login/?next=/'
        await page.goto(url)

        username_input = await page.querySelector('#id_username')
        if username_input:
            await page.evaluate('''(input) => input.value = ""''', username_input)

        await page.type('#id_username', username)
        await page.type('#id_password', password)

        login_button = await page.querySelector('#submit')
        if login_button:
            await login_button.click()
        else:
            raise Exception('无法找到登录按钮')

        await page.waitForNavigation()

        is_logged_in = await page.evaluate('''() => {
            const logoutButton = document.querySelector('a[href="/logout/"]');
            return logoutButton !== null;
        }''')

        return is_logged_in

    except Exception as e:
        print(f'serv00账号 {username} 登录时出现错误: {e}')
        return False

    finally:
        if page:
            await page.close()

async def main():
    async with aiofiles.open('accounts.json', mode='r', encoding='utf-8') as f:
        accounts_json = await f.read()
    accounts = json.loads(accounts_json)

    for account in accounts:
        username = account['username']
        password = account['password']
        panelnum = account['panelnum']

        is_logged_in = await login(username, password, panelnum)

        if is_logged_in:
            now_utc = format_to_iso(datetime.utcnow())
            now_beijing = format_to_iso(datetime.utcnow() + timedelta(hours=8))
            success_message = f'serv00账号 {username} 于北京时间 {now_beijing}（UTC时间 {now_utc}）登录成功！'
            print(success_message)
            send_telegram_message(success_message)
        else:
            print(f'serv00账号 {username} 登录失败，请检查serv00账号和密码是否正确。')

        delay = random.randint(1000, 8000)
        await delay_time(delay)

    print('所有serv00账号登录完成！')

# 发送Telegram消息
def send_telegram_message(message):
    url = f"https://api.telegram.org/bot{TELEGRAM_BOT_TOKEN}/sendMessage"
    payload = {
        'chat_id': TELEGRAM_CHAT_ID,
        'text': message,
        'reply_markup': {
            'inline_keyboard': [
                [
                    {
                        'text': '问题反馈❓'
                    }
                ]
            ]
        }
    }
    headers = {
        'Content-Type': 'application/json'
    }
    response = requests.post(url, json=payload, headers=headers)
    if response.status_code != 200:
        print(f"发送消息到Telegram失败: {response.text}")

# 运行主程序
asyncio.get_event_loop().run_until_complete(main())
