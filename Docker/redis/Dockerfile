FROM redis:latest

# 设置容器内的工作目录
WORKDIR /redis

# 创建redis配置文件目录
RUN mkdir -p /redis/conf

# 复制配置文件到工作目录
COPY ./conf/redis.config /redis/conf
