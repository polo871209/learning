package v1

import (
	"strings"
	"struct"
	"list"
	"time"
)

#Telemetry: {
	_embeddedResource

	// Telemetry configuration for workloads. See more details at:
	// https://istio.io/docs/reference/config/telemetry.html
	spec?: {
		// Optional.
		accessLogging?: [...{
			// Controls logging.
			disabled?:
				null | bool

			// Optional.
			filter?: {
				// CEL expression for selecting when requests/connections should
				// be logged.
				expression?: string
			}

			// Allows tailoring of logging behavior to specific conditions.
			match?: {
				// This determines whether or not to apply the access logging
				// configuration based on the direction of traffic relative to
				// the proxied workload.
				//
				// Valid Options: CLIENT_AND_SERVER, CLIENT, SERVER
				mode?: "CLIENT_AND_SERVER" | "CLIENT" | "SERVER"
			}

			// Optional.
			providers?: [...{
				// Required.
				name!: strings.MinRunes(
					1)
			}]
		}]

		// Optional.
		metrics?: [...{
			// Optional.
			overrides?: [...{
				// Optional.
				disabled?:
					null | bool

				// Match allows providing the scope of the override.
				match?: matchN(1, [matchN(0, [matchN(>=1, [null | bool | number | string | [...] | {
					metric!: _
				}, null | bool | number | string | [...] | {
					customMetric!: _
				}])]) & {}, {
					metric!: _
				}, {
					customMetric!: _
				}]) & {
					// Allows free-form specification of a metric.
					customMetric?: strings.MinRunes(
							1)

					// One of the well-known [Istio Standard
					// Metrics](https://istio.io/latest/docs/reference/config/metrics/).
					//
					// Valid Options: ALL_METRICS, REQUEST_COUNT, REQUEST_DURATION,
					// REQUEST_SIZE, RESPONSE_SIZE, TCP_OPENED_CONNECTIONS,
					// TCP_CLOSED_CONNECTIONS, TCP_SENT_BYTES, TCP_RECEIVED_BYTES,
					// GRPC_REQUEST_MESSAGES, GRPC_RESPONSE_MESSAGES
					metric?: "ALL_METRICS" | "REQUEST_COUNT" | "REQUEST_DURATION" | "REQUEST_SIZE" | "RESPONSE_SIZE" | "TCP_OPENED_CONNECTIONS" | "TCP_CLOSED_CONNECTIONS" | "TCP_SENT_BYTES" | "TCP_RECEIVED_BYTES" | "GRPC_REQUEST_MESSAGES" | "GRPC_RESPONSE_MESSAGES"

					// Controls which mode of metrics generation is selected:
					// `CLIENT`, `SERVER`, or `CLIENT_AND_SERVER`.
					//
					// Valid Options: CLIENT_AND_SERVER, CLIENT, SERVER
					mode?: "CLIENT_AND_SERVER" | "CLIENT" | "SERVER"
				}

				// Optional.
				tagOverrides?: [string]: {
					// Operation controls whether or not to update/add a tag, or to
					// remove it.
					//
					// Valid Options: UPSERT, REMOVE
					operation?: "UPSERT" | "REMOVE"

					// Value is only considered if the operation is `UPSERT`.
					value?: string
				}
			}]

			// Optional.
			providers?: [...{
				// Required.
				name!: strings.MinRunes(
					1)
			}]

			// Optional.
			reportingInterval?: string
		}]

		// Optional.
		selector?: {
			// One or more labels that indicate a specific set of pods/VMs on
			// which a policy should be applied.
			matchLabels?: struct.MaxFields(
				4096) & {
					[string]: strings.MaxRunes(
							63)
				}
		}
		targetRef?: {
			// group is the group of the target resource.
			group?: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// kind is kind of the target resource.
			kind!: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// name is the name of the target resource.
			name!: strings.MaxRunes(
				253) & strings.MinRunes(
				1)

			// namespace is the namespace of the referent.
			namespace?: string
		}

		// Optional.
		targetRefs?: list.MaxItems(16) & [...{
			// group is the group of the target resource.
			group?: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// kind is kind of the target resource.
			kind!: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// name is the name of the target resource.
			name!: strings.MaxRunes(
				253) & strings.MinRunes(
				1)

			// namespace is the namespace of the referent.
			namespace?: string
		}]

		// Optional.
		tracing?: [...{
			// Optional.
			customTags?: [string]: matchN(1, [matchN(0, [matchN(>=1, [null | bool | number | string | [...] | {
				literal!: _
			}, null | bool | number | string | [...] | {
				environment!: _
			}, null | bool | number | string | [...] | {
				header!: _
			}, null | bool | number | string | [...] | {
				formatter!: _
			}])]) & {}, {
				literal!: _
			}, {
				environment!: _
			}, {
				header!: _
			}, {
				formatter!: _
			}]) & {
				// Environment adds the value of an environment variable to each
				// span.
				environment?: {
					// Optional.
					defaultValue?: string

					// Name of the environment variable from which to extract the tag
					// value.
					name!: strings.MinRunes(
						1)
				}

				// Formatter adds the value of access logging substitution
				// formatter.
				formatter?: {
					// The formatter tag value to use, same formatter as HTTP access
					// logging (e.g.
					value!: strings.MinRunes(
						1)
				}

				// RequestHeader adds the value of an header from the request to
				// each span.
				header?: {
					// Optional.
					defaultValue?: string

					// Name of the header from which to extract the tag value.
					name!: strings.MinRunes(
						1)
				}

				// Literal adds the same, hard-coded value to each span.
				literal?: {
					// The tag value to use.
					value!: strings.MinRunes(
						1)
				}
			}

			// Controls span reporting.
			disableSpanReporting?:
				null | bool

			// Determines whether or not trace spans generated by Envoy will
			// include Istio specific tags.
			enableIstioTags?:
				null | bool

			// Allows tailoring of behavior to specific conditions.
			match?: {
				// This determines whether or not to apply the tracing
				// configuration based on the direction of traffic relative to
				// the proxied workload.
				//
				// Valid Options: CLIENT_AND_SERVER, CLIENT, SERVER
				mode?: "CLIENT_AND_SERVER" | "CLIENT" | "SERVER"
			}

			// Optional.
			providers?: [...{
				// Required.
				name!: strings.MinRunes(
					1)
			}]

			// Controls the rate at which traffic will be selected for tracing
			// if no prior sampling decision has been made.
			randomSamplingPercentage?:
				null | <=100 & >=0
			useRequestIdForTraceSampling?:
				null | bool
		}]
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
	apiVersion: "telemetry.istio.io/v1"
	kind:       "Telemetry"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
