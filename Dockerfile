FROM ubuntu:24.04

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openssh-server sudo ca-certificates curl && \
    mkdir -p /var/run/sshd /etc/ssh /data && \
    rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

ENV PERSISTENT_DIR=/data
ENV ALLOW_ROOT_LOGIN=false
ENV ALLOW_PASSWORD_AUTH=false
ENV CF_USE_QUICK_TUNNEL=false

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 22

ENTRYPOINT ["/bin/bash", "/start.sh"]