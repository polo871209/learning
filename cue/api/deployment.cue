package app

import base "github.com/polo871209/learning/definitions"

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
		replicas: 2

		template: spec: {
			containers: [{
				name:  _config.name
				image: _config.image

				// Container port
				ports: [{
					name:          "http"
					containerPort: _config.port
					protocol:      "TCP"
				}]

				// Import entire ConfigMap and Secret as environment variables
				envFrom: [
					{
						configMapRef: name: "api-config"
					},
					{
						secretRef: name: "api-secrets"
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
					requests: {
						memory: "256Mi"
						cpu:    "250m"
					}
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
