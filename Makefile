SERVICE ?= service
HOOKS_DIR ?= .git/hooks
GOLANGCI_LINT ?= golangci-lint
GOSEC ?= gosec

.PHONY: build test test-race test-integration lint vet security run fmt install-hooks docker-build

build:
	go build ./...

test:
	go test ./... -count=1

test-race:
	go test ./... -race -count=1

test-integration:
	go test ./... -count=1 -tags integration

lint:
	$(GOLANGCI_LINT) run ./...

vet:
	go vet ./...

security:
	$(GOSEC) ./...

run:
	go run ./cmd/$(SERVICE)

fmt:
	go fmt ./...

install-hooks:
	mkdir -p $(HOOKS_DIR)
	install -m 0755 scripts/pre-commit $(HOOKS_DIR)/pre-commit

docker-build:
	docker build -t $(SERVICE):dev .
