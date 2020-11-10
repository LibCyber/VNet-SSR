FROM golang as builder
ENV CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64
RUN apt update && apt install git -y 
RUN git clone https://github.com/LibCyber/VNet-SSR.git /usr/local/go/src/github.com/LibCyber/VNet-SSR
RUN  cd  /usr/local/go/src/github.com/LibCyber/VNet-SSR && \
    go build -ldflags "-s -w" -o bin/linux/vnet cmd/shadowsocksr-server/main.go

FROM alpine:3.8
ARG TZ="Asia/Shanghai"

ENV TZ ${TZ}
ENV API_HOST=http://baidu.com \
    KEY=geptpxzp8zwdatc5 \
    NODE_ID=1

RUN apk upgrade --update \
    && apk add bash tzdata \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && rm -rf /var/cache/apk/*
COPY --from=builder /usr/local/go/src/github.com/LibCyber/VNet-SSR/bin/linux/vnet /usr/bin/vnet/vnet

WORKDIR /usr/bin/vnet/

CMD /usr/bin/vnet/vnet --api_host API_HOST --key KEY --node_id NODE_ID