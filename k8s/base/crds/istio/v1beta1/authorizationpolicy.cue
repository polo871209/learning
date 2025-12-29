package v1beta1

import (
	"list"
	"strings"
	"struct"
	"time"
)

#AuthorizationPolicy: {
	_embeddedResource

	// Configuration for access control on workloads. See more details
	// at:
	// https://istio.io/docs/reference/config/security/authorization-policy.html
	spec?: matchN(1, [matchN(0, [null | bool | number | string | [...] | {
		provider!: _
	}]) & {}, {
		provider!: _
	}]) & {
		// Optional.
		//
		// Valid Options: ALLOW, DENY, AUDIT, CUSTOM
		action?: "ALLOW" | "DENY" | "AUDIT" | "CUSTOM"

		// Specifies detailed configuration of the CUSTOM action.
		provider?: {
			// Specifies the name of the extension provider.
			name?: string
		}

		// Optional.
		rules?: list.MaxItems(512) & [...{
			// Optional.
			from?: list.MaxItems(512) & [...{
				// Source specifies the source of a request.
				source?: {
					// Optional.
					ipBlocks?: [...string]

					// Optional.
					namespaces?: [...string]

					// Optional.
					notIpBlocks?: [...string]

					// Optional.
					notNamespaces?: [...string]

					// Optional.
					notPrincipals?: [...string]

					// Optional.
					notRemoteIpBlocks?: [...string]

					// Optional.
					notRequestPrincipals?: [...string]

					// Optional.
					notServiceAccounts?: list.MaxItems(16) & [...strings.MaxRunes(
						320)]

					// Optional.
					principals?: [...string]

					// Optional.
					remoteIpBlocks?: [...string]

					// Optional.
					requestPrincipals?: [...string]

					// Optional.
					serviceAccounts?: list.MaxItems(16) & [...strings.MaxRunes(
						320)]
				}
			}]

			// Optional.
			to?: [...{
				// Operation specifies the operation of a request.
				operation?: {
					// Optional.
					hosts?: [...string]

					// Optional.
					methods?: [...string]

					// Optional.
					notHosts?: [...string]

					// Optional.
					notMethods?: [...string]

					// Optional.
					notPaths?: [...string]

					// Optional.
					notPorts?: [...string]

					// Optional.
					paths?: [...string]

					// Optional.
					ports?: [...string]
				}
			}]

			// Optional.
			when?: [...{
				// The name of an Istio attribute.
				key!: string

				// Optional.
				notValues?: [...string]

				// Optional.
				values?: [...string]
			}]
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
	apiVersion: "security.istio.io/v1beta1"
	kind:       "AuthorizationPolicy"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
