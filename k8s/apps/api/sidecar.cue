package api

import istio "github.com/polo871209/learning/base/crds/istio/v1"

_sidecar: istio.#Sidecar & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels:    _config.labels
	}

	spec: {
		workloadSelector: {
			labels: app: _config.labels.app
		}

		ingress: [{
			port: {
				number:   _config.port
				protocol: "HTTP"
				name:     "http"
			}
			defaultEndpoint: "unix:///var/run/app.sock"
		}]
	}
}
