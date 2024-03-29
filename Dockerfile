FROM golang:latest AS builder
ADD . /src
WORKDIR /src
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /src/app .
CMD ["./app"]