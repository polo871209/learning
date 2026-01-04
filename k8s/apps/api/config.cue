package api

_config: {
	name:      "api"
	namespace: "app"
	labels: {
		app: _config.name
	}
	image:          "api:local"
	migrationImage: "api-migrations:local"
	port:           8000
}
