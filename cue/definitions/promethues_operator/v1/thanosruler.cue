package v1

import (
	"strings"
	"time"
)

#ThanosRuler: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec!: {
		additionalArgs?: [...{
			name!:  strings.MinRunes(
				1)
			value?: string
		}]
		affinity?: {
			nodeAffinity?: {
				preferredDuringSchedulingIgnoredDuringExecution?: [...{
					preference!: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchFields?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
					}
					weight!: int32 & int
				}]
				requiredDuringSchedulingIgnoredDuringExecution?: nodeSelectorTerms!: [...{
					matchExpressions?: [...{
						key!:      string
						operator!: string
						values?: [...string]
					}]
					matchFields?: [...{
						key!:      string
						operator!: string
						values?: [...string]
					}]
				}]
			}
			podAffinity?: {
				preferredDuringSchedulingIgnoredDuringExecution?: [...{
					podAffinityTerm!: {
						labelSelector?: {
							matchExpressions?: [...{
								key!:      string
								operator!: string
								values?: [...string]
							}]
							matchLabels?: [string]: string
						}
						matchLabelKeys?: [...string]
						mismatchLabelKeys?: [...string]
						namespaceSelector?: {
							matchExpressions?: [...{
								key!:      string
								operator!: string
								values?: [...string]
							}]
							matchLabels?: [string]: string
						}
						namespaces?: [...string]
						topologyKey!: string
					}
					weight!: int32 & int
				}]
				requiredDuringSchedulingIgnoredDuringExecution?: [...{
					labelSelector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					matchLabelKeys?: [...string]
					mismatchLabelKeys?: [...string]
					namespaceSelector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					namespaces?: [...string]
					topologyKey!: string
				}]
			}
			podAntiAffinity?: {
				preferredDuringSchedulingIgnoredDuringExecution?: [...{
					podAffinityTerm!: {
						labelSelector?: {
							matchExpressions?: [...{
								key!:      string
								operator!: string
								values?: [...string]
							}]
							matchLabels?: [string]: string
						}
						matchLabelKeys?: [...string]
						mismatchLabelKeys?: [...string]
						namespaceSelector?: {
							matchExpressions?: [...{
								key!:      string
								operator!: string
								values?: [...string]
							}]
							matchLabels?: [string]: string
						}
						namespaces?: [...string]
						topologyKey!: string
					}
					weight!: int32 & int
				}]
				requiredDuringSchedulingIgnoredDuringExecution?: [...{
					labelSelector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					matchLabelKeys?: [...string]
					mismatchLabelKeys?: [...string]
					namespaceSelector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					namespaces?: [...string]
					topologyKey!: string
				}]
			}
		}
		alertDropLabels?: [...string]
		alertQueryUrl?:          string
		alertRelabelConfigFile?: string
		alertRelabelConfigs?: {
			key!:      string
			name?:     string
			optional?: bool
		}
		alertmanagersConfig?: {
			key!:      string
			name?:     string
			optional?: bool
		}
		alertmanagersUrl?: [...string]
		containers?: [...{
			args?: [...string]
			command?: [...string]
			env?: [...{
				name!:  string
				value?: string
				valueFrom?: {
					configMapKeyRef?: {
						key!:      string
						name?:     string
						optional?: bool
					}
					fieldRef?: {
						apiVersion?: string
						fieldPath!:  string
					}
					fileKeyRef?: {
						key!:        string
						optional?:   bool
						path!:       string
						volumeName!: string
					}
					resourceFieldRef?: {
						containerName?: string
						divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						resource!: string
					}
					secretKeyRef?: {
						key!:      string
						name?:     string
						optional?: bool
					}
				}
			}]
			envFrom?: [...{
				configMapRef?: {
					name?:     string
					optional?: bool
				}
				prefix?: string
				secretRef?: {
					name?:     string
					optional?: bool
				}
			}]
			image?:           string
			imagePullPolicy?: string
			lifecycle?: {
				postStart?: {
					exec?: command?: [...string]
					httpGet?: {
						host?: string
						httpHeaders?: [...{
							name!:  string
							value!: string
						}]
						path?: string
						port!: matchN(>=1, [int, string]) & (int | string)
						scheme?: string
					}
					sleep?: seconds!: int64 & int
					tcpSocket?: {
						host?: string
						port!: matchN(>=1, [int, string]) & (int | string)
					}
				}
				preStop?: {
					exec?: command?: [...string]
					httpGet?: {
						host?: string
						httpHeaders?: [...{
							name!:  string
							value!: string
						}]
						path?: string
						port!: matchN(>=1, [int, string]) & (int | string)
						scheme?: string
					}
					sleep?: seconds!: int64 & int
					tcpSocket?: {
						host?: string
						port!: matchN(>=1, [int, string]) & (int | string)
					}
				}
				stopSignal?: string
			}
			livenessProbe?: {
				exec?: command?: [...string]
				failureThreshold?: int32 & int
				grpc?: {
					port!:    int32 & int
					service?: string
				}
				httpGet?: {
					host?: string
					httpHeaders?: [...{
						name!:  string
						value!: string
					}]
					path?: string
					port!: matchN(>=1, [int, string]) & (int | string)
					scheme?: string
				}
				initialDelaySeconds?: int32 & int
				periodSeconds?:       int32 & int
				successThreshold?:    int32 & int
				tcpSocket?: {
					host?: string
					port!: matchN(>=1, [int, string]) & (int | string)
				}
				terminationGracePeriodSeconds?: int64 & int
				timeoutSeconds?:                int32 & int
			}
			name!: string
			ports?: [...{
				containerPort!: int32 & int
				hostIP?:        string
				hostPort?:      int32 & int
				name?:          string
				protocol?:      string
			}]
			readinessProbe?: {
				exec?: command?: [...string]
				failureThreshold?: int32 & int
				grpc?: {
					port!:    int32 & int
					service?: string
				}
				httpGet?: {
					host?: string
					httpHeaders?: [...{
						name!:  string
						value!: string
					}]
					path?: string
					port!: matchN(>=1, [int, string]) & (int | string)
					scheme?: string
				}
				initialDelaySeconds?: int32 & int
				periodSeconds?:       int32 & int
				successThreshold?:    int32 & int
				tcpSocket?: {
					host?: string
					port!: matchN(>=1, [int, string]) & (int | string)
				}
				terminationGracePeriodSeconds?: int64 & int
				timeoutSeconds?:                int32 & int
			}
			resizePolicy?: [...{
				resourceName!:  string
				restartPolicy!: string
			}]
			resources?: {
				claims?: [...{
					name!:    string
					request?: string
				}]
				limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
				requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			}
			restartPolicy?: string
			restartPolicyRules?: [...{
				action!: string
				exitCodes?: {
					operator!: string
					values?: [...int32 & int]
				}
			}]
			securityContext?: {
				allowPrivilegeEscalation?: bool
				appArmorProfile?: {
					localhostProfile?: string
					type!:             string
				}
				capabilities?: {
					add?: [...string]
					drop?: [...string]
				}
				privileged?:             bool
				procMount?:              string
				readOnlyRootFilesystem?: bool
				runAsGroup?:             int64 & int
				runAsNonRoot?:           bool
				runAsUser?:              int64 & int
				seLinuxOptions?: {
					level?: string
					role?:  string
					type?:  string
					user?:  string
				}
				seccompProfile?: {
					localhostProfile?: string
					type!:             string
				}
				windowsOptions?: {
					gmsaCredentialSpec?:     string
					gmsaCredentialSpecName?: string
					hostProcess?:            bool
					runAsUserName?:          string
				}
			}
			startupProbe?: {
				exec?: command?: [...string]
				failureThreshold?: int32 & int
				grpc?: {
					port!:    int32 & int
					service?: string
				}
				httpGet?: {
					host?: string
					httpHeaders?: [...{
						name!:  string
						value!: string
					}]
					path?: string
					port!: matchN(>=1, [int, string]) & (int | string)
					scheme?: string
				}
				initialDelaySeconds?: int32 & int
				periodSeconds?:       int32 & int
				successThreshold?:    int32 & int
				tcpSocket?: {
					host?: string
					port!: matchN(>=1, [int, string]) & (int | string)
				}
				terminationGracePeriodSeconds?: int64 & int
				timeoutSeconds?:                int32 & int
			}
			stdin?:                    bool
			stdinOnce?:                bool
			terminationMessagePath?:   string
			terminationMessagePolicy?: string
			tty?:                      bool
			volumeDevices?: [...{
				devicePath!: string
				name!:       string
			}]
			volumeMounts?: [...{
				mountPath!:         string
				mountPropagation?:  string
				name!:              string
				readOnly?:          bool
				recursiveReadOnly?: string
				subPath?:           string
				subPathExpr?:       string
			}]
			workingDir?: string
		}]
		dnsConfig?: {
			nameservers?: [...strings.MinRunes(
				1)]
			options?: [...{
				name!:  strings.MinRunes(
					1)
				value?: string
			}]
			searches?: [...strings.MinRunes(
				1)]
		}
		dnsPolicy?: "ClusterFirstWithHostNet" | "ClusterFirst" | "Default" | "None"
		enableFeatures?: [...strings.MinRunes(
			1)]
		enableServiceLinks?:     bool
		enforcedNamespaceLabel?: string
		evaluationInterval?:     =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		excludedFromEnforcement?: [...{
			group?:     "monitoring.coreos.com"
			name?:      string
			namespace!: strings.MinRunes(
					1)
			resource!:  "prometheusrules" | "servicemonitors" | "podmonitors" | "probes" | "scrapeconfigs"
		}]
		externalPrefix?: string
		grpcServerTlsConfig?: {
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
			caFile?: string
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
			certFile?:           string
			insecureSkipVerify?: bool
			keyFile?:            string
			keySecret?: {
				key!:      string
				name?:     string
				optional?: bool
			}
			maxVersion?: "TLS10" | "TLS11" | "TLS12" | "TLS13"
			minVersion?: "TLS10" | "TLS11" | "TLS12" | "TLS13"
			serverName?: string
		}
		hostAliases?: [...{
			hostnames!: [...string]
			ip!: string
		}]
		hostUsers?:       bool
		image?:           string
		imagePullPolicy?: "" | "Always" | "Never" | "IfNotPresent"
		imagePullSecrets?: [...{
			name?: string
		}]
		initContainers?: [...{
			args?: [...string]
			command?: [...string]
			env?: [...{
				name!:  string
				value?: string
				valueFrom?: {
					configMapKeyRef?: {
						key!:      string
						name?:     string
						optional?: bool
					}
					fieldRef?: {
						apiVersion?: string
						fieldPath!:  string
					}
					fileKeyRef?: {
						key!:        string
						optional?:   bool
						path!:       string
						volumeName!: string
					}
					resourceFieldRef?: {
						containerName?: string
						divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						resource!: string
					}
					secretKeyRef?: {
						key!:      string
						name?:     string
						optional?: bool
					}
				}
			}]
			envFrom?: [...{
				configMapRef?: {
					name?:     string
					optional?: bool
				}
				prefix?: string
				secretRef?: {
					name?:     string
					optional?: bool
				}
			}]
			image?:           string
			imagePullPolicy?: string
			lifecycle?: {
				postStart?: {
					exec?: command?: [...string]
					httpGet?: {
						host?: string
						httpHeaders?: [...{
							name!:  string
							value!: string
						}]
						path?: string
						port!: matchN(>=1, [int, string]) & (int | string)
						scheme?: string
					}
					sleep?: seconds!: int64 & int
					tcpSocket?: {
						host?: string
						port!: matchN(>=1, [int, string]) & (int | string)
					}
				}
				preStop?: {
					exec?: command?: [...string]
					httpGet?: {
						host?: string
						httpHeaders?: [...{
							name!:  string
							value!: string
						}]
						path?: string
						port!: matchN(>=1, [int, string]) & (int | string)
						scheme?: string
					}
					sleep?: seconds!: int64 & int
					tcpSocket?: {
						host?: string
						port!: matchN(>=1, [int, string]) & (int | string)
					}
				}
				stopSignal?: string
			}
			livenessProbe?: {
				exec?: command?: [...string]
				failureThreshold?: int32 & int
				grpc?: {
					port!:    int32 & int
					service?: string
				}
				httpGet?: {
					host?: string
					httpHeaders?: [...{
						name!:  string
						value!: string
					}]
					path?: string
					port!: matchN(>=1, [int, string]) & (int | string)
					scheme?: string
				}
				initialDelaySeconds?: int32 & int
				periodSeconds?:       int32 & int
				successThreshold?:    int32 & int
				tcpSocket?: {
					host?: string
					port!: matchN(>=1, [int, string]) & (int | string)
				}
				terminationGracePeriodSeconds?: int64 & int
				timeoutSeconds?:                int32 & int
			}
			name!: string
			ports?: [...{
				containerPort!: int32 & int
				hostIP?:        string
				hostPort?:      int32 & int
				name?:          string
				protocol?:      string
			}]
			readinessProbe?: {
				exec?: command?: [...string]
				failureThreshold?: int32 & int
				grpc?: {
					port!:    int32 & int
					service?: string
				}
				httpGet?: {
					host?: string
					httpHeaders?: [...{
						name!:  string
						value!: string
					}]
					path?: string
					port!: matchN(>=1, [int, string]) & (int | string)
					scheme?: string
				}
				initialDelaySeconds?: int32 & int
				periodSeconds?:       int32 & int
				successThreshold?:    int32 & int
				tcpSocket?: {
					host?: string
					port!: matchN(>=1, [int, string]) & (int | string)
				}
				terminationGracePeriodSeconds?: int64 & int
				timeoutSeconds?:                int32 & int
			}
			resizePolicy?: [...{
				resourceName!:  string
				restartPolicy!: string
			}]
			resources?: {
				claims?: [...{
					name!:    string
					request?: string
				}]
				limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
				requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			}
			restartPolicy?: string
			restartPolicyRules?: [...{
				action!: string
				exitCodes?: {
					operator!: string
					values?: [...int32 & int]
				}
			}]
			securityContext?: {
				allowPrivilegeEscalation?: bool
				appArmorProfile?: {
					localhostProfile?: string
					type!:             string
				}
				capabilities?: {
					add?: [...string]
					drop?: [...string]
				}
				privileged?:             bool
				procMount?:              string
				readOnlyRootFilesystem?: bool
				runAsGroup?:             int64 & int
				runAsNonRoot?:           bool
				runAsUser?:              int64 & int
				seLinuxOptions?: {
					level?: string
					role?:  string
					type?:  string
					user?:  string
				}
				seccompProfile?: {
					localhostProfile?: string
					type!:             string
				}
				windowsOptions?: {
					gmsaCredentialSpec?:     string
					gmsaCredentialSpecName?: string
					hostProcess?:            bool
					runAsUserName?:          string
				}
			}
			startupProbe?: {
				exec?: command?: [...string]
				failureThreshold?: int32 & int
				grpc?: {
					port!:    int32 & int
					service?: string
				}
				httpGet?: {
					host?: string
					httpHeaders?: [...{
						name!:  string
						value!: string
					}]
					path?: string
					port!: matchN(>=1, [int, string]) & (int | string)
					scheme?: string
				}
				initialDelaySeconds?: int32 & int
				periodSeconds?:       int32 & int
				successThreshold?:    int32 & int
				tcpSocket?: {
					host?: string
					port!: matchN(>=1, [int, string]) & (int | string)
				}
				terminationGracePeriodSeconds?: int64 & int
				timeoutSeconds?:                int32 & int
			}
			stdin?:                    bool
			stdinOnce?:                bool
			terminationMessagePath?:   string
			terminationMessagePolicy?: string
			tty?:                      bool
			volumeDevices?: [...{
				devicePath!: string
				name!:       string
			}]
			volumeMounts?: [...{
				mountPath!:         string
				mountPropagation?:  string
				name!:              string
				readOnly?:          bool
				recursiveReadOnly?: string
				subPath?:           string
				subPathExpr?:       string
			}]
			workingDir?: string
		}]
		labels?: [string]: string
		listenLocal?:     bool
		logFormat?:       "" | "logfmt" | "json"
		logLevel?:        "" | "debug" | "info" | "warn" | "error"
		minReadySeconds?: int32 & int & >=0
		nodeSelector?: [string]: string
		objectStorageConfig?: {
			key!:      string
			name?:     string
			optional?: bool
		}
		objectStorageConfigFile?: string
		paused?:                  bool
		podMetadata?: {
			annotations?: [string]: string
			labels?: [string]:      string
			name?: string
		}
		portName?:          string
		priorityClassName?: string
		prometheusRulesExcludedFromEnforce?: [...{
			ruleName!:      string
			ruleNamespace!: string
		}]
		queryConfig?: {
			key!:      string
			name?:     string
			optional?: bool
		}
		queryEndpoints?: [...string]
		remoteWrite?: [...{
			authorization?: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				credentialsFile?: string
				type?:            string
			}
			azureAd?: {
				cloud?: "AzureChina" | "AzureGovernment" | "AzurePublic"
				managedIdentity?: clientId?: strings.MinRunes(
								1)
				oauth?: {
					clientId!: strings.MinRunes(
							1)
					clientSecret!: {
						key!:      string
						name?:     string
						optional?: bool
					}
					tenantId!: strings.MinRunes(
							1) & =~"^[0-9a-zA-Z-.]+$"
				}
				sdk?: tenantId?: =~"^[0-9a-zA-Z-.]+$"
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
			bearerToken?:     string
			bearerTokenFile?: string
			enableHTTP2?:     bool
			followRedirects?: bool
			headers?: [string]: string
			messageVersion?: "V1.0" | "V2.0"
			metadataConfig?: {
				maxSamplesPerSend?: int32 & int & >=-1
				send?:              bool
				sendInterval?:      =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			}
			name?:    string
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
			queueConfig?: {
				batchSendDeadline?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
				capacity?:          int
				maxBackoff?:        =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
				maxRetries?:        int
				maxSamplesPerSend?: int
				maxShards?:         int
				minBackoff?:        =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
				minShards?:         int
				retryOnRateLimit?:  bool
				sampleAgeLimit?:    =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			}
			remoteTimeout?:        =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			roundRobinDNS?:        bool
			sendExemplars?:        bool
			sendNativeHistograms?: bool
			sigv4?: {
				accessKey?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				profile?: string
				region?:  string
				roleArn?: string
				secretKey?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				useFIPSSTSEndpoint?: bool
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
				caFile?: string
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
				certFile?:           string
				insecureSkipVerify?: bool
				keyFile?:            string
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
				1)
			writeRelabelConfigs?: [...{
				action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
				modulus?:     int64 & int
				regex?:       string
				replacement?: string
				separator?:   string
				sourceLabels?: [...string]
				targetLabel?: string
			}]
		}]
		replicas?:    int32 & int
		resendDelay?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		resources?: {
			claims?: [...{
				name!:    string
				request?: string
			}]
			limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
		}
		retention?:          =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		routePrefix?:        string
		ruleConcurrentEval?: int32 & int & >=1
		ruleGracePeriod?:    =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		ruleNamespaceSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		ruleOutageTolerance?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		ruleQueryOffset?:     =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		ruleSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		securityContext?: {
			appArmorProfile?: {
				localhostProfile?: string
				type!:             string
			}
			fsGroup?:             int64 & int
			fsGroupChangePolicy?: string
			runAsGroup?:          int64 & int
			runAsNonRoot?:        bool
			runAsUser?:           int64 & int
			seLinuxChangePolicy?: string
			seLinuxOptions?: {
				level?: string
				role?:  string
				type?:  string
				user?:  string
			}
			seccompProfile?: {
				localhostProfile?: string
				type!:             string
			}
			supplementalGroups?: [...int64 & int]
			supplementalGroupsPolicy?: string
			sysctls?: [...{
				name!:  string
				value!: string
			}]
			windowsOptions?: {
				gmsaCredentialSpec?:     string
				gmsaCredentialSpecName?: string
				hostProcess?:            bool
				runAsUserName?:          string
			}
		}
		serviceAccountName?: string
		serviceName?:        strings.MinRunes(
					1)
		storage?: {
			disableMountSubPath?: bool
			emptyDir?: {
				medium?: string
				sizeLimit?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			}
			ephemeral?: volumeClaimTemplate?: {
				metadata?: {}
				spec!: {
					accessModes?: [...string]
					dataSource?: {
						apiGroup?: string
						kind!:     string
						name!:     string
					}
					dataSourceRef?: {
						apiGroup?:  string
						kind!:      string
						name!:      string
						namespace?: string
					}
					resources?: {
						limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}
					selector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					storageClassName?:          string
					volumeAttributesClassName?: string
					volumeMode?:                string
					volumeName?:                string
				}
			}
			volumeClaimTemplate?: {
				apiVersion?: string
				kind?:       string
				metadata?: {
					annotations?: [string]: string
					labels?: [string]:      string
					name?: string
				}
				spec?: {
					accessModes?: [...string]
					dataSource?: {
						apiGroup?: string
						kind!:     string
						name!:     string
					}
					dataSourceRef?: {
						apiGroup?:  string
						kind!:      string
						name!:      string
						namespace?: string
					}
					resources?: {
						limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}
					selector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					storageClassName?:          string
					volumeAttributesClassName?: string
					volumeMode?:                string
					volumeName?:                string
				}
				status?: {
					accessModes?: [...string]
					allocatedResourceStatuses?: [string]: string
					allocatedResources?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					capacity?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					conditions?: [...{
						lastProbeTime?:      time.Time
						lastTransitionTime?: time.Time
						message?:            string
						reason?:             string
						status!:             string
						type!:               string
					}]
					currentVolumeAttributesClassName?: string
					modifyVolumeStatus?: {
						status!:                          string
						targetVolumeAttributesClassName?: string
					}
					phase?: string
				}
			}
		}
		terminationGracePeriodSeconds?: int64 & int & >=0
		tolerations?: [...{
			effect?:            string
			key?:               string
			operator?:          string
			tolerationSeconds?: int64 & int
			value?:             string
		}]
		topologySpreadConstraints?: [...{
			labelSelector?: {
				matchExpressions?: [...{
					key!:      string
					operator!: string
					values?: [...string]
				}]
				matchLabels?: [string]: string
			}
			matchLabelKeys?: [...string]
			maxSkew!:            int32 & int
			minDomains?:         int32 & int
			nodeAffinityPolicy?: string
			nodeTaintsPolicy?:   string
			topologyKey!:        string
			whenUnsatisfiable!:  string
		}]
		tracingConfig?: {
			key!:      string
			name?:     string
			optional?: bool
		}
		tracingConfigFile?: string
		version?:           string
		volumeMounts?: [...{
			mountPath!:         string
			mountPropagation?:  string
			name!:              string
			readOnly?:          bool
			recursiveReadOnly?: string
			subPath?:           string
			subPathExpr?:       string
		}]
		volumes?: [...{
			awsElasticBlockStore?: {
				fsType?:    string
				partition?: int32 & int
				readOnly?:  bool
				volumeID!:  string
			}
			azureDisk?: {
				cachingMode?: string
				diskName!:    string
				diskURI!:     string
				fsType?:      string
				kind?:        string
				readOnly?:    bool
			}
			azureFile?: {
				readOnly?:   bool
				secretName!: string
				shareName!:  string
			}
			cephfs?: {
				monitors!: [...string]
				path?:       string
				readOnly?:   bool
				secretFile?: string
				secretRef?: name?: string
				user?: string
			}
			cinder?: {
				fsType?:   string
				readOnly?: bool
				secretRef?: name?: string
				volumeID!: string
			}
			configMap?: {
				defaultMode?: int32 & int
				items?: [...{
					key!:  string
					mode?: int32 & int
					path!: string
				}]
				name?:     string
				optional?: bool
			}
			csi?: {
				driver!: string
				fsType?: string
				nodePublishSecretRef?: name?: string
				readOnly?: bool
				volumeAttributes?: [string]: string
			}
			downwardAPI?: {
				defaultMode?: int32 & int
				items?: [...{
					fieldRef?: {
						apiVersion?: string
						fieldPath!:  string
					}
					mode?: int32 & int
					path!: string
					resourceFieldRef?: {
						containerName?: string
						divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						resource!: string
					}
				}]
			}
			emptyDir?: {
				medium?: string
				sizeLimit?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			}
			ephemeral?: volumeClaimTemplate?: {
				metadata?: {}
				spec!: {
					accessModes?: [...string]
					dataSource?: {
						apiGroup?: string
						kind!:     string
						name!:     string
					}
					dataSourceRef?: {
						apiGroup?:  string
						kind!:      string
						name!:      string
						namespace?: string
					}
					resources?: {
						limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					}
					selector?: {
						matchExpressions?: [...{
							key!:      string
							operator!: string
							values?: [...string]
						}]
						matchLabels?: [string]: string
					}
					storageClassName?:          string
					volumeAttributesClassName?: string
					volumeMode?:                string
					volumeName?:                string
				}
			}
			fc?: {
				fsType?:   string
				lun?:      int32 & int
				readOnly?: bool
				targetWWNs?: [...string]
				wwids?: [...string]
			}
			flexVolume?: {
				driver!: string
				fsType?: string
				options?: [string]: string
				readOnly?: bool
				secretRef?: name?: string
			}
			flocker?: {
				datasetName?: string
				datasetUUID?: string
			}
			gcePersistentDisk?: {
				fsType?:    string
				partition?: int32 & int
				pdName!:    string
				readOnly?:  bool
			}
			gitRepo?: {
				directory?:  string
				repository!: string
				revision?:   string
			}
			glusterfs?: {
				endpoints!: string
				path!:      string
				readOnly?:  bool
			}
			hostPath?: {
				path!: string
				type?: string
			}
			image?: {
				pullPolicy?: string
				reference?:  string
			}
			iscsi?: {
				chapAuthDiscovery?: bool
				chapAuthSession?:   bool
				fsType?:            string
				initiatorName?:     string
				iqn!:               string
				iscsiInterface?:    string
				lun!:               int32 & int
				portals?: [...string]
				readOnly?: bool
				secretRef?: name?: string
				targetPortal!: string
			}
			name!: string
			nfs?: {
				path!:     string
				readOnly?: bool
				server!:   string
			}
			persistentVolumeClaim?: {
				claimName!: string
				readOnly?:  bool
			}
			photonPersistentDisk?: {
				fsType?: string
				pdID!:   string
			}
			portworxVolume?: {
				fsType?:   string
				readOnly?: bool
				volumeID!: string
			}
			projected?: {
				defaultMode?: int32 & int
				sources?: [...{
					clusterTrustBundle?: {
						labelSelector?: {
							matchExpressions?: [...{
								key!:      string
								operator!: string
								values?: [...string]
							}]
							matchLabels?: [string]: string
						}
						name?:       string
						optional?:   bool
						path!:       string
						signerName?: string
					}
					configMap?: {
						items?: [...{
							key!:  string
							mode?: int32 & int
							path!: string
						}]
						name?:     string
						optional?: bool
					}
					downwardAPI?: items?: [...{
						fieldRef?: {
							apiVersion?: string
							fieldPath!:  string
						}
						mode?: int32 & int
						path!: string
						resourceFieldRef?: {
							containerName?: string
							divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							resource!: string
						}
					}]
					podCertificate?: {
						certificateChainPath?: string
						credentialBundlePath?: string
						keyPath?:              string
						keyType!:              string
						maxExpirationSeconds?: int32 & int
						signerName!:           string
					}
					secret?: {
						items?: [...{
							key!:  string
							mode?: int32 & int
							path!: string
						}]
						name?:     string
						optional?: bool
					}
					serviceAccountToken?: {
						audience?:          string
						expirationSeconds?: int64 & int
						path!:              string
					}
				}]
			}
			quobyte?: {
				group?:    string
				readOnly?: bool
				registry!: string
				tenant?:   string
				user?:     string
				volume!:   string
			}
			rbd?: {
				fsType?:  string
				image!:   string
				keyring?: string
				monitors!: [...string]
				pool?:     string
				readOnly?: bool
				secretRef?: name?: string
				user?: string
			}
			scaleIO?: {
				fsType?:           string
				gateway!:          string
				protectionDomain?: string
				readOnly?:         bool
				secretRef!: name?: string
				sslEnabled?:  bool
				storageMode?: string
				storagePool?: string
				system!:      string
				volumeName?:  string
			}
			secret?: {
				defaultMode?: int32 & int
				items?: [...{
					key!:  string
					mode?: int32 & int
					path!: string
				}]
				optional?:   bool
				secretName?: string
			}
			storageos?: {
				fsType?:   string
				readOnly?: bool
				secretRef?: name?: string
				volumeName?:      string
				volumeNamespace?: string
			}
			vsphereVolume?: {
				fsType?:            string
				storagePolicyID?:   string
				storagePolicyName?: string
				volumePath!:        string
			}
		}]
		web?: {
			httpConfig?: {
				headers?: {
					contentSecurityPolicy?:   string
					strictTransportSecurity?: string
					xContentTypeOptions?:     "" | "NoSniff"
					xFrameOptions?:           "" | "Deny" | "SameOrigin"
					xXSSProtection?:          string
				}
				http2?: bool
			}
			tlsConfig?: {
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
				certFile?: string
				cipherSuites?: [...string]
				client_ca?: {
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
				clientAuthType?: string
				clientCAFile?:   string
				curvePreferences?: [...string]
				keyFile?: string
				keySecret?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				maxVersion?:               string
				minVersion?:               string
				preferServerCipherSuites?: bool
			}
		}
	}
	status?: {
		availableReplicas?: int32 & int
		conditions?: [...{
			lastTransitionTime!: time.Time
			message?:            string
			observedGeneration?: int64 & int
			reason?:             string
			status!:             strings.MinRunes(
						1)
			type!:               strings.MinRunes(
						1)
		}]
		paused?:              bool
		replicas?:            int32 & int
		unavailableReplicas?: int32 & int
		updatedReplicas?:     int32 & int
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "ThanosRuler"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
