package platform

import core "cue.dev/x/k8s.io/api/core/v1"

// Kubernetes Namespace for platform resources
_namespace: core.#Namespace & {
	apiVersion: "v1"
	kind:       "Namespace"

	metadata: {
		name: _config.namespace
		labels: _config.labels & {
			"istio-injection": "enabled"
		}
	}
}

// Kubernetes Namespace for observability resources
_observabilityNamespace: core.#Namespace & {
	apiVersion: "v1"
	kind:       "Namespace"

	metadata: {
		name: "observability"
		labels: {
			"istio-injection": "enabled"
			"name":            "observability"
		}
	}
}
