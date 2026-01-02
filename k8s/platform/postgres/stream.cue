package postgres

import "encoding/yaml"

_resources: [
	_postgresSecret,
	_statefulSet,
	_service,
	_destinationRule,
]

stream: yaml.MarshalStream(_resources) + "---"
