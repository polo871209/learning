package postgres

// Shared configuration for infrastructure resources
_config: {
	name:      "postgres"
	namespace: "platform"
	labels: {
		app:  "postgres"
		tier: "platform"
	}
}
