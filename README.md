# template-go-service

Template repository for new EvalOps Go microservices. Use GitHub's "Use this template" button to scaffold a new service.

## Getting started

1. Click **Use this template** on GitHub to create a new repo from this template.
2. Clone your new repo and update the following:
   - `go.mod` — change the module path to `github.com/evalops/<your-service>`.
   - `cmd/service` — rename the package directory to `cmd/<your-service>` if you want the generated binary and `make run` target to use your service name directly.
   - `Dockerfile` — replace `service` in the build path and binary name with your service name.
   - `Makefile` — update `SERVICE ?= service` to your service name.
   - `.github/workflows/ghcr-publish.yml` — update `IMAGE_NAME` to `ghcr.io/evalops/<your-service>`.
3. Run `go mod tidy` to resolve dependencies.
4. Run `make install-hooks` if you want the template pre-commit checks locally.
5. Push to `main` — CI will run vet, lint, gosec, tests, race tests, and the GHCR workflow will build (but not push) the image on PRs.

## What's included

| File | Purpose |
|---|---|
| `cmd/service/main.go` | Default service entry point wired for `make run` and Docker builds |
| `Makefile` | Standard local build/test/lint/run targets plus hook installation |
| `.golangci.yml` | Baseline org linter configuration for new Go services |
| `docker-compose.yml` | Local Postgres + Redis stack with an app container for development |
| `scripts/pre-commit` | Git hook that formats staged Go files and runs baseline checks |
| `Dockerfile` | Multi-stage build using the shared Go builder image |
| `.github/workflows/ci.yml` | Vet, lint, gosec, test, race test, and build via `setup-go-service` |
| `.github/workflows/ghcr-publish.yml` | Build and publish container image to GHCR |
| `.github/CODEOWNERS` | Default review assignments |
| `.github/dependabot.yml` | Automated dependency updates for Go, Actions, and Docker |

## Standards

- All services use [evalops/service-runtime](https://github.com/evalops/service-runtime) for health checks, observability, mTLS, and NATS integration.
- CI uses the `setup-go-service` composite action from service-runtime.
- Container images are published to GHCR via the `publish-ghcr-image` composite action.

## Local workflow

- `make build` builds all packages.
- `make test` runs the default unit test suite.
- `make test-integration` runs tests behind the `//go:build integration` tag pattern.
- `make lint`, `make vet`, and `make security` mirror the CI quality gates.
- `docker compose up --build` starts the template service with Postgres and Redis for local development.
