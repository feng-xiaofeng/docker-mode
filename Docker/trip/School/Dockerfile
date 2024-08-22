# FROM golang:1.22.3
FROM golang:1.22.3-alpine

# Set destination for COPY
WORKDIR /app

RUN mkdir -p ./conf
#复制配置文件到容器中
COPY ./conf/app.ini ./conf/app.ini

# Download Go modules
# COPY go.mod go.sum ./

# RUN go env -w GOPROXY=https://goproxy.cn,direct

# RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/reference/dockerfile/#copy


COPY main .
 
RUN chmod a+x main
# Run
CMD ["/app/main"]


