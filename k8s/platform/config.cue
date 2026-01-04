package platform

_environment: string | *"dev" @tag(environment)

_config: {
	namespace: "platform"
	labels: {
		tier: "platform"
	}
}
