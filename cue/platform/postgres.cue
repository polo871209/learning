package platform

import apps "cue.dev/x/k8s.io/api/apps/v1"

// PostgreSQL StatefulSet for persistent database
_postgres: apps.#StatefulSet & {
	apiVersion: "apps/v1"
	kind:       "StatefulSet"

	metadata: {
		name:      "postgres"
		namespace: _config.namespace
		labels: _config.labels & {
			app: "postgres"
		}
	}

	spec: {
		serviceName: "postgres"
		replicas:    1

		selector: matchLabels: app: "postgres"

		template: {
			metadata: labels: app: "postgres"

			spec: {
				// Security context at pod level
				securityContext: {
					runAsNonRoot:        true
					runAsUser:           999 // postgres user UID
					runAsGroup:          999
					fsGroup:             999
					fsGroupChangePolicy: "OnRootMismatch"
					seccompProfile: type: "RuntimeDefault"
				}

				containers: [{
					name:  "postgres"
					image: "postgres:16-alpine"

					ports: [{
						name:          "postgres"
						containerPort: 5432
						protocol:      "TCP"
					}]

					// Environment variables from ConfigMap and Secret
					env: [
						{
							name: "POSTGRES_DB"
							valueFrom: configMapKeyRef: {
								name: "api-config"
								key:  "POSTGRES_DB"
							}
						},
						{
							name: "POSTGRES_USER"
							valueFrom: secretKeyRef: {
								name: "api-secrets"
								key:  "POSTGRES_USER"
							}
						},
						{
							name: "POSTGRES_PASSWORD"
							valueFrom: secretKeyRef: {
								name: "api-secrets"
								key:  "POSTGRES_PASSWORD"
							}
						},
						{
							name:  "PGDATA"
							value: "/var/lib/postgresql/data/pgdata"
						},
					]

					// Health checks
					livenessProbe: {
						exec: command: ["pg_isready", "-U", "$(POSTGRES_USER)", "-d", "$(POSTGRES_DB)"]
						initialDelaySeconds: 30
						periodSeconds:       10
						timeoutSeconds:      5
						failureThreshold:    3
					}

					readinessProbe: {
						exec: command: ["pg_isready", "-U", "$(POSTGRES_USER)", "-d", "$(POSTGRES_DB)"]
						initialDelaySeconds: 5
						periodSeconds:       5
						timeoutSeconds:      3
						failureThreshold:    2
					}

					// Resources
					resources: {
						requests: {
							memory: "256Mi"
							cpu:    "250m"
						}
						limits: {
							memory: "512Mi"
							cpu:    "500m"
						}
					}

					// Volume mount for persistent data
					volumeMounts: [{
						name:      "postgres-data"
						mountPath: "/var/lib/postgresql/data"
					}]

					// Container security context
					securityContext: {
						allowPrivilegeEscalation: false
						capabilities: drop: ["ALL"]
						seccompProfile: type: "RuntimeDefault"
					}
				}]
			}
		}

		// Volume claim templates for persistent storage
		volumeClaimTemplates: [{
			metadata: name: "postgres-data"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "5Gi"
				storageClassName: "local-path"
			}
		}]
	}
}
