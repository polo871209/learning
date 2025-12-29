package v1

import (
	"strings"
	"time"
)

#PrometheusRule: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec!: groups?: [...{
		interval?: =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		labels?: [string]: string
		limit?:                     int
		name!:                      strings.MinRunes(
						1)
		partial_response_strategy?: =~"^(?i)(abort|warn)?$"
		query_offset?:              =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
		rules?: [...{
			alert?: string
			annotations?: [string]: string
			expr!: matchN(>=1, [int, string]) & (int | string)
			for?:             =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			keep_firing_for?: strings.MinRunes(
						1) & =~"^(0|(([0-9]+)y)?(([0-9]+)w)?(([0-9]+)d)?(([0-9]+)h)?(([0-9]+)m)?(([0-9]+)s)?(([0-9]+)ms)?)$"
			labels?: [string]: string
			record?: string
		}]
	}]
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
	kind:       "PrometheusRule"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]:      string
		annotations?: [string]: string
		...
	}
}
