package postgres

import "encoding/yaml"

_resources: [
	_postgresSecret,
	_statefulSet,
	_service,
]

stream: yaml.MarshalStream(_resources) + "---"
