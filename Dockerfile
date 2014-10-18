FROM customercentrix/ubuntu

RUN \
  cd /tmp && \
  wget http://download.redis.io/releases/redis-2.8.17.tar.gz && \
  tar xvzf redis-2.8.17.tar.gz && \
  cd redis-2.8.17 && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-2.8.17* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(save 900 1.*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(save 300 10.*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(save 60 10000.*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]

EXPOSE 6379
