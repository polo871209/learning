package api

import (
	base "github.com/polo871209/learning/base"
)

_healthCheckCommand: [
	"python3",
	"-c",
	"import socket, sys; s = socket.socket(socket.AF_UNIX); s.connect('/var/run/app.sock'); s.send(b'GET /health HTTP/1.1\\r\\nHost: localhost\\r\\n\\r\\n'); r = s.recv(1024); sys.exit(0 if b'200' in r else 1)",
]
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
				initContainers: [{
					name:            "\(_config.name)-migrations"
					image:           _config.migrationImage
					imagePullPolicy: "IfNotPresent"

					envFrom: [{
						secretRef: name: _postgresSecret.metadata.name
					}]

					command: ["alembic"]
					args: [
						"upgrade",
						"head",
					]
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

					command: ["uvicorn"]
					args: [
						"app.main:app",
						"--uds", "/var/run/app.sock",
						"--forwarded-allow-ips", "*",
					]

					ports: [{
						name:          "http"
						containerPort: _config.port
						protocol:      "TCP"
					}]

					envFrom: [
						{
							configMapRef: name: _config.name
						},
						{
							secretRef: name: _postgresSecret.metadata.name
						},
					]

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

					startupProbe: {
						exec: command: _healthCheckCommand
						initialDelaySeconds: 5
						periodSeconds:       5
						timeoutSeconds:      3
						failureThreshold:    12
					}

					livenessProbe: {
						exec: command: _healthCheckCommand
						periodSeconds:    10
						timeoutSeconds:   5
						failureThreshold: 3
					}

					readinessProbe: {
						exec: command: _healthCheckCommand
						periodSeconds:    5
						timeoutSeconds:   3
						failureThreshold: 2
					}

					resources: {
						limits: {
							memory: "512Mi"
							cpu:    "500m"
						}
					}

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
