package platform

import servicemonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"

// ServiceMonitor for Istio control plane (istiod) metrics
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
		selector: matchLabels: {
			"app":   "istiod"
			"istio": "pilot"
		}
		namespaceSelector: matchNames: ["istio-system"]
		endpoints: [{
			port:     "http-monitoring"
			path:     "/metrics"
			interval: "15s"
		}]
	}
}

// ServiceMonitor for Istio Envoy sidecars (data plane) - using istio-proxy service
_istioProxyServiceMonitor: servicemonitor.#ServiceMonitor & {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ServiceMonitor"

	metadata: {
		name:      "envoy-stats"
		namespace: "istio-system"
		labels: {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		selector: matchLabels: {
			"service.istio.io/canonical-name": ""
		}
		namespaceSelector: any: true
		endpoints: [{
			port:     "http-envoy-prom"
			path:     "/stats/prometheus"
			interval: "15s"
			relabelings: [
				{
					sourceLabels: ["__meta_kubernetes_service_label_service_istio_io_canonical_name"]
					action: "keep"
					regex:  ".+"
				},
				{
					sourceLabels: ["__meta_kubernetes_endpoint_address_target_name"]
					targetLabel: "pod"
				},
				{
					sourceLabels: ["__meta_kubernetes_namespace"]
					targetLabel: "namespace"
				},
				{
					sourceLabels: ["__meta_kubernetes_service_name"]
					targetLabel: "service"
				},
			]
		}]
	}
}
