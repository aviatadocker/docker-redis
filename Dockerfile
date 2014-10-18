FROM customercentrix/ubuntu

RUN \
  cd /tmp && \
  mkdir redis-2.8.17 && \
  wget http://download.redis.io/releases/redis-2.8.17.tar.gz && \
  tar xvzf redis-2.8.17.tar.gz && \
  cd redis-2.8.17 && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-stable* && \
  sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]

EXPOSE 6379
