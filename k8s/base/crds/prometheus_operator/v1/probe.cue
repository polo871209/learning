package v1

import (
	"strings"
	"time"
)

#Probe: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec!: {
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
		convertClassicHistogramsToNHCB?: bool
		fallbackScrapeProtocol?:         "PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"
		interval?:                       =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		jobName?:                        string
		keepDroppedTargets?:             int64 & int
		labelLimit?:                     int64 & int
		labelNameLengthLimit?:           int64 & int
		labelValueLengthLimit?:          int64 & int
		metricRelabelings?: [...{
			action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
			modulus?:     int64 & int
			regex?:       string
			replacement?: string
			separator?:   string
			sourceLabels?: [...string]
			targetLabel?: string
		}]
		module?:                     string
		nativeHistogramBucketLimit?: int64 & int
		nativeHistogramMinBucketFactor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
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
		params?: [...{
			name!: strings.MinRunes(
				1)
			values?: [...strings.MinRunes(
				1)] & [_, ...]
		}] & [_, ...]
		prober?: {
			noProxy?: string
			path?:    string
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			scheme?:               "http" | "https" | "HTTP" | "HTTPS"
			url!:                  strings.MinRunes(
						1)
		}
		sampleLimit?:             int64 & int
		scrapeClass?:             strings.MinRunes(
						1)
		scrapeClassicHistograms?: bool
		scrapeProtocols?: [..."PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"]
		scrapeTimeout?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		targetLimit?:   int64 & int
		targets?: {
			ingress?: {
				namespaceSelector?: {
					any?: bool
					matchNames?: [...string]
				}
				relabelingConfigs?: [...{
					action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
					modulus?:     int64 & int
					regex?:       string
					replacement?: string
					separator?:   string
					sourceLabels?: [...string]
					targetLabel?: string
				}]
				selector?: {
					matchExpressions?: [...{
						key!:      string
						operator!: string
						values?: [...string]
					}]
					matchLabels?: [string]: string
				}
			}
			staticConfig?: {
				labels?: [string]: string
				relabelingConfigs?: [...{
					action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
					modulus?:     int64 & int
					regex?:       string
					replacement?: string
					separator?:   string
					sourceLabels?: [...string]
					targetLabel?: string
				}]
				static?: [...string]
			}
		}
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
	kind:       "Probe"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
