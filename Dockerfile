FROM crosbymichael/golang

ADD . /go/src/github.com/tonistiigi/dnsdock

ENV CGO_ENABLED 0

RUN cd /go/src/github.com/tonistiigi/dnsdock && \
    go get -d ./... && \
    go install -a -ldflags "-X main.version `git describe --tags HEAD``if [[ -n $(command git status --porcelain --untracked-files=no 2>/dev/null) ]]; then echo "-dirty"; fi`" ./...

BUILD /go/bin

FROM scratch

ADD dnsdock /

ENTRYPOINT ["/dnsdock"]
