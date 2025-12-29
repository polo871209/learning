package v1

import (
	"list"
	"strings"
	"struct"
	"time"
)

#ServiceEntry: {
	_embeddedResource

	// Configuration affecting service registry. See more details at:
	// https://istio.io/docs/reference/config/networking/service-entry.html
	spec!: {
		// The virtual IP addresses associated with the service.
		addresses?: list.MaxItems(256) & [...strings.MaxRunes(
			64)]

		// One or more endpoints associated with the service.
		endpoints?: list.MaxItems(4096) & [...{
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
		}]

		// A list of namespaces to which this service is exported.
		exportTo?: [...string]

		// The hosts associated with the ServiceEntry.
		hosts!: list.MaxItems(256) & [...string] & [_, ...]

		// Specify whether the service should be considered external to
		// the mesh or part of the mesh.
		//
		// Valid Options: MESH_EXTERNAL, MESH_INTERNAL
		location?: "MESH_EXTERNAL" | "MESH_INTERNAL"

		// The ports associated with the external service.
		ports?: list.MaxItems(256) & [...{
			// Label assigned to the port.
			name!: strings.MaxRunes(
				256)

			// A valid non-negative integer port number.
			number!: int & <=4294967295 & >=0

			// The protocol exposed on the port.
			protocol?: strings.MaxRunes(
					256)

			// The port number on the endpoint where the traffic will be
			// received.
			targetPort?: int & <=4294967295 & >=0
		}]

		// Service resolution mode for the hosts.
		//
		// Valid Options: NONE, STATIC, DNS, DNS_ROUND_ROBIN, DYNAMIC_DNS
		resolution?: "NONE" | "STATIC" | "DNS" | "DNS_ROUND_ROBIN" | "DYNAMIC_DNS"

		// If specified, the proxy will verify that the server
		// certificate's subject alternate name matches one of the
		// specified values.
		subjectAltNames?: [...string]

		// Applicable only for MESH_INTERNAL services.
		workloadSelector?: {
			// One or more labels that indicate a specific set of pods/VMs on
			// which the configuration should be applied.
			labels?: struct.MaxFields(
				256) & {
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
	apiVersion: "networking.istio.io/v1"
	kind:       "ServiceEntry"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
