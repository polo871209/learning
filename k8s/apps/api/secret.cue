package app

import base "github.com/polo871209/learning/base"

// Secret for sensitive data - reuses platform postgres secret definition
// NOTE: In production, use external secret management (e.g., sealed-secrets, external-secrets, Vault)
_secret: base.#PostgresSecret & {
	metadata: {
		namespace: _config.namespace
		labels: {
			app: _config.labels.app
		}
	}
}
