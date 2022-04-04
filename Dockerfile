FROM golang:1.17 AS build
WORKDIR /httpserver/
COPY . .
ENV CGO_ENABLED=0
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.cn,direct
RUN cd src && GOOS=linux go build -installsuffix cgo -o httpserver main.go

FROM busybox
COPY --from=build //httpserver/src/httpserver /httpserver/httpserver
EXPOSE 8360
ENV ENV local
WORKDIR /httpserver/
ENTRYPOINT ["./httpserver"]