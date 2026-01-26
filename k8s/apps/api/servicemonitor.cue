package api

import servicemonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"

_serviceMonitor: servicemonitor.#ServiceMonitor & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels: _config.labels & {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		selector: matchLabels: {
			app: _config.labels.app
		}

		endpoints: [{
			port:     "http"
			path:     "/metrics"
			interval: "30s"
			scheme:   "http"
			metricRelabelings: [
				// Drop ALL metrics for /metrics endpoint
				{
					sourceLabels: ["http_target"]
					action: "drop"
					regex:  "/metrics"
				},
				// Drop ALL metrics for /health endpoint
				{
					sourceLabels: ["http_target"]
					action: "drop"
					regex:  "/health"
				},
				{
					sourceLabels: ["__name__", "path"]
					action: "drop"
					regex:  "api_request_duration_seconds.*;/favicon\\.ico"
				},
			]
		}]
	}
}
