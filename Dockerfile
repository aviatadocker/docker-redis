FROM aviata/ubuntu

# Redis 2.8

# Install
RUN  date -u +"%Y-%m-%d %H:%M:%S" && cd /tmp \
  && date -u +"%Y-%m-%d %H:%M:%S" && wget http://download.redis.io/releases/redis-2.8.19.tar.gz \
  && date -u +"%Y-%m-%d %H:%M:%S" && tar xvzf redis-2.8.19.tar.gz \
  && date -u +"%Y-%m-%d %H:%M:%S" && cd redis-2.8.19 \
  && date -u +"%Y-%m-%d %H:%M:%S" && make \
  && date -u +"%Y-%m-%d %H:%M:%S" && make install \
  && date -u +"%Y-%m-%d %H:%M:%S" && cp -f src/redis-sentinel /usr/local/bin \
  && date -u +"%Y-%m-%d %H:%M:%S" && mkdir -p /etc/redis \
  && date -u +"%Y-%m-%d %H:%M:%S" && cp -f *.conf /etc/redis \
  && date -u +"%Y-%m-%d %H:%M:%S" && rm -rf /tmp/redis-2.8.19* \
  && date -u +"%Y-%m-%d %H:%M:%S" 

# Configure
RUN  date -u +"%Y-%m-%d %H:%M:%S" && sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf \
  && date -u +"%Y-%m-%d %H:%M:%S" && sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf \
  && date -u +"%Y-%m-%d %H:%M:%S" && sed -i 's/^\(dir .*\)$/dir \/redis/' /etc/redis/redis.conf \
  && date -u +"%Y-%m-%d %H:%M:%S" && sed -i 's/^\(logfile .*\)$/dir \/redis/' /etc/redis/redis.conf \
  && date -u +"%Y-%m-%d %H:%M:%S" 

VOLUME ["/redis"]

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]
