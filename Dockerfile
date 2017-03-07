FROM alpine:3.4

ENV GOPATH="/tmp/go"

ADD . "$GOPATH/src/github.com/aacebedo/dnsdock"

RUN apk --no-cache add --virtual build-deps go make git && \
    go get github.com/tools/godep && \
    go get github.com/ahmetb/govvv && \
    cd "$GOPATH/src/github.com/aacebedo/dnsdock" && \
    "$GOPATH/bin/godep" restore && \
    cd src && \
    "$GOPATH/bin/govvv" build -o /usr/bin/dnsdock -ldflags "-w -s" && \
    apk del build-deps && \
    rm -rf "$GOPATH"

ENTRYPOINT [ "dnsdock" ]
