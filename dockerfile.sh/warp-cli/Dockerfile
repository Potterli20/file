FROM  --platform=${TARGETPLATFORM} debian:latest

ARG TARGETPLATFORM
WORKDIR /root

RUN set -ex &&\
    apt update && \
    apt upgrade -y && \
    apt install -y curl gnupg lsb-release bash tar gzip privoxy && \
    curl https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/cloudflare-client.list && \
    apt update && \
    apt install -y cloudflare-warp && \
    apt clean && \
    apt autoremove -y 

RUN mkdir -p /root/.local/share/warp && \
    echo -n 'yes' > /root/.local/share/warp/accepted-tos.txt

COPY entrypoint.sh /entrypoint.sh

ENV GOST_ARGS="-L :1080"
ENV WARP_SLEEP=2

VOLUME /etc/privoxy

HEALTHCHECK --interval=15s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -fsS "https://cloudflare.com/cdn-cgi/trace" | grep -qE "warp=(plus|on)" || exit 1

ENTRYPOINT ["/entrypoint.sh"]
