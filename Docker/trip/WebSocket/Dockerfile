# FROM golang:1.22.3
FROM golang:1.22.3-alpine

# Set destination for COPY
WORKDIR /app

RUN mkdir -p ./conf
#复制配置文件到容器中
COPY ./conf/app.ini ./conf/app.ini

COPY main .
 
RUN chmod a+x main
# Run
CMD ["/app/main"]


