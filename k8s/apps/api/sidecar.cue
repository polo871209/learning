package api

import istio "github.com/polo871209/learning/base/crds/istio/v1"

// Istio Sidecar configuration for Unix Domain Socket communication
_sidecar: istio.#Sidecar & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels:    _config.labels
	}

	spec: {
		// Select pods with matching labels
		workloadSelector: {
			labels: app: _config.labels.app
		}

		// Configure ingress to forward traffic from Istio proxy to app via Unix socket
		ingress: [{
			port: {
				number:   _config.port
				protocol: "HTTP"
				name:     "http"
			}
			// Forward traffic to Unix Domain Socket
			defaultEndpoint: "unix:///var/run/app.sock"
		}]
	}
}
