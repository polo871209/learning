package postgres

import istio "github.com/polo871209/learning/base/crds/istio/v1"

_destinationRule: istio.#DestinationRule & {
	metadata: {
		name:      _config.name
		namespace: _config.namespace
		labels:    _config.labels
	}

	spec: {
		host: "\(_config.name).\(_config.namespace).svc.cluster.local"

		if _environment == "prod" {
			trafficPolicy: {
				connectionPool: {
					tcp: {
						maxConnections: 100
						connectTimeout: "10s"
						idleTimeout:    "1h"
						tcpKeepalive: {
							time:     "7200s" // 2 hours
							interval: "75s"
							probes:   9
						}
					}
				}

				outlierDetection: {
					consecutiveGatewayErrors: 5
					consecutive5xxErrors:     5
					interval:                 "10s"
					baseEjectionTime:         "30s"
					maxEjectionPercent:       50
					minHealthPercent:         50
				}
			}
		}
	}
}
