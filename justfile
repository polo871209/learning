# List available commands
default:
    @just --list

# Build application Docker image
build-app:
    @cd api && docker build --target app -t api:local .
    @echo "✓ Application image built: api:local"

# Build migration Docker image
build-migrations:
    @cd api && docker build --target migrations -t api-migrations:local .
    @echo "✓ Migration image built: api-migrations:local"

# Build both Docker images
build: build-app build-migrations
    @echo "✓ All images built successfully"

# Validate all CUE configurations
vet:
    @cd k8s && cue vet ./...
    @echo "✓ All configurations valid"

# Validate specific app
vet-app app:
    @cd k8s && cue vet ./apps/{{app}}/...
    @echo "✓ {{app}} configuration valid"

# Export specific app to YAML with --- separators
[working-directory: 'k8s']
export app:
    @cue export ./{{app}}/. --out text --expression stream | bat -l yaml

[working-directory: 'k8s']
apply app: build
    @cue export ./{{app}}/. --out text --expression stream | kubectl apply -f -

[working-directory: 'k8s']
delete app:
    @cue export ./{{app}}/. --out text --expression stream | kubectl delete -f -

helm-install-istio:
    @helm install istio-base istio/base --namespace istio-system --create-namespace --version 1.28.2
    @helm install istiod istio/istiod --namespace istio-system --wait --version 1.28.2
    @echo "✓ Istio installation complete"

helm-install-prometheus:
    @helm install kube-prometheus-stack oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack --namespace observability --create-namespace --wait
    @echo "✓ kube-prometheus-stack installation complete"

[working-directory: 'k8s/helm/kube-prometheus-stack']
helm-upgrade:
	@helm upgrade kube-prometheus-stack oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n observability --values values.yaml
