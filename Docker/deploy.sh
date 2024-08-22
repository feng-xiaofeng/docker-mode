#!/bin/sh
# chmod +x deploy.sh   添加权限
# 使用说明，用来提示输入参数
# ./deploy.sh services   启动
usage (){
    echo "Usage: $0 <version>"
    exit 1
}
#启动基础环境
base() {
    docker-compose up -d trip-mysql trip-redis
}
# 启动程序模块 --build
services(){
    docker-compose up -d \
        trip-home-page \
        trip-goods \
        trip-get-user-to \
        trip-goods-type \
        trip-order \
        trip-purchase \
        trip-school \
        trip-users \
        trip-release \
        trip-websocket \
        images_api \
        # go_server
}


#停止所有模块/项目
stop() {
    docker-compose stop 
}
#删除项目
rm() {
    docker-compose rm 
}
#构建项目
build() {
    docker-compose build 
}
# 根据输入参数，选择对应的方法，不输入执行使用说明
case "$1" in
    "base")
        base
        ;;
    "services")
        services
        ;;
    "stop")
        stop
        ;;
    "rm")
        rm
        ;;
    *)
        usage
        ;;
esac