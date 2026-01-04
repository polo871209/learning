package base

import apps "cue.dev/x/k8s.io/api/apps/v1"

#Deployment: apps.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"

	metadata: {
		name:      string
		namespace: string & !="default"
		labels: app: string | *name
	}

	let _appLabel = metadata.labels.app
	let _name = metadata.name

	spec: {
		replicas: *1 | int
		selector: matchLabels: app: _appLabel

		template: {
			metadata: labels: app: _appLabel

			spec: {
				securityContext: {
					runAsNonRoot: *true | bool
					runAsUser:    *65532 | int
					runAsGroup:   *65532 | int
					fsGroup:      *65532 | int

					fsGroupChangePolicy: *"OnRootMismatch" | string

					seccompProfile: type: *"RuntimeDefault" | string
				}

				serviceAccountName: *"default" | string

				automountServiceAccountToken: *false | bool

				containers: [...] & [
					{
						name:  string | *_name
						image: string

						imagePullPolicy: *"Always" | string

						securityContext: {
							allowPrivilegeEscalation: *false | bool

							runAsNonRoot: *true | bool
							runAsUser:    *65532 | int
							runAsGroup:   *65532 | int

							capabilities: drop: *["ALL"] | [...string]

							readOnlyRootFilesystem: *true | bool

							seccompProfile: type: *"RuntimeDefault" | string
						}

						resources: {
							limits: {
								memory: string | *"128Mi"
								cpu:    string | *"200m"
							}
						}
					},
					...,
				]
			}
		}
	}
}
