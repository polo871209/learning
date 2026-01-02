[working-directory: 'api']
build-app:
    @docker build --target app -t api:local .
    @echo "✓ Application image built: api:local"

[working-directory: 'api']
build-migrations:
    @docker build --target migrations -t api-migrations:local .
    @echo "✓ Migration image built: api-migrations:local"

build: build-app build-migrations
    @echo "✓ All images built successfully"

[working-directory: 'k8s']
export package:
    @cue export ./{{package}}/... --out text --expression stream

[working-directory: 'k8s']
debug package resource:
    @cue export ./{{package}}/... --out yaml -e {{resource}}

[working-directory: 'k8s']
apply package:
    @cue export ./{{package}}/... --out text --expression stream | kubectl apply -f -

[working-directory: 'k8s']
delete package:
    @cue export ./{{package}}/... --out text --expression stream | kubectl delete -f -

# Show diff between CUE export and current cluster state
[working-directory: 'k8s']
diff app:
    #!/usr/bin/env bash
    set -euo pipefail
    cue export ./{{app}}/... --out text --expression stream | \
        kubectl diff -f - 2>&1 | \
        sed '/last-applied-configuration/{N;d;}' | \
        grep -vE "(generation|neg-status|resourceVersion|uid|creationTimestamp):" | \
        sed -E $'s/^(\\+\\+\\+.*)$/\033[45m\033[1m\\1\033[22m\033[49m/' | \
        sed -E $'s/^(---.*)$/\033[44m\033[1m\\1\033[22m\033[49m/' | \
        sed -E $'s/^(-.*)$/\033[31m\\1\033[39m/' | \
        sed -E $'s/^(\\+.*)$/\033[32m\\1\033[39m/' | \
        bat -p -l diff || true

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
