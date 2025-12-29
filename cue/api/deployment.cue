package app

import (
	base "github.com/polo871209/learning/definitions"
	platform "github.com/polo871209/learning/platform"
)

// Health check command for Unix socket communication
_healthCheckCommand: [
	"python3",
	"-c",
	"import socket, sys; s = socket.socket(socket.AF_UNIX); s.connect('/var/run/app.sock'); s.send(b'GET /health HTTP/1.1\\r\\nHost: localhost\\r\\n\\r\\n'); r = s.recv(1024); sys.exit(0 if b'200' in r else 1)",
]

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
		template: {
			metadata: {
				annotations: {
					// Istio annotations to mount socket volume in sidecar proxy
					"sidecar.istio.io/userVolume": """
						[{
							"name": "socket",
							"emptyDir": {}
						}]
						"""
					"sidecar.istio.io/userVolumeMount": """
						[{
							"name": "socket",
							"mountPath": "/var/run"
						}]
						"""
				}
			}

			spec: {
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

					// Override CMD to use Unix Domain Socket with Istio
					command: ["uvicorn"]
					args: [
						"app.main:app",
						"--uds", "/var/run/app.sock",
						"--forwarded-allow-ips", "*",
					]

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

				// Health checks for FastAPI via Unix socket
				livenessProbe: {
					exec: command: _healthCheckCommand
					initialDelaySeconds: 30
					periodSeconds:       10
					timeoutSeconds:      5
					failureThreshold:    3
				}

				readinessProbe: {
					exec: command: _healthCheckCommand
					initialDelaySeconds: 5
					periodSeconds:       5
					timeoutSeconds:      3
					failureThreshold:    2
				}

				// Startup probe to handle longer initialization
				startupProbe: {
					exec: command: _healthCheckCommand
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

					// Volume mounts for writable directories and socket (since root filesystem is read-only)
					volumeMounts: [
						{
							name:      "tmp"
							mountPath: "/tmp"
						},
						{
							name:      "cache"
							mountPath: "/app/.cache"
						},
						{
							name:      "socket"
							mountPath: "/var/run"
						},
					]
				}]

				// Volumes for writable directories and socket sharing
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
					{
						name: "socket"
						emptyDir: {}
					},
				]
			}
		}
	}
}
