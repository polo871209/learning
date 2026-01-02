package platform

import (
	"encoding/yaml"
	"list"
)

_resources: list.Concat([
	_namespaces,
	[
		_istiodServiceMonitor,
		_envoyStatsPodMonitor,
	],
])

stream: yaml.MarshalStream(_resources) + "---"
