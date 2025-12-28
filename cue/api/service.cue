package app

import core "cue.dev/x/k8s.io/api/core/v1"

// Kubernetes Service for FastAPI application
_service: core.#Service & {
	apiVersion: "v1"
	kind:       "Service"

	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels: _config.labels & {
			"managed-by": "cue"
		}
	}

	spec: {
		selector: app: _config.labels.app

		ports: [{
			name:       "http"
			protocol:   "TCP"
			port:       8000
			targetPort: _config.port
		}]

		type: "ClusterIP"

		// Optional: session affinity for sticky sessions
		sessionAffinity: "None"
	}
}
