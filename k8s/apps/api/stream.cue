package api

import "encoding/yaml"

// Collect all Kubernetes resources into a list
// ConfigMap should be created before Deployment for environment variables
_resources: [
	_namespace,
	_configMap,
	_postgresSecret,
	_deployment,
	_service,
	_sidecar,
	_serviceMonitor,
]

// Export as YAML stream with --- separators
stream: yaml.MarshalStream(_resources)
