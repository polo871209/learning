build:
    @docker buildx bake

[working-directory: 'k8s']
debug package resource tag='dev':
    @cue export ./{{package}}/... --out yaml -e {{resource}} -t environment={{tag}}

[working-directory: 'k8s']
export package='apps/api' tag='dev':
    @cue export ./{{package}}/... --out text --expression stream -t environment={{tag}}

[working-directory: 'k8s']
apply package='apps/api' tag='dev':
    @just export {{package}} {{tag}} | kubectl apply -f -

# Show diff between CUE export and current cluster state
[working-directory: 'k8s']
diff  package='apps/api' tag='dev':
    #!/usr/bin/env bash
    set -euo pipefail
    just export {{package}} {{tag}} | \
        kubectl diff -f - 2>&1 | \
        sed '/last-applied-configuration/{N;d;}' | \
        grep -vE "(generation|neg-status|resourceVersion|uid|creationTimestamp):" | \
        sed -E $'s/^(\\+\\+\\+.*)$/\033[45m\033[1m\\1\033[22m\033[49m/' | \
        sed -E $'s/^(---.*)$/\033[44m\033[1m\\1\033[22m\033[49m/' | \
        sed -E $'s/^(-.*)$/\033[31m\\1\033[39m/' | \
        sed -E $'s/^(\\+.*)$/\033[32m\\1\033[39m/' | \
        bat -p -l diff || true

[working-directory: 'k8s/helm']
helm-install:
    @helm install istio-base istio/base -n istio-system --version 1.28.3
    @helm install istiod istio/istiod -n istio-system --wait --version 1.28.3 --values istiod/values.yaml
    @helm install kube-prometheus-stack oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n observability --wait --values kube-prometheus-stack/values.yaml

[working-directory: 'k8s/helm']
helm-upgrade:
	@helm upgrade kube-prometheus-stack oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n observability --values kube-prometheus-stack/values.yaml
	@helm upgrade istiod oci://ghcr.io/prometheus-community/charts/kube-prometheus-stack -n istio-system --values istiod/values.yaml
