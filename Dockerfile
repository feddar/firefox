FROM neomediatech/ubuntu-base:latest

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \ 
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y -q firefox ubuntu-restricted-extras && \
    rm -rf /var/lib/apt/lists/*

ENV QT_GRAPHICSSYSTEM="native" \
    DISPLAY=":0"
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]
