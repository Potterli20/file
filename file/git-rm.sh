#回收内存
#里面最重要的两条命令是 git filter-branch 和 gc, filter-branch 真正在清理，但是只运行它也是没用的，需要再删除备份的文件，重新打包之类的，最后的gc命令，用来收集产生的垃圾，最终清除大文件。
#https://zhuanlan.zhihu.com/p/377661967
rm -rf .git/refs/original/
git reflog expire --expire=now --all
git fsck --full --unreachable
git repack -A -d
git gc --aggressive --prune=now