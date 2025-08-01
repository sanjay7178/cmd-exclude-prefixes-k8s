FROM golang:1.22.5 AS go
ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOBIN=/bin

FROM go AS build
ARG TARGETOS
ARG TARGETARCH
WORKDIR /build
COPY go.mod go.sum ./
# Download dependencies
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /bin/exclude-prefixes .

FROM build AS test
CMD go test -test.v ./...

FROM test AS debug
CMD echo "Debug stage - delve installation skipped due to sandbox TLS issue"

FROM alpine:3.20.1 AS runtime
COPY --from=build /bin/exclude-prefixes /bin/exclude-prefixes
ENTRYPOINT ["/bin/exclude-prefixes"]
