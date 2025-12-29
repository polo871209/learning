package platform

import core "cue.dev/x/k8s.io/api/core/v1"

// Kubernetes Service for PostgreSQL
_postgresService: core.#Service & {
	apiVersion: "v1"
	kind:       "Service"

	metadata: {
		name:      _config.postgres.name
		namespace: _config.namespace
		labels:    _config.labels & _config.postgres.labels
	}

	spec: {
		selector: _config.postgres.labels

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
