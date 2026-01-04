package api

import "encoding/yaml"

_environment: string | *"dev" @tag(environment)

_resources: [
	_configMap,
	_postgresSecret,
	_deployment,
	_service,
	_sidecar,
	_serviceMonitor,
]

stream: yaml.MarshalStream(_resources) + "---"
