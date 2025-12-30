package platform

import (
	servicemonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"
	podmonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"
)

// ServiceMonitor for Istio control plane (istiod) metrics
// Matches prometheus job: istiod with endpoints role discovery
_istiodServiceMonitor: servicemonitor.#ServiceMonitor & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"

	metadata: {
		name:      "istiod"
		namespace: "istio-system"
		labels: {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		// Match istiod service
		selector: matchLabels: {
			"app": "istiod"
		}
		namespaceSelector: matchNames: ["istio-system"]
		endpoints: [{
			port:     "http-monitoring"
			path:     "/metrics"
			interval: "15s"
		}]
	}
}

// PodMonitor for Istio Envoy sidecars and gateway proxies (data plane)
// Matches prometheus job: envoy-stats with pod role discovery
_envoyStatsPodMonitor: podmonitor.#PodMonitor & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "PodMonitor"

	metadata: {
		name:      "envoy-stats"
		namespace: "istio-system"
		labels: {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		// Match all pods across all namespaces
		selector: matchLabels: {}
		namespaceSelector: any: true
		podMetricsEndpoints: [{
			path:     "/stats/prometheus"
			interval: "15s"
			relabelings: [
				// Keep only pods with container ports ending in -envoy-prom
				{
					sourceLabels: ["__meta_kubernetes_pod_container_port_name"]
					action:       "keep"
					regex:        ".*-envoy-prom"
				},
			]
		}]
	}
}
