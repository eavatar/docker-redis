FROM ubuntu:14.04.1

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y wget build-essential

RUN mkdir -p /dist/etc/redis /dist/usr/bin
# Install Redis.
RUN  wget http://download.redis.io/releases/redis-2.8.19.tar.gz &&\
     tar xvzf redis-2.8.19.tar.gz  &&\
     mv redis-2.8.19 redis-stable &&\
     cd redis-stable && make && make install

RUN \
     cp -f redis-stable/src/redis-sentinel /dist/usr/bin &&\
     cp -f redis-stable/src/redis-server /dist/usr/bin &&\
     cp -f redis-stable/*.conf /dist/etc/redis &&\
     sed -i 's/^\(bind .*\)$/# \1/' /dist/etc/redis/redis.conf &&\
     sed -i 's/^\(daemonize .*\)$/# \1/' /dist/etc/redis/redis.conf &&\
     sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /dist/etc/redis/redis.conf &&\
     sed -i 's/^\(logfile .*\)$/# \1/' /dist/etc/redis/redis.conf

WORKDIR /dist

RUN tar cf /overlayfs.tar .
