package v1beta1

import (
	"strings"
	"struct"
	"time"
)

#WorkloadEntry: {
	_embeddedResource

	// Configuration affecting VMs onboarded into the mesh. See more
	// details at:
	// https://istio.io/docs/reference/config/networking/workload-entry.html
	spec!: {
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
	kind:       "WorkloadEntry"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
