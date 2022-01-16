FROM golang:alpine3.15 as build
ENV CGO_ENABLED=0
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct
RUN apk add git gcc \
    && mkdir /app \
    && cd /app \
    && git clone https://github.com/xzclinux/httpserver.git \
    && cd httpserver \
    && go build -o httpserver main.go

FROM busybox 
COPY --from=build /app/httpserver /app/httpserver
EXPOSE 8088 
WORKDIR /app/
CMD ["/bin/bash","-c","/app/httpserver"]
