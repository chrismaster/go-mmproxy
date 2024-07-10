FROM golang as builder

WORKDIR /go/app

#RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOBIN=/go/app go install github.com/path-network/go-mmproxy@latest
#RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOBIN=/go/app go install github.com/kzemek/go-mmproxy@ba4d783
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GOBIN=/go/app go install github.com/kzemek/go-mmproxy@latest

FROM alpine:latest

RUN apk --no-cache add iptables iproute2

ENV in_port 9010
ENV out_port 8080
ENV logs 2

WORKDIR /go

COPY --from=builder /go/app .

WORKDIR /conf

COPY allowed-subnets.txt .

COPY startup.sh .

ENTRYPOINT ["sh", "-x", "/conf/startup.sh"]
