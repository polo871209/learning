package platform

import "encoding/yaml"

// Collect all infrastructure resources into a list
_resources: [
	_namespace,
	_postgresSecret,
	_postgres,
	_postgresService,
]

// Export as YAML stream with --- separators
stream: yaml.MarshalStream(_resources)
