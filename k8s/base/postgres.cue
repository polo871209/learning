package base

import core "cue.dev/x/k8s.io/api/core/v1"

#PostgresSecret: core.#Secret & {
	apiVersion: "v1"
	kind:       "Secret"
	type:       "Opaque"

	metadata: {
		name:      "postgres-credentials"
		namespace: string
		labels: {...}
	}

	stringData: {
		POSTGRES_DB:       "platformdb"
		POSTGRES_USER:     "postgres"
		POSTGRES_PASSWORD: "postgres"
		DATABASE_URL:      "postgresql://\(POSTGRES_USER):\(POSTGRES_PASSWORD)@postgres.platform.svc.cluster.local:5432/\(POSTGRES_DB)"
	}
}
