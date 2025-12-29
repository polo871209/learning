package v1alpha1

import (
	"strings"
	"struct"
	"list"
	"time"
)

#WasmPlugin: {
	_embeddedResource

	// Extend the functionality provided by the Istio proxy through
	// WebAssembly filters. See more details at:
	// https://istio.io/docs/reference/config/proxy_extensions/wasm-plugin.html
	spec!: {
		// Specifies the failure behavior for the plugin due to fatal
		// errors.
		//
		// Valid Options: FAIL_CLOSE, FAIL_OPEN, FAIL_RELOAD
		failStrategy?: "FAIL_CLOSE" | "FAIL_OPEN" | "FAIL_RELOAD"

		// The pull behaviour to be applied when fetching Wasm module by
		// either OCI image or `http/https`.
		//
		// Valid Options: IfNotPresent, Always
		imagePullPolicy?: "UNSPECIFIED_POLICY" | "IfNotPresent" | "Always"

		// Credentials to use for OCI image pulling.
		imagePullSecret?: strings.MaxRunes(
					253) & strings.MinRunes(
					1)

		// Specifies the criteria to determine which traffic is passed to
		// WasmPlugin.
		match?: [...{
			// Criteria for selecting traffic by their direction.
			//
			// Valid Options: CLIENT, SERVER, CLIENT_AND_SERVER
			mode?: "UNDEFINED" | "CLIENT" | "SERVER" | "CLIENT_AND_SERVER"

			// Criteria for selecting traffic by their destination port.
			ports?: [...{
				number!: int & <=65535 & >=1
			}]
		}]

		// Determines where in the filter chain this `WasmPlugin` is to be
		// injected.
		//
		// Valid Options: AUTHN, AUTHZ, STATS
		phase?: "UNSPECIFIED_PHASE" | "AUTHN" | "AUTHZ" | "STATS"

		// The configuration that will be passed on to the plugin.
		pluginConfig?: {
			...
		}

		// The plugin name to be used in the Envoy configuration (used to
		// be called `rootID`).
		pluginName?: strings.MaxRunes(
				256) & strings.MinRunes(
				1)

		// Determines ordering of `WasmPlugins` in the same `phase`.
		priority?:
			null | int32 & int

		// Criteria used to select the specific set of pods/VMs on which
		// this plugin configuration should be applied.
		selector?: {
			// One or more labels that indicate a specific set of pods/VMs on
			// which a policy should be applied.
			matchLabels?: struct.MaxFields(
				4096) & {
					[string]: strings.MaxRunes(
							63)
				}
		}

		// SHA256 checksum that will be used to verify Wasm module or OCI
		// container.
		sha256?: =~"(^$|^[a-f0-9]{64}$)"
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

		// Specifies the type of Wasm Extension to be used.
		//
		// Valid Options: HTTP, NETWORK
		type?: "UNSPECIFIED_PLUGIN_TYPE" | "HTTP" | "NETWORK"

		// URL of a Wasm module or OCI container.
		url!:             strings.MinRunes(
					1)
		verificationKey?: string

		// Configuration for a Wasm VM.
		vmConfig?: {
			// Specifies environment variables to be injected to this VM.
			env?: list.MaxItems(256) & [...{
				// Name of the environment variable.
				name!: strings.MaxRunes(
					256) & strings.MinRunes(
					1)

				// Value for the environment variable.
				value?: strings.MaxRunes(
					2048)

				// Source for the environment variable's value.
				//
				// Valid Options: INLINE, HOST
				valueFrom?: "INLINE" | "HOST"
			}]
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
	apiVersion: "extensions.istio.io/v1alpha1"
	kind:       "WasmPlugin"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
