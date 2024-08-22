FROM nginx

#挂载目录
VOLUME /home/data/html
# 创建目录
RUN mkdir -p /home/data/html

# 制定路径
WORKDIR /home/data/html

# 复制配置文件到容器中
COPY ./nginx.conf /home/data/html/nginx.conf

# 复制自定义的html文件到容器中
COPY ./html /home/data/html

