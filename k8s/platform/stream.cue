package platform

import "encoding/yaml"

// Collect all infrastructure resources into a list
_resources: [
	_namespace,
	_observabilityNamespace,
	_postgresSecret,
	_postgres,
	_postgresService,
	_istiodServiceMonitor,
	_istioProxyServiceMonitor,
]

// Export as YAML stream with --- separators
stream: yaml.MarshalStream(_resources)
