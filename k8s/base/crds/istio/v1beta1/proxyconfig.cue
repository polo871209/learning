package v1beta1

import (
	"strings"
	"struct"
	"time"
)

#ProxyConfig: {
	_embeddedResource

	// Provides configuration for individual workloads. See more
	// details at:
	// https://istio.io/docs/reference/config/networking/proxy-config.html
	spec?: {
		// The number of worker threads to run.
		concurrency?:
			null | int32 & int & >=0

		// Additional environment variables for the proxy.
		environmentVariables?: [string]: strings.MaxRunes(
							2048)

		// Specifies the details of the proxy image.
		image?: {
			// The image type of the image.
			imageType?: string
		}

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
	apiVersion: "networking.istio.io/v1beta1"
	kind:       "ProxyConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
