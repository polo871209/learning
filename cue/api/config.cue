package app

// Shared configuration for the FastAPI application
_config: {
	name:      "fastapi"
	namespace: "app"
	labels: {
		app: _config.name
	}
	image: "fastapi:local"
	port:  8000
}
