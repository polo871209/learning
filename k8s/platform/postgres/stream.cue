package postgres

import "encoding/yaml"

_environment: string | *"dev" @tag(environment)

_resources: [
	_postgresSecret,
	_statefulSet,
	_service,
	_destinationRule,
]

stream: yaml.MarshalStream(_resources) + "---"
