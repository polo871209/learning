package platform

import base "github.com/polo871209/learning/definitions"

// Secret for PostgreSQL credentials
_postgresSecret: base.#PostgresSecret & {
	metadata: {
		name:      _config.secret
		namespace: _config.namespace
		labels: _config.labels & {
			app: "postgres"
		}
	}
}
