package app

// Shared configuration for the FastAPI application
_config: {
	name:      "fastapi-app"
	namespace: "production"
	labels: {
		app:     "fastapi-app"
		env:     "production"
		version: "1.0.0"
	}
	image: "your-registry/fastapi-app:latest"
	port:  8000
}
