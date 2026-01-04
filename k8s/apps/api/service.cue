package api

import core "cue.dev/x/k8s.io/api/core/v1"

_service: core.#Service & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels:    _config.labels
	}

	spec: {
		selector: app: _config.labels.app

		ports: [{
			name:       "http"
			protocol:   "TCP"
			port:       _config.port
			targetPort: _config.port
		}]

		sessionAffinity: "None"
	}
}
