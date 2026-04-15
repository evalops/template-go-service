ARG GO_BUILDER_IMAGE=ghcr.io/evalops/service-runtime-go-builder:go1.26
FROM ${GO_BUILDER_IMAGE} AS builder

WORKDIR /src

RUN apk add --no-cache ca-certificates git

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 \
	go build -trimpath -ldflags="-s -w" -o /out/service ./cmd/service

FROM alpine:3.23

RUN apk add --no-cache ca-certificates tzdata

COPY --from=builder /out/service /service

USER nobody

EXPOSE 8080

ENTRYPOINT ["/service"]
