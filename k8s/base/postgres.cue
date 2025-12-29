package base

import core "cue.dev/x/k8s.io/api/core/v1"

// PostgreSQL configuration values
// This allows sharing credentials between platform and api namespaces
#PostgresConfig: {
	db:       "platformdb"
	user:     "postgres"
	password: "postgres"
	host:     "postgres.platform.svc.cluster.local"
	port:     "5432"

	// Computed connection string
	connectionString: "postgresql://\(user):\(password)@\(host):\(port)/\(db)"
}

// PostgreSQL secret template
// Can be reused across namespaces by overriding metadata
#PostgresSecret: core.#Secret & {
	apiVersion: "v1"
	kind:       "Secret"
	type:       "Opaque"

	// Must be provided by consumer
	metadata: {
		name:      "postgres-credentials"
		namespace: string
		labels: {...}
	}

	// Shared postgres configuration
	let _pgConfig = #PostgresConfig

	stringData: {
		POSTGRES_DB:       _pgConfig.db
		POSTGRES_USER:     _pgConfig.user
		POSTGRES_PASSWORD: _pgConfig.password
		DATABASE_URL:      _pgConfig.connectionString
	}
}
