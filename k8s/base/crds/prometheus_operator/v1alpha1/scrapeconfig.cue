package v1alpha1

import (
	"strings"
	"time"
)

#ScrapeConfig: {
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
		azureSDConfigs?: [...{
			authenticationMethod?: "OAuth" | "ManagedIdentity" | "SDK"
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
			clientID?: strings.MinRunes(
					1)
			clientSecret?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			enableHTTP2?:     bool
			environment?:     strings.MinRunes(
						1)
			followRedirects?: bool
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			resourceGroup?:        strings.MinRunes(
						1)
			subscriptionID!:       strings.MinRunes(
						1)
			tenantID?:             strings.MinRunes(
						1)
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
		}]
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
		consulSDConfigs?: [...{
			allowStale?: bool
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
			datacenter?:      strings.MinRunes(
						1)
			enableHTTP2?:     bool
			filter?:          strings.MinRunes(
						1)
			followRedirects?: bool
			namespace?:       strings.MinRunes(
						1)
			noProxy?:         string
			nodeMeta?: [string]: string
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
			partition?:  strings.MinRunes(
					1)
			pathPrefix?: strings.MinRunes(
					1)
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			scheme?:               "http" | "https" | "HTTP" | "HTTPS"
			server!:               strings.MinRunes(
						1)
			services?: [...string]
			tagSeparator?: strings.MinRunes(
					1)
			tags?: [...string]
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
			tokenRef?: {
				key!:      string
				name?:     string
				optional?: bool
			}
		}]
		convertClassicHistogramsToNHCB?: bool
		digitalOceanSDConfigs?: [...{
			authorization?: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				type?: string
			}
			enableHTTP2?:     bool
			followRedirects?: bool
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
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
		}]
		dnsSDConfigs?: [...{
			names!: [...strings.MinRunes(
				1)] & [_, ...]
			port?:            int32 & int & <=65535 & >=0
			refreshInterval?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			type?:            "A" | "AAAA" | "MX" | "NS" | "SRV"
		}]
		dockerSDConfigs?: [...{
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
			enableHTTP2?: bool
			filters?: [...{
				name!: string
				values!: [...strings.MinRunes(
					1)] & [_, ...]
			}]
			followRedirects?:    bool
			host!:               strings.MinRunes(
						1)
			hostNetworkingHost?: strings.MinRunes(
						1)
			matchFirstNetwork?:  bool
			noProxy?:            string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
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
		}]
		dockerSwarmSDConfigs?: [...{
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
			enableHTTP2?: bool
			filters?: [...{
				name!: string
				values!: [...strings.MinRunes(
					1)] & [_, ...]
			}]
			followRedirects?: bool
			host!:            =~"^[a-zA-Z][a-zA-Z0-9+.-]*://.+$"
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			role!:                 "Services" | "Tasks" | "Nodes"
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
		}]
		ec2SDConfigs?: [...{
			accessKey?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			enableHTTP2?: bool
			filters?: [...{
				name!: string
				values!: [...strings.MinRunes(
					1)] & [_, ...]
			}]
			followRedirects?: bool
			noProxy?:         string
			port?:            int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			region?:               strings.MinRunes(
						1)
			roleARN?:              strings.MinRunes(
						1)
			secretKey?: {
				key!:      string
				name?:     string
				optional?: bool
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
		}]
		enableCompression?: bool
		enableHTTP2?:       bool
		eurekaSDConfigs?: [...{
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
			enableHTTP2?:     bool
			followRedirects?: bool
			noProxy?:         string
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
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			server!:               strings.MinRunes(
						1) & =~"^http(s)?://.+$"
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
		}]
		fallbackScrapeProtocol?: "PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"
		fileSDConfigs?: [...{
			files!: [...=~"^[^*]*(\\*[^/]*)?\\.(json|yml|yaml|JSON|YML|YAML)$"] & [_, ...]
			refreshInterval?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		}]
		gceSDConfigs?: [...{
			filter?:          strings.MinRunes(
						1)
			port?:            int32 & int & <=65535 & >=0
			project!:         strings.MinRunes(
						1)
			refreshInterval?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			tagSeparator?:    strings.MinRunes(
						1)
			zone!:            strings.MinRunes(
						1)
		}]
		hetznerSDConfigs?: [...{
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
			enableHTTP2?:     bool
			followRedirects?: bool
			labelSelector?:   strings.MinRunes(
						1)
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			role!:                 "hcloud" | "Hcloud" | "robot" | "Robot"
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
		}]
		honorLabels?:     bool
		honorTimestamps?: bool
		httpSDConfigs?: [...{
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
			enableHTTP2?:     bool
			followRedirects?: bool
			noProxy?:         string
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
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
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
			url!: strings.MinRunes(
				1) & =~"^http(s)?://.+$"
		}]
		ionosSDConfigs?: [...{
			authorization!: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				type?: string
			}
			datacenterID!:    strings.MinRunes(
						1)
			enableHTTP2?:     bool
			followRedirects?: bool
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
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
		}]
		jobName?:            strings.MinRunes(
					1)
		keepDroppedTargets?: int64 & int
		kubernetesSDConfigs?: [...{
			apiServer?: strings.MinRunes(
					1)
			attachMetadata?: node?: bool
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
			enableHTTP2?:     bool
			followRedirects?: bool
			namespaces?: {
				names?: [...string]
				ownNamespace?: bool
			}
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
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			role!:                 "Pod" | "Endpoints" | "Ingress" | "Service" | "Node" | "EndpointSlice"
			selectors?: [...{
				field?: strings.MinRunes(
					1)
				label?: strings.MinRunes(
					1)
				role!:  "Pod" | "Endpoints" | "Ingress" | "Service" | "Node" | "EndpointSlice"
			}]
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
		}]
		kumaSDConfigs?: [...{
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
			clientID?:        strings.MinRunes(
						1)
			enableHTTP2?:     bool
			fetchTimeout?:    =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			followRedirects?: bool
			noProxy?:         string
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
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			server!:               =~"^https?://.+$"
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
		}]
		labelLimit?:            int64 & int
		labelNameLengthLimit?:  int64 & int
		labelValueLengthLimit?: int64 & int
		lightSailSDConfigs?: [...{
			accessKey?: {
				key!:      string
				name?:     string
				optional?: bool
			}
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
			enableHTTP2?:     bool
			endpoint?:        strings.MinRunes(
						1)
			followRedirects?: bool
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			region?:               strings.MinRunes(
						1)
			roleARN?:              string
			secretKey?: {
				key!:      string
				name?:     string
				optional?: bool
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
		}]
		linodeSDConfigs?: [...{
			authorization?: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				type?: string
			}
			enableHTTP2?:     bool
			followRedirects?: bool
			noProxy?:         string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			region?:               strings.MinRunes(
						1)
			tagSeparator?:         strings.MinRunes(
						1)
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
		}]
		metricRelabelings?: [...{
			action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
			modulus?:     int64 & int
			regex?:       string
			replacement?: string
			separator?:   string
			sourceLabels?: [...string]
			targetLabel?: string
		}] & [_, ...]
		metricsPath?:                strings.MinRunes(
						1)
		nameEscapingScheme?:         "AllowUTF8" | "Underscores" | "Dots" | "Values"
		nameValidationScheme?:       "UTF8" | "Legacy"
		nativeHistogramBucketLimit?: int64 & int
		nativeHistogramMinBucketFactor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
		noProxy?: string
		nomadSDConfigs?: [...{
			allowStale?: bool
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
			enableHTTP2?:     bool
			followRedirects?: bool
			namespace?:       string
			noProxy?:         string
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
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			region?:               string
			server!:               strings.MinRunes(
						1)
			tagSeparator?:         string
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
		}]
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
		openstackSDConfigs?: [...{
			allTenants?:                bool
			applicationCredentialId?:   string
			applicationCredentialName?: strings.MinRunes(
							1)
			applicationCredentialSecret?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			availability?:     "Public" | "public" | "Admin" | "admin" | "Internal" | "internal"
			domainID?:         strings.MinRunes(
						1)
			domainName?:       strings.MinRunes(
						1)
			identityEndpoint?: =~"^http(s)?:\\/\\/.+$"
			password?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			port?:            int32 & int & <=65535 & >=0
			projectID?:       strings.MinRunes(
						1)
			projectName?:     strings.MinRunes(
						1)
			refreshInterval?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			region!:          strings.MinRunes(
						1)
			role!:            "Instance" | "Hypervisor" | "LoadBalancer"
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
			userid?:   strings.MinRunes(
					1)
			username?: strings.MinRunes(
					1)
		}]
		ovhcloudSDConfigs?: [...{
			applicationKey!: strings.MinRunes(
						1)
			applicationSecret!: {
				key!:      string
				name?:     string
				optional?: bool
			}
			consumerKey!: {
				key!:      string
				name?:     string
				optional?: bool
			}
			endpoint?:        strings.MinRunes(
						1)
			refreshInterval?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			service!:         "VPS" | "DedicatedServer"
		}]
		params?: [string]: [...string]
		proxyConnectHeader?: [string]: [...{
			key!:      string
			name?:     string
			optional?: bool
		}]
		proxyFromEnvironment?: bool
		proxyUrl?:             =~"^(http|https|socks5)://.+$"
		puppetDBSDConfigs?: [...{
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
			enableHTTP2?:       bool
			followRedirects?:   bool
			includeParameters?: bool
			noProxy?:           string
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
			port?: int32 & int & <=65535 & >=0
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			query!:                strings.MinRunes(
						1)
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
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
			url!: strings.MinRunes(
				1) & =~"^http(s)?://.+$"
		}]
		relabelings?: [...{
			action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
			modulus?:     int64 & int
			regex?:       string
			replacement?: string
			separator?:   string
			sourceLabels?: [...string]
			targetLabel?: string
		}] & [_, ...]
		sampleLimit?: int64 & int
		scalewaySDConfigs?: [...{
			accessKey!:       strings.MinRunes(
						1)
			apiURL?:          =~"^http(s)?://.+$"
			enableHTTP2?:     bool
			followRedirects?: bool
			nameFilter?:      strings.MinRunes(
						1)
			noProxy?:         string
			port?:            int32 & int & <=65535 & >=0
			projectID!:       strings.MinRunes(
						1)
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
			refreshInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			role!:                 "Instance" | "Baremetal"
			secretKey!: {
				key!:      string
				name?:     string
				optional?: bool
			}
			tagsFilter?: [...strings.MinRunes(
				1)] & [_, ...]
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
			zone?: strings.MinRunes(
				1)
		}]
		scheme?:                  "http" | "https" | "HTTP" | "HTTPS"
		scrapeClass?:             strings.MinRunes(
						1)
		scrapeClassicHistograms?: bool
		scrapeInterval?:          =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		scrapeProtocols?: [..."PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"] & [_, ...]
		scrapeTimeout?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		staticConfigs?: [...{
			labels?: [string]: string
			targets!: [...string] & [_, ...]
		}]
		targetLimit?: int64 & int
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
	apiVersion: "monitoring.coreos.com/v1alpha1"
	kind:       "ScrapeConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
