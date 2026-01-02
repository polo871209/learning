package postgres

import base "github.com/polo871209/learning/base"

// Secret for PostgreSQL credentials
_postgresSecret: base.#PostgresSecret & {
	metadata: {
		namespace: _config.namespace
		labels:    _config.labels
	}
}
