package platform

import (
	servicemonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"
	podmonitor "github.com/polo871209/learning/base/crds/prometheus_operator/v1"
)

_istiodServiceMonitor: servicemonitor.#ServiceMonitor & {
	metadata: {
		name:      "istiod"
		namespace: "istio-system"
		labels: {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		selector: matchLabels: {
			"app": "istiod"
		}
		namespaceSelector: matchNames: ["istio-system"]
		endpoints: [{
			port:     "http-monitoring"
			path:     "/metrics"
			interval: "15s"
			metricRelabelings: [
				{
					sourceLabels: ["__name__"]
					action: "drop"
					regex:  "pilot_xds_(cds|eds|lds|rds)_reject.*"
				},
				{
					sourceLabels: ["__name__"]
					action: "drop"
					regex:  "pilot_duplicate_envoy_clusters"
				},
			]
		}]
	}
}

_envoyStatsPodMonitor: podmonitor.#PodMonitor & {
	metadata: {
		name:      "envoy-stats"
		namespace: "istio-system"
		labels: {
			"release": "kube-prometheus-stack"
		}
	}

	spec: {
		selector: matchLabels: {}
		namespaceSelector: any: true
		podMetricsEndpoints: [{
			path:     "/stats/prometheus"
			interval: "15s"
			relabelings: [
				{
					sourceLabels: ["__meta_kubernetes_pod_container_port_name"]
					action: "keep"
					regex:  ".*-envoy-prom"
				},
			]
			metricRelabelings: [
				{
					sourceLabels: ["__name__"]
					action: "keep"
					regex:  "(istio_requests_total|istio_request_duration_milliseconds_.*|istio_request_bytes_.*|istio_response_bytes_.*|istio_tcp_.*|envoy_cluster_upstream_cx_.*|envoy_cluster_upstream_rq_.*|envoy_cluster_membership_.*|envoy_cluster_circuit_breakers_.*|envoy_server_memory_.*|envoy_server_live|envoy_server_uptime)"
				},
				{
					action: "labeldrop"
					regex:  "(destination_version|destination_principal|source_version|source_principal|destination_cluster|source_cluster|connection_security_policy)"
				},
				{
					action: "labeldrop"
					regex:  "(destination_workload|destination_workload_namespace|source_workload|source_workload_namespace)"
				},
				{
					action: "labeldrop"
					regex:  "instance"
				},
				{
					action: "labeldrop"
					regex:  "container"
				},
			]
		}]
	}
}
