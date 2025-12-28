package app

import (
	base "github.com/polo871209/learning/definitions"
	platform "github.com/polo871209/learning/platform"
)

// FastAPI deployment with health checks, environment variables, and proper volume mounts
_deployment: base.#Deployment & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels: _config.labels & {
			"managed-by": "cue"
		}
	}

	spec: {
		template: spec: {
			// Init container for database migrations
			initContainers: [{
				name:            "\(_config.name)-migrations"
				image:           _config.migrationImage
				imagePullPolicy: "IfNotPresent"

			// Import database credentials
			envFrom: [{
				secretRef: name: platform.PostgresSecretName
			}]

				// Resource limits for migration container
				resources: {
					limits: {
						memory: "256Mi"
						cpu:    "200m"
					}
				}
			}]

			containers: [{
				name:            _config.name
				image:           _config.image
				imagePullPolicy: "IfNotPresent"

				// Container port
				ports: [{
					name:          "http"
					containerPort: _config.port
					protocol:      "TCP"
				}]

			// Import entire ConfigMap and Secret as environment variables
			envFrom: [
				{
					configMapRef: name: _config.name
				},
				{
					secretRef: name: platform.PostgresSecretName
				},
			]

				// Additional environment variables
				env: [
					{
						name:  "PYTHONUNBUFFERED"
						value: "1"
					},
					{
						name:  "PYTHONDONTWRITEBYTECODE"
						value: "1"
					},
				]

				// Health checks for FastAPI
				livenessProbe: {
					httpGet: {
						path: "/health"
						port: _config.port
					}
					initialDelaySeconds: 30
					periodSeconds:       10
					timeoutSeconds:      5
					failureThreshold:    3
				}

				readinessProbe: {
					httpGet: {
						path: "/health"
						port: _config.port
					}
					initialDelaySeconds: 5
					periodSeconds:       5
					timeoutSeconds:      3
					failureThreshold:    2
				}

				// Startup probe to handle longer initialization
				startupProbe: {
					httpGet: {
						path: "/health"
						port: _config.port
					}
					initialDelaySeconds: 5
					periodSeconds:       5
					timeoutSeconds:      3
					failureThreshold:    12
				}

				// Override resource limits for FastAPI
				resources: {
					limits: {
						memory: "512Mi"
						cpu:    "500m"
					}
				}

				// Volume mounts for writable directories (since root filesystem is read-only)
				volumeMounts: [
					{
						name:      "tmp"
						mountPath: "/tmp"
					},
					{
						name:      "cache"
						mountPath: "/app/.cache"
					},
				]
			}]

			// Volumes for writable directories
			volumes: [
				{
					name: "tmp"
					emptyDir: {}
				},
				{
					name: "cache"
					emptyDir: {
						sizeLimit: "100Mi"
					}
				},
			]
		}
	}
}
