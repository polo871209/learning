package platform

// Exported postgres secret name for use by applications
PostgresSecretName: "postgres-credentials"

// Shared configuration for infrastructure resources
_config: {
	namespace: "platform"
	labels: {
		tier: "platform"
	}
	secret: PostgresSecretName
}
