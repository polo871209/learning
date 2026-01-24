package api

import core "cue.dev/x/k8s.io/api/core/v1"

_configMap: core.#ConfigMap & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels: {
			app: _config.labels.app
		}
	}

	data: {
		APP_NAME:   "FastAPI PostgreSQL API"
		DEBUG:      "false"
		API_PREFIX: "/api/v1"

		DB_POOL_SIZE:    "10"
		DB_MAX_OVERFLOW: "20"
		DB_POOL_TIMEOUT: "30"

		POSTGRES_DB: "mydb"

		DATABASE_HOST: "postgres.\(_config.namespace).svc.cluster.local."
		DATABASE_PORT: "5432"
	}
}
