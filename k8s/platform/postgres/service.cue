package postgres

import core "cue.dev/x/k8s.io/api/core/v1"

_service: core.#Service & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels:    _config.labels
	}

	spec: {
		selector: _config.labels

		ports: [{
			name:       "postgres"
			protocol:   "TCP"
			port:       5432
			targetPort: 5432
		}]

		clusterIP: "None"
	}
}
