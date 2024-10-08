FROM alpine:3.20.3

RUN apk add --no-cache bash p7zip

COPY pack.sh /pack.sh

ENTRYPOINT ["/pack.sh"]
