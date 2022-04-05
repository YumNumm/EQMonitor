FROM google/dart as builder

RUN apt-get -y update && apt-get -y upgrade &&\
    export DEBIAN_FRONTEND noninteractive 
    
RUN apt-get -y install git wget fish locales &&\
    echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen &&\
    locale-gen ja_JP.UTF-8 &&\
    /usr/sbin/update-locale LANG = ja_JP.UTF-8 &&\
    apt-get clean &&\
    rm -rf /var/lib/app/lists/*
ENV LC_ALL ha_JP.UTF-8
WORKDIR /app
COPY app/pubspec.* ./
RUN dart pub get
COPY ./app/ /app/
RUN dart pub get --offline
RUN dart compile exe /app/bin/eqserver.dart -o /app/main
ENTRYPOINT ["/app/main"]
