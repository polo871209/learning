# List available commands
default:
    @just --list

# Build application Docker image
build-app:
    @cd api && docker build --target app -t fastapi:local .
    @echo "✓ Application image built: fastapi:local"

# Build migration Docker image
build-migrations:
    @cd api && docker build --target migrations -t fastapi-migrations:local .
    @echo "✓ Migration image built: fastapi-migrations:local"

# Build both Docker images
build: build-app build-migrations
    @echo "✓ All images built successfully"

# Validate all CUE configurations
vet:
    @cd cue && cue vet ./...
    @echo "✓ All configurations valid"

# Validate specific app
vet-app app:
    @cd cue && cue vet ./apps/{{app}}/...
    @echo "✓ {{app}} configuration valid"

# Export specific app to YAML with --- separators
[working-directory: 'cue']
export app:
    @cue export ./{{app}}/. --out text --expression stream

[working-directory: 'cue']
apply app: build
    @cue export ./{{app}}/. --out text --expression stream | kubectl apply -f -

[working-directory: 'cue']
delete app:
    @cue export ./{{app}}/. --out text --expression stream | kubectl delete -f -

# Install Istio (base and istiod)
helm-install-istio:
    @helm install istio-base istio/base --namespace istio-system --create-namespace --version 1.28.2
    @helm install istiod istio/istiod --namespace istio-system --wait --version 1.28.2
    @echo "✓ Istio installation complete"
