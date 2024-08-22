FROM mysql:8.0.37

 
# 创建目录
RUN mkdir -p ./mysql/conf
RUN mkdir -p ./mysql/logs
RUN mkdir -p ./mysql/data

# 执行sql脚本
ADD ./db/*sql docker-entrypoint-initdb.d/

