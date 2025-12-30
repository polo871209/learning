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
			// Keep only essential Istio control plane metrics
			metricRelabelings: [
				// Drop pilot internal metrics (not needed for basic monitoring)
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
				// Keep critical metrics:
				// - pilot_proxy_convergence_time (sidecar config propagation)
				// - galley_validation_* (config validation)
				// - pilot_conflict_* (configuration conflicts)
				// All other pilot_* metrics will be kept by default
			]
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
					action: "keep"
					regex:  ".*-envoy-prom"
				},
			]
			// Keep only essential Envoy metrics to reduce cardinality
			metricRelabelings: [
				// Keep only critical Envoy metrics
				{
					sourceLabels: ["__name__"]
					action: "keep"
					regex:  "(istio_requests_total|istio_request_duration_milliseconds_.*|istio_request_bytes_.*|istio_response_bytes_.*|istio_tcp_.*|envoy_cluster_upstream_cx_.*|envoy_cluster_upstream_rq_.*|envoy_cluster_membership_.*|envoy_cluster_circuit_breakers_.*|envoy_server_memory_.*|envoy_server_live|envoy_server_uptime)"
				},
				// Drop unnecessary high-cardinality labels from Istio metrics
				{
					action: "labeldrop"
					regex:  "(destination_version|destination_principal|source_version|source_principal|destination_cluster|source_cluster|connection_security_policy)"
				},
				// Drop redundant workload labels (keep only canonical service)
				{
					action: "labeldrop"
					regex:  "(destination_workload|destination_workload_namespace|source_workload|source_workload_namespace)"
				},
				// Drop instance IP addresses (keep pod name instead)
				{
					action: "labeldrop"
					regex:  "instance"
				},
				// Drop container label (always istio-proxy)
				{
					action: "labeldrop"
					regex:  "container"
				},
			]
		}]
	}
}
