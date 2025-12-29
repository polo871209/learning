package v1

import (
	"struct"
	"strings"
	"time"
)

#WorkloadGroup: {
	_embeddedResource

	// Describes a collection of workload instances. See more details
	// at:
	// https://istio.io/docs/reference/config/networking/workload-group.html
	spec!: {
		// Metadata that will be used for all corresponding
		// `WorkloadEntries`.
		metadata?: {
			annotations?: struct.MaxFields(
				256) & {
					[string]: string
				}
			labels?: struct.MaxFields(
				256) & {
					[string]: string
				}
		}

		// `ReadinessProbe` describes the configuration the user must
		// provide for healthchecking on their workload.
		probe?: matchN(1, [matchN(0, [matchN(>=1, [null | bool | number | string | [...] | {
			httpGet!: _
		}, null | bool | number | string | [...] | {
			tcpSocket!: _
		}, null | bool | number | string | [...] | {
			exec!: _
		}, null | bool | number | string | [...] | {
			grpc!: _
		}])]) & {}, {
			httpGet!: _
		}, {
			tcpSocket!: _
		}, {
			exec!: _
		}, {
			grpc!: _
		}]) & {
			// Health is determined by how the command that is executed
			// exited.
			exec?: {
				// Command to run.
				command!: [...strings.MinRunes(
					1)]
			}

			// Minimum consecutive failures for the probe to be considered
			// failed after having succeeded.
			failureThreshold?: int32 & int & >=0

			// GRPC call is made and response/error is used to determine
			// health.
			grpc?: {
				// Port on which the endpoint lives.
				port?:    int & <=4294967295 & >=0
				service?: string
			}

			// `httpGet` is performed to a given endpoint and the status/able
			// to connect determines health.
			httpGet?: {
				// Host name to connect to, defaults to the pod IP.
				host?: string

				// Headers the proxy will pass on to make the request.
				httpHeaders?: [...{
					name?:  =~"^[-_A-Za-z0-9]+$"
					value?: string
				}]

				// Path to access on the HTTP server.
				path?: string

				// Port on which the endpoint lives.
				port!:   int & <=4294967295 & >=0
				scheme?: string
			}

			// Number of seconds after the container has started before
			// readiness probes are initiated.
			initialDelaySeconds?: int32 & int & >=0

			// How often (in seconds) to perform the probe.
			periodSeconds?: int32 & int & >=0

			// Minimum consecutive successes for the probe to be considered
			// successful after having failed.
			successThreshold?: int32 & int & >=0

			// Health is determined by if the proxy is able to connect.
			tcpSocket?: {
				host?: string
				port!: int & <=4294967295 & >=0
			}

			// Number of seconds after which the probe times out.
			timeoutSeconds?: int32 & int & >=0
		}

		// Template to be used for the generation of `WorkloadEntry`
		// resources that belong to this `WorkloadGroup`.
		template!: {
			// Address associated with the network endpoint without the port.
			address?: strings.MaxRunes(
					256)

			// One or more labels associated with the endpoint.
			labels?: struct.MaxFields(
				256) & {
					[string]: string
				}

			// The locality associated with the endpoint.
			locality?: strings.MaxRunes(
					2048)

			// Network enables Istio to group endpoints resident in the same
			// L3 domain/network.
			network?: strings.MaxRunes(
					2048)

			// Set of ports associated with the endpoint.
			ports?: struct.MaxFields(
				128) & {
					[string]: int & <=4294967295 & >=0
				}

			// The service account associated with the workload if a sidecar
			// is present in the workload.
			serviceAccount?: strings.MaxRunes(
						253)

			// The load balancing weight associated with the endpoint.
			weight?: int & <=4294967295 & >=0
		}
	}
	status?: {
		// Current service state of the resource.
		conditions?: [...{
			// Last time we probed the condition.
			lastProbeTime?: time.Time

			// Last time the condition transitioned from one status to
			// another.
			lastTransitionTime?: time.Time

			// Human-readable message indicating details about last
			// transition.
			message?: string

			// Resource Generation to which the Condition refers.
			observedGeneration?: matchN(>=1, [int, string]) & (int | string)

			// Unique, one-word, CamelCase reason for the condition's last
			// transition.
			reason?: string

			// Status is the status of the condition.
			status?: string

			// Type is the type of the condition.
			type?: string
		}]
		observedGeneration?: matchN(>=1, [int, string]) & (int | string)

		// Includes any errors or warnings detected by Istio's analyzers.
		validationMessages?: [...{
			// A url pointing to the Istio documentation for this specific
			// error type.
			documentationUrl?: string

			// Represents how severe a message is.
			//
			// Valid Options: UNKNOWN, ERROR, WARNING, INFO
			level?: "UNKNOWN" | "ERROR" | "WARNING" | "INFO"
			type?: {
				// A 7 character code matching `^IST[0-9]{4}$` intended to
				// uniquely identify the message type.
				code?: string

				// A human-readable name for the message type.
				name?: string
			}
		}]
		...
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "networking.istio.io/v1"
	kind:       "WorkloadGroup"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
