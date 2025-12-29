package v1

import (
	"list"
	"time"
)

#Gateway: {
	_embeddedResource

	// Configuration affecting edge load balancer. See more details
	// at:
	// https://istio.io/docs/reference/config/networking/gateway.html
	spec?: {
		// One or more labels that indicate a specific set of pods/VMs on
		// which this gateway configuration should be applied.
		selector?: [string]: string

		// A list of server specifications.
		servers?: [...{
			// The ip or the Unix domain socket to which the listener should
			// be bound to.
			bind?:            string
			defaultEndpoint?: string

			// One or more hosts exposed by this gateway.
			hosts!: [...string]

			// An optional name of the server, when set must be unique across
			// all servers.
			name?: string

			// The Port on which the proxy should listen for incoming
			// connections.
			port!: {
				// Label assigned to the port.
				name!: string

				// A valid non-negative integer port number.
				number!: int & <=4294967295 & >=0

				// The protocol exposed on the port.
				protocol!:   string
				targetPort?: int & <=4294967295 & >=0
			}

			// Set of TLS related options that govern the server's behavior.
			tls?: {
				// For mutual TLS, the name of the secret or the configmap that
				// holds CA certificates.
				caCertCredentialName?: string

				// REQUIRED if mode is `MUTUAL` or `OPTIONAL_MUTUAL`.
				caCertificates?: string

				// OPTIONAL: The path to the file containing the certificate
				// revocation list (CRL) to use in verifying a presented client
				// side certificate.
				caCrl?: string

				// Optional: If specified, only support the specified cipher list.
				cipherSuites?: [...string]

				// For gateways running on Kubernetes, the name of the secret that
				// holds the TLS certs including the CA certificates.
				credentialName?: string

				// Same as CredentialName but for multiple certificates.
				credentialNames?: list.MaxItems(2) & [...string] & [_, ...]

				// If set to true, the load balancer will send a 301 redirect for
				// all http connections, asking the clients to use HTTPS.
				httpsRedirect?: bool

				// Optional: Maximum TLS protocol version.
				//
				// Valid Options: TLS_AUTO, TLSV1_0, TLSV1_1, TLSV1_2, TLSV1_3
				maxProtocolVersion?: "TLS_AUTO" | "TLSV1_0" | "TLSV1_1" | "TLSV1_2" | "TLSV1_3"

				// Optional: Minimum TLS protocol version.
				//
				// Valid Options: TLS_AUTO, TLSV1_0, TLSV1_1, TLSV1_2, TLSV1_3
				minProtocolVersion?: "TLS_AUTO" | "TLSV1_0" | "TLSV1_1" | "TLSV1_2" | "TLSV1_3"

				// Optional: Indicates whether connections to this port should be
				// secured using TLS.
				//
				// Valid Options: PASSTHROUGH, SIMPLE, MUTUAL, AUTO_PASSTHROUGH,
				// ISTIO_MUTUAL, OPTIONAL_MUTUAL
				mode?: "PASSTHROUGH" | "SIMPLE" | "MUTUAL" | "AUTO_PASSTHROUGH" | "ISTIO_MUTUAL" | "OPTIONAL_MUTUAL"

				// REQUIRED if mode is `SIMPLE` or `MUTUAL`.
				privateKey?: string

				// REQUIRED if mode is `SIMPLE` or `MUTUAL`.
				serverCertificate?: string

				// A list of alternate names to verify the subject identity in the
				// certificate presented by the client.
				subjectAltNames?: [...string]

				// Only one of `server_certificate`, `private_key` or
				// `credential_name` or `credential_names` or `tls_certificates`
				// should be specified.
				tlsCertificates?: list.MaxItems(2) & [...{
					caCertificates?: string

					// REQUIRED if mode is `SIMPLE` or `MUTUAL`.
					privateKey?: string

					// REQUIRED if mode is `SIMPLE` or `MUTUAL`.
					serverCertificate?: string
				}] & [_, ...]

				// An optional list of hex-encoded SHA-256 hashes of the
				// authorized client certificates.
				verifyCertificateHash?: [...string]

				// An optional list of base64-encoded SHA-256 hashes of the SPKIs
				// of authorized client certificates.
				verifyCertificateSpki?: [...string]
			}
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
	apiVersion: "networking.istio.io/v1"
	kind:       "Gateway"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
