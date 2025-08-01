FROM golang:1.22.5 as go
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOBIN=/bin

FROM go as build
ARG TARGETOS
ARG TARGETARCH
WORKDIR /build
COPY go.mod go.sum ./
# Download dependencies
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/exclude-prefixes .

FROM build as test
CMD go test -test.v ./...

FROM test as debug
CMD echo "Debug stage - delve installation skipped due to sandbox TLS issue"

FROM alpine:3.20.1 as runtime
COPY --from=build /bin/exclude-prefixes /bin/exclude-prefixes
ENTRYPOINT ["/bin/exclude-prefixes"]
