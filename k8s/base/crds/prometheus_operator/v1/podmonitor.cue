package v1

import (
	"strings"
	"time"
)

#PodMonitor: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec!: {
		attachMetadata?: node?: bool
		bodySizeLimit?:                  =~"(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
		convertClassicHistogramsToNHCB?: bool
		fallbackScrapeProtocol?:         "PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"
		jobLabel?:                       string
		keepDroppedTargets?:             int64 & int
		labelLimit?:                     int64 & int
		labelNameLengthLimit?:           int64 & int
		labelValueLengthLimit?:          int64 & int
		namespaceSelector?: {
			any?: bool
			matchNames?: [...string]
		}
		nativeHistogramBucketLimit?: int64 & int
		nativeHistogramMinBucketFactor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
		podMetricsEndpoints?: [...{
			authorization?: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				type?: string
			}
			basicAuth?: {
				password?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				username?: {
					key!:      string
					name?:     string
					optional?: bool
				}
			}
			bearerTokenSecret?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			enableHttp2?:     bool
			filterRunning?:   bool
			followRedirects?: bool
			honorLabels?:     bool
			honorTimestamps?: bool
			interval?:        =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			metricRelabelings?: [...{
				action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
				modulus?:     int64 & int
				regex?:       string
				replacement?: string
				separator?:   string
				sourceLabels?: [...string]
				targetLabel?: string
			}]
			noProxy?: string
			oauth2?: {
				clientId!: {
					configMap?: {
						key!:      string
						name?:     string
						optional?: bool
					}
					secret?: {
						key!:      string
						name?:     string
						optional?: bool
					}
				}
				clientSecret!: {
					key!:      string
					name?:     string
					optional?: bool
				}
				endpointParams?: [string]: string
				noProxy?: string
				proxyConnectHeader?: [string]: [...{
					key!:      string
					name?:     string
					optional?: bool
				}]
				proxyFromEnvironment?: bool
				proxyUrl?:             =~"^(http|https|socks5)://.+$"
				scopes?: [...string]
				tlsConfig?: {
					ca?: {
						configMap?: {
							key!:      string
							name?:     string
							optional?: bool
						}
						secret?: {
							key!:      string
							name?:     string
							optional?: bool
						}
					}
					cert?: {
						configMap?: {
							key!:      string
							name?:     string
							optional?: bool
						}
						secret?: {
							key!:      string
							name?:     string
							optional?: bool
						}
					}
					insecureSkipVerify?: bool
					keySecret?: {
						key!:      string
						name?:     string
						optional?: bool
					}
					maxVersion?: "TLS10" | "TLS11" | "TLS12" | "TLS13"
					minVersion?: "TLS10" | "TLS11" | "TLS12" | "TLS13"
					serverName?: string
				}
				tokenUrl!: strings.MinRunes(
						1)
			}
			params?: [string]: [...string]
			path?:       string
			port?:       string
			portNumber?: int32 & int & <=65535 & >=1
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			relabelings?: [...{
				action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
				modulus?:     int64 & int
				regex?:       string
				replacement?: string
				separator?:   string
				sourceLabels?: [...string]
				targetLabel?: string
			}]
			scheme?:        "http" | "https" | "HTTP" | "HTTPS"
			scrapeTimeout?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			targetPort?: matchN(>=1, [int, string]) & (int | string)
			tlsConfig?: {
				ca?: {
					configMap?: {
						key!:      string
						name?:     string
						optional?: bool
					}
					secret?: {
						key!:      string
						name?:     string
						optional?: bool
					}
				}
				cert?: {
					configMap?: {
						key!:      string
						name?:     string
						optional?: bool
					}
					secret?: {
						key!:      string
						name?:     string
						optional?: bool
					}
				}
				insecureSkipVerify?: bool
				keySecret?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				maxVersion?: "TLS10" | "TLS11" | "TLS12" | "TLS13"
				minVersion?: "TLS10" | "TLS11" | "TLS12" | "TLS13"
				serverName?: string
			}
			trackTimestampsStaleness?: bool
		}]
		podTargetLabels?: [...string]
		sampleLimit?:             int64 & int
		scrapeClass?:             strings.MinRunes(
						1)
		scrapeClassicHistograms?: bool
		scrapeProtocols?: [..."PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"]
		selector!: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		selectorMechanism?: "RelabelConfig" | "RoleSelector"
		targetLimit?:       int64 & int
	}
	status?: bindings?: [...{
		conditions?: [...{
			lastTransitionTime!: time.Time
			message?:            string
			observedGeneration?: int64 & int
			reason?:             string
			status!:             strings.MinRunes(
						1)
			type!:               "Accepted" & strings.MinRunes(
						1)
		}]
		group!:     "monitoring.coreos.com"
		name!:      strings.MinRunes(
				1)
		namespace!: strings.MinRunes(
				1)
		resource!:  "prometheuses" | "prometheusagents" | "thanosrulers" | "alertmanagers"
	}]

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "PodMonitor"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
