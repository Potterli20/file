FROM debian:stable-slim

# 安装依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential autoconf automake libtool pkg-config \
    libssl-dev libexpat1-dev libevent-dev libhiredis-dev libnghttp2-dev \
    python3-dev python3-pip curl ca-certificates git vim flex bison \
    libsystemd-dev python3 python3-dev python3-pip swig \
    protobuf-compiler protobuf-c-compiler libprotobuf-c-dev \
    libsodium-dev \
    && apt-get clean \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*
# 设置 Unbound 源码目录
WORKDIR /root/unbound

# 拷贝源码（或克隆官方仓库）
# COPY unbound-src /root/unbound
RUN git clone https://github.com/NLnetLabs/unbound.git .

# 拷贝你的 make.sh
COPY make.sh /root/unbound/make.sh
RUN chmod +x /root/unbound/make.sh

# 执行自定义编译
RUN ./make.sh && make && make install

# 创建配置目录
RUN mkdir -p /opt/unbound/etc

# 拷贝配置文件
COPY config/unbound.conf /opt/unbound/etc/unbound.conf

# 下载 root hints
RUN curl -o /opt/unbound/etc/root.hints https://www.internic.net/domain/named.root

# 暴露 DNS 端口
EXPOSE 53/udp 53/tcp

# 默认启动命令
CMD ["/opt/unbound/sbin/unbound", "-d", "-c", "/opt/unbound/etc/unbound.conf"]
