package platform

import core "cue.dev/x/k8s.io/api/core/v1"

// Kubernetes Service for PostgreSQL
_postgresService: core.#Service & {
	apiVersion: "v1"
	kind:       "Service"

	metadata: {
		name:      "postgres"
		namespace: _config.namespace
		labels: _config.labels & {
			app: "postgres"
		}
	}

	spec: {
		selector: app: "postgres"

		ports: [{
			name:       "postgres"
			protocol:   "TCP"
			port:       5432
			targetPort: 5432
		}]

		type: "ClusterIP"

		// Headless service for StatefulSet
		clusterIP: "None"
	}
}
