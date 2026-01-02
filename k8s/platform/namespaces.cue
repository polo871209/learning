package platform

import core "cue.dev/x/k8s.io/api/core/v1"

_istio_label: {
	"istio-injection": "enabled"
}

// List of all namespace resources
_namespaces: [...core.#Namespace] & [
	{
		metadata: {
			name:   _config.namespace
			labels: _istio_label
		}
	},
	{
		metadata: {
			name: "observability"
		}
	},
	{
		metadata: {
			name:   "istio-system"
			labels: _istio_label
		}
	},
	{
		metadata: {
			name:   "app"
			labels: _istio_label
		}

	},
]
