package app

import core "cue.dev/x/k8s.io/api/core/v1"

// Secret for sensitive data (passwords, credentials)
// NOTE: In production, use external secret management (e.g., sealed-secrets, external-secrets, Vault)
_secret: core.#Secret & {
	apiVersion: "v1"
	kind:       "Secret"

	metadata: {
		name:      "api-secrets"
		namespace: _config.namespace
		labels: {
			app:        _config.labels.app
			env:        _config.labels.env
			"managed-by": "cue"
		}
	}

	type: "Opaque"

	// Base64 encoded values
	// IMPORTANT: These are example values. Replace with actual base64-encoded secrets
	// To encode: echo -n "your-value" | base64
	stringData: {
		// PostgreSQL credentials
		POSTGRES_USER:     "postgres"
		POSTGRES_PASSWORD: "postgres"

		// Full database URL for the API
		// Format: postgresql://user:password@host:port/database
		DATABASE_URL: "postgresql://postgres:postgres@postgres.\(_config.namespace).svc.cluster.local:5432/mydb"
	}
}
