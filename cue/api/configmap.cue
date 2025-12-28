package app

import core "cue.dev/x/k8s.io/api/core/v1"

// ConfigMap for non-sensitive environment variables
_configMap: core.#ConfigMap & {
	apiVersion: "v1"
	kind:       "ConfigMap"

	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels: {
			app:          _config.labels.app
			"managed-by": "cue"
		}
	}

	data: {
		// Application settings
		APP_NAME:   "FastAPI PostgreSQL API"
		DEBUG:      "false"
		API_PREFIX: "/api/v1"

		// Database pool settings
		DB_POOL_SIZE:    "10"
		DB_MAX_OVERFLOW: "20"
		DB_POOL_TIMEOUT: "30"

		// PostgreSQL database name
		POSTGRES_DB: "mydb"

		// Database host (service name)
		DATABASE_HOST: "postgres.\(_config.namespace).svc.cluster.local"
		DATABASE_PORT: "5432"
	}
}
