package api

import servicemonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"

// ServiceMonitor for Prometheus scraping
_serviceMonitor: servicemonitor.#ServiceMonitor & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"

	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels: _config.labels & {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		// Select the service to monitor
		selector: matchLabels: {
			app: _config.labels.app
		}

		// Endpoint configuration for scraping
		endpoints: [{
			port:     "http"
			path:     "/metrics"
			interval: "30s"
			scheme:   "http"
		}]
	}
}
