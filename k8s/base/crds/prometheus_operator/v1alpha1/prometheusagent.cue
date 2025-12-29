package v1alpha1

import (
	"strings"
	"time"
)

#PrometheusAgent: {
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
		additionalScrapeConfigs?: {
			key!:      string
			name?:     string
			optional?: bool
		}
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
		apiserverConfig?: {
			authorization?: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				credentialsFile?: string
				type?:            string
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
			host!:            string
			noProxy?:         string
			proxyConnectHeader?: [string]: [...{
				key!:      string
				name?:     string
				optional?: bool
			}]
			proxyFromEnvironment?: bool
			proxyUrl?:             =~"^(http|https|socks5)://.+$"
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
		}
		arbitraryFSAccessThroughSMs?: deny?: bool
		automountServiceAccountToken?: bool
		bodySizeLimit?:                =~"(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
		configMaps?: [...string]
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
		convertClassicHistogramsToNHCB?: bool
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
		enableOTLPReceiver?:            bool
		enableRemoteWriteReceiver?:     bool
		enableServiceLinks?:            bool
		enforcedBodySizeLimit?:         =~"(^0|([0-9]*[.])?[0-9]+((K|M|G|T|E|P)i?)?B)$"
		enforcedKeepDroppedTargets?:    int64 & int
		enforcedLabelLimit?:            int64 & int
		enforcedLabelNameLengthLimit?:  int64 & int
		enforcedLabelValueLengthLimit?: int64 & int
		enforcedNamespaceLabel?:        string
		enforcedSampleLimit?:           int64 & int
		enforcedTargetLimit?:           int64 & int
		excludedFromEnforcement?: [...{
			group?:     "monitoring.coreos.com"
			name?:      string
			namespace!: strings.MinRunes(
					1)
			resource!:  "prometheusrules" | "servicemonitors" | "podmonitors" | "probes" | "scrapeconfigs"
		}]
		externalLabels?: [string]: string
		externalUrl?: string
		hostAliases?: [...{
			hostnames!: [...string]
			ip!: string
		}]
		hostNetwork?:              bool
		hostUsers?:                bool
		ignoreNamespaceSelectors?: bool
		image?:                    string
		imagePullPolicy?:          "" | "Always" | "Never" | "IfNotPresent"
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
		keepDroppedTargets?:            int64 & int
		labelLimit?:                    int64 & int
		labelNameLengthLimit?:          int64 & int
		labelValueLengthLimit?:         int64 & int
		listenLocal?:                   bool
		logFormat?:                     "" | "logfmt" | "json"
		logLevel?:                      "" | "debug" | "info" | "warn" | "error"
		maximumStartupDurationSeconds?: int32 & int & >=60
		minReadySeconds?:               int32 & int & >=0
		mode?:                          "StatefulSet" | "DaemonSet"
		nameEscapingScheme?:            "AllowUTF8" | "Underscores" | "Dots" | "Values"
		nameValidationScheme?:          "UTF8" | "Legacy"
		nodeSelector?: [string]: string
		otlp?: {
			convertHistogramsToNHCB?: bool
			ignoreResourceAttributes?: [...strings.MinRunes(
				1)] & [_, ...]
			keepIdentifyingResourceAttributes?: bool
			promoteAllResourceAttributes?:      bool
			promoteResourceAttributes?: [...strings.MinRunes(
				1)] & [_, ...]
			promoteScopeMetadata?: bool
			translationStrategy?:  "NoUTF8EscapingWithSuffixes" | "UnderscoreEscapingWithSuffixes" | "NoTranslation" | "UnderscoreEscapingWithoutSuffixes"
		}
		overrideHonorLabels?:     bool
		overrideHonorTimestamps?: bool
		paused?:                  bool
		persistentVolumeClaimRetentionPolicy?: {
			whenDeleted?: string
			whenScaled?:  string
		}
		podMetadata?: {
			annotations?: [string]: string
			labels?: [string]:      string
			name?: string
		}
		podMonitorNamespaceSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		podMonitorSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		podTargetLabels?: [...string]
		portName?:          string
		priorityClassName?: string
		probeNamespaceSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		probeSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		prometheusExternalLabelName?: string
		reloadStrategy?:              "HTTP" | "ProcessSignal"
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
		remoteWriteReceiverMessageVersions?: [..."V1.0" | "V2.0"] & [_, ...]
		replicaExternalLabelName?: string
		replicas?:                 int32 & int
		resources?: {
			claims?: [...{
				name!:    string
				request?: string
			}]
			limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
		}
		routePrefix?: string
		runtime?: goGC?: int32 & int & >=-1
		sampleLimit?: int64 & int
		scrapeClasses?: [...{
			attachMetadata?: node?: bool
			authorization?: {
				credentials?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				credentialsFile?: string
				type?:            string
			}
			default?:                bool
			fallbackScrapeProtocol?: "PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"
			metricRelabelings?: [...{
				action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
				modulus?:     int64 & int
				regex?:       string
				replacement?: string
				separator?:   string
				sourceLabels?: [...string]
				targetLabel?: string
			}]
			name!: strings.MinRunes(
				1)
			relabelings?: [...{
				action?:      "replace" | "Replace" | "keep" | "Keep" | "drop" | "Drop" | "hashmod" | "HashMod" | "labelmap" | "LabelMap" | "labeldrop" | "LabelDrop" | "labelkeep" | "LabelKeep" | "lowercase" | "Lowercase" | "uppercase" | "Uppercase" | "keepequal" | "KeepEqual" | "dropequal" | "DropEqual"
				modulus?:     int64 & int
				regex?:       string
				replacement?: string
				separator?:   string
				sourceLabels?: [...string]
				targetLabel?: string
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
		}]
		scrapeClassicHistograms?: bool
		scrapeConfigNamespaceSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		scrapeConfigSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		scrapeFailureLogFile?: strings.MinRunes(
					1)
		scrapeInterval?:       =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		scrapeProtocols?: [..."PrometheusProto" | "OpenMetricsText0.0.1" | "OpenMetricsText1.0.0" | "PrometheusText0.0.4" | "PrometheusText1.0.0"]
		scrapeTimeout?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		secrets?: [...string]
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
		serviceAccountName?:   string
		serviceDiscoveryRole?: "Endpoints" | "EndpointSlice"
		serviceMonitorNamespaceSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		serviceMonitorSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		serviceName?: strings.MinRunes(
				1)
		shards?:      int32 & int
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
		targetLimit?:                   int64 & int
		terminationGracePeriodSeconds?: int64 & int & >=0
		tolerations?: [...{
			effect?:            string
			key?:               string
			operator?:          string
			tolerationSeconds?: int64 & int
			value?:             string
		}]
		topologySpreadConstraints?: [...{
			additionalLabelSelectors?: "OnResource" | "OnShard"
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
			clientType?:  "http" | "grpc"
			compression?: "gzip"
			endpoint!:    strings.MinRunes(
					1)
			headers?: [string]: string
			insecure?: bool
			samplingFraction?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			timeout?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
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
		}
		tsdb?: outOfOrderTimeWindow?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		version?: string
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
		walCompression?: bool
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
			maxConnections?: int32 & int & >=0
			pageTitle?:      string
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
		paused?:   bool
		replicas?: int32 & int
		selector?: string
		shardStatuses?: [...{
			availableReplicas!:   int32 & int
			replicas!:            int32 & int
			shardID!:             string
			unavailableReplicas!: int32 & int
			updatedReplicas!:     int32 & int
		}]
		shards?:              int32 & int
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
	apiVersion: "monitoring.coreos.com/v1alpha1"
	kind:       "PrometheusAgent"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
