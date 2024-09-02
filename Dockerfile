FROM neomediatech/ubuntu-base

RUN apt-get update && \
    apt-get -y --no-install-recommends --no-install-suggests dist-upgrade && \
    rm -rf /var/lib/apt/lists/*

RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get -y --no-install-recommends --no-install-suggests install \
            software-properties-common ffmpeg gnupg2 && \
    rm -rf /var/lib/apt/lists/*

RUN add-apt-repository -y ppa:mozillateam/ppa && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-c"]

RUN echo -e "Package: * \nPin: release o=LP-PPA-mozillateam \nPin-Priority: 1001 \n" |tee /etc/apt/preferences.d/mozilla-firefox

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests -q firefox ubuntu-restricted-extras libpulse0 apulse && \
    rm -rf /var/lib/apt/lists/*

ENV QT_GRAPHICSSYSTEM="native" \
    DISPLAY=":0"
COPY entrypoint.sh /
RUN chmod +x entrypoint.sh

CMD ["/bin/sh", "/entrypoint.sh"]

