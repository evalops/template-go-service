# template-go-service

Template repository for new EvalOps Go microservices. Use GitHub's "Use this template" button to scaffold a new service.

## Getting started

1. Click **Use this template** on GitHub to create a new repo from this template.
2. Clone your new repo and update the following:
   - `go.mod` — change the module path to `github.com/evalops/<your-service>`.
   - `Dockerfile` — replace `service` in the build path and binary name with your service name.
   - `.github/workflows/ghcr-publish.yml` — update `IMAGE_NAME` to `ghcr.io/evalops/<your-service>`.
   - `main.go` — move to `cmd/<your-service>/main.go` if you prefer the multi-binary layout. Update the Dockerfile build path to match.
3. Run `go mod tidy` to resolve dependencies.
4. Push to `main` — CI will run tests and the GHCR workflow will build (but not push) the image on PRs.

## What's included

| File | Purpose |
|---|---|
| `main.go` | Minimal entry point with health check via service-runtime |
| `Dockerfile` | Multi-stage build using the shared Go builder image |
| `.github/workflows/ci.yml` | Lint, test, build via `setup-go-service` composite action |
| `.github/workflows/ghcr-publish.yml` | Build and publish container image to GHCR |
| `.github/CODEOWNERS` | Default review assignments |
| `.github/dependabot.yml` | Automated dependency updates for Go, Actions, and Docker |

## Standards

- All services use [evalops/service-runtime](https://github.com/evalops/service-runtime) for health checks, observability, mTLS, and NATS integration.
- CI uses the `setup-go-service` composite action from service-runtime.
- Container images are published to GHCR via the `publish-ghcr-image` composite action.
