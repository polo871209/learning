package app

import "encoding/yaml"

// Collect all Kubernetes resources into a list
// Order matters: ConfigMap and Secret should be created before Deployment
// Note: PostgreSQL resources have been moved to apps/infra
_resources: [
	_namespace,
	_configMap,
	_secret,
	_deployment,
	_service,
]

// Export as YAML stream with --- separators
stream: yaml.MarshalStream(_resources)
