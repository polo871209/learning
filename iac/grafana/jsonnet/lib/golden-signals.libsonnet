// Golden Signals Library for API Metrics
// Based on actual Prometheus metrics with labels:
// - http_method, http_target, http_status_code, job, namespace, pod

local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';

local prometheusQuery(query, legend='') =
  g.query.prometheus.new('$datasource', query)
  + g.query.prometheus.withLegendFormat(legend);

{
  // === LATENCY PANELS ===
  
  // Latency percentiles by endpoint
  latencyByEndpointPanel(title='API Request Duration by Endpoint', x=0, y=0, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'histogram_quantile(0.50, sum by (le, http_target, http_method) (rate(api_duration_milliseconds_bucket[5m])))',
        'p50 - {{http_method}} {{http_target}}'
      ),
      prometheusQuery(
        'histogram_quantile(0.95, sum by (le, http_target, http_method) (rate(api_duration_milliseconds_bucket[5m])))',
        'p95 - {{http_method}} {{http_target}}'
      ),
      prometheusQuery(
        'histogram_quantile(0.99, sum by (le, http_target, http_method) (rate(api_duration_milliseconds_bucket[5m])))',
        'p99 - {{http_method}} {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('ms')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom')
    + g.panel.timeSeries.options.legend.withCalcs(['mean', 'max']),

  // Average latency by endpoint
  avgLatencyByEndpointPanel(title='Average Latency by Endpoint', x=12, y=0, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (http_target, http_method) (rate(api_duration_milliseconds_sum[5m])) / sum by (http_target, http_method) (rate(api_duration_milliseconds_count[5m]))',
        '{{http_method}} {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('ms')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom')
    + g.panel.timeSeries.options.legend.withCalcs(['mean', 'last']),

  // === TRAFFIC PANELS ===
  
  // Request rate by endpoint
  trafficByEndpointPanel(title='Request Rate by Endpoint', x=0, y=8, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (http_target, http_method) (rate(api_duration_milliseconds_count[5m]))',
        '{{http_method}} {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('reqps')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withDrawStyle('bars')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withBarAlignment(0)
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom')
    + g.panel.timeSeries.options.legend.withCalcs(['mean', 'last']),

  // Request rate by method
  trafficByMethodPanel(title='Request Rate by Method', x=12, y=8, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (http_method) (rate(api_duration_milliseconds_count[5m]))',
        '{{http_method}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('reqps')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(20)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('list')
    + g.panel.timeSeries.options.legend.withPlacement('bottom'),

  // === ERROR PANELS ===
  
  // Error rate by status code
  errorRatePanel(title='Error Rate by Status Code', x=0, y=16, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (http_status_code) (rate(api_duration_milliseconds_count{http_status_code=~"4.."}[5m]))',
        '4xx - {{http_status_code}}'
      ),
      prometheusQuery(
        'sum by (http_status_code) (rate(api_duration_milliseconds_count{http_status_code=~"5.."}[5m]))',
        '5xx - {{http_status_code}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('reqps')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom')
    + g.panel.timeSeries.options.legend.withCalcs(['mean', 'max']),

  // Error percentage
  errorPercentagePanel(title='Error Percentage', x=12, y=16, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum(rate(api_duration_milliseconds_count{http_status_code=~"4.."}[5m])) / sum(rate(api_duration_milliseconds_count[5m])) * 100',
        '4xx %'
      ),
      prometheusQuery(
        'sum(rate(api_duration_milliseconds_count{http_status_code=~"5.."}[5m])) / sum(rate(api_duration_milliseconds_count[5m])) * 100',
        '5xx %'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('percent')
    + g.panel.timeSeries.standardOptions.withMax(100)
    + g.panel.timeSeries.standardOptions.withMin(0)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(20)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi'),

  // Errors by endpoint
  errorsByEndpointPanel(title='Errors by Endpoint', x=0, y=24, w=24, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (http_target, http_status_code) (rate(api_duration_milliseconds_count{http_status_code=~"[45].."}[5m]))',
        '{{http_status_code}} - {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('reqps')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom')
    + g.panel.timeSeries.options.legend.withCalcs(['sum', 'mean']),

  // === SATURATION PANELS ===
  
  // Active requests
  saturationPanel(title='Active Requests', x=0, y=32, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (http_method, http_target) (api_active_requests)',
        '{{http_method}} {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('short')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('auto')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom')
    + g.panel.timeSeries.options.legend.withCalcs(['mean', 'max']),

  // Active requests by pod
  saturationByPodPanel(title='Active Requests by Pod', x=12, y=32, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'sum by (pod) (api_active_requests)',
        '{{pod}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('short')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('auto')
    + g.panel.timeSeries.options.tooltip.withMode('multi'),

  // === REQUEST/RESPONSE SIZE PANELS ===
  
  // Request size percentiles
  requestSizePanel(title='Request Size (p95, avg)', x=0, y=40, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'histogram_quantile(0.95, sum by (le, http_target) (rate(api_request_size_bytes_bucket[5m])))',
        'p95 - {{http_target}}'
      ),
      prometheusQuery(
        'sum by (http_target) (rate(api_request_size_bytes_sum[5m])) / sum by (http_target) (rate(api_request_size_bytes_count[5m]))',
        'avg - {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('bytes')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom'),

  // Response size percentiles
  responseSizePanel(title='Response Size (p95, avg)', x=12, y=40, w=12, h=8)::
    g.panel.timeSeries.new(title)
    + g.panel.timeSeries.gridPos.withX(x)
    + g.panel.timeSeries.gridPos.withY(y)
    + g.panel.timeSeries.gridPos.withW(w)
    + g.panel.timeSeries.gridPos.withH(h)
    + g.panel.timeSeries.queryOptions.withTargets([
      prometheusQuery(
        'histogram_quantile(0.95, sum by (le, http_target) (rate(api_response_size_bytes_bucket[5m])))',
        'p95 - {{http_target}}'
      ),
      prometheusQuery(
        'sum by (http_target) (rate(api_response_size_bytes_sum[5m])) / sum by (http_target) (rate(api_response_size_bytes_count[5m]))',
        'avg - {{http_target}}'
      ),
    ])
    + g.panel.timeSeries.standardOptions.withUnit('bytes')
    + g.panel.timeSeries.fieldConfig.defaults.custom.withFillOpacity(10)
    + g.panel.timeSeries.fieldConfig.defaults.custom.withShowPoints('never')
    + g.panel.timeSeries.options.tooltip.withMode('multi')
    + g.panel.timeSeries.options.legend.withDisplayMode('table')
    + g.panel.timeSeries.options.legend.withPlacement('bottom'),

  // === STAT PANELS (Summary) ===
  
  // Total request rate stat
  requestRateStat(title='Total Request Rate', x=0, y=48, w=6, h=4)::
    g.panel.stat.new(title)
    + g.panel.stat.gridPos.withX(x)
    + g.panel.stat.gridPos.withY(y)
    + g.panel.stat.gridPos.withW(w)
    + g.panel.stat.gridPos.withH(h)
    + g.panel.stat.queryOptions.withTargets([
      prometheusQuery(
        'sum(rate(api_duration_milliseconds_count[5m]))',
        'req/s'
      ),
    ])
    + g.panel.stat.standardOptions.withUnit('reqps')
    + g.panel.stat.options.withGraphMode('area')
    + g.panel.stat.options.withColorMode('value')
    + g.panel.stat.options.withTextMode('value_and_name')
    + g.panel.stat.standardOptions.color.withMode('thresholds')
    + g.panel.stat.standardOptions.thresholds.withSteps([
      { value: null, color: 'green' },
      { value: 10, color: 'yellow' },
      { value: 50, color: 'red' },
    ]),

  // Error rate stat
  errorRateStat(title='Error Rate (4xx + 5xx)', x=6, y=48, w=6, h=4)::
    g.panel.stat.new(title)
    + g.panel.stat.gridPos.withX(x)
    + g.panel.stat.gridPos.withY(y)
    + g.panel.stat.gridPos.withW(w)
    + g.panel.stat.gridPos.withH(h)
    + g.panel.stat.queryOptions.withTargets([
      prometheusQuery(
        'sum(rate(api_duration_milliseconds_count{http_status_code=~"[45].."}[5m])) / sum(rate(api_duration_milliseconds_count[5m])) * 100',
        'error %'
      ),
    ])
    + g.panel.stat.standardOptions.withUnit('percent')
    + g.panel.stat.options.withGraphMode('area')
    + g.panel.stat.options.withColorMode('value')
    + g.panel.stat.options.withTextMode('value_and_name')
    + g.panel.stat.standardOptions.color.withMode('thresholds')
    + g.panel.stat.standardOptions.thresholds.withSteps([
      { value: null, color: 'green' },
      { value: 1, color: 'yellow' },
      { value: 5, color: 'red' },
    ]),

  // Average latency stat
  avgLatencyStat(title='Avg Latency (p95)', x=12, y=48, w=6, h=4)::
    g.panel.stat.new(title)
    + g.panel.stat.gridPos.withX(x)
    + g.panel.stat.gridPos.withY(y)
    + g.panel.stat.gridPos.withW(w)
    + g.panel.stat.gridPos.withH(h)
    + g.panel.stat.queryOptions.withTargets([
      prometheusQuery(
        'histogram_quantile(0.95, sum(rate(api_duration_milliseconds_bucket[5m])) by (le))',
        'p95'
      ),
    ])
    + g.panel.stat.standardOptions.withUnit('ms')
    + g.panel.stat.options.withGraphMode('area')
    + g.panel.stat.options.withColorMode('value')
    + g.panel.stat.options.withTextMode('value_and_name')
    + g.panel.stat.standardOptions.color.withMode('thresholds')
    + g.panel.stat.standardOptions.thresholds.withSteps([
      { value: null, color: 'green' },
      { value: 500, color: 'yellow' },
      { value: 1000, color: 'red' },
    ]),

  // Active requests stat
  activeRequestsStat(title='Active Requests', x=18, y=48, w=6, h=4)::
    g.panel.stat.new(title)
    + g.panel.stat.gridPos.withX(x)
    + g.panel.stat.gridPos.withY(y)
    + g.panel.stat.gridPos.withW(w)
    + g.panel.stat.gridPos.withH(h)
    + g.panel.stat.queryOptions.withTargets([
      prometheusQuery(
        'sum(api_active_requests)',
        'active'
      ),
    ])
    + g.panel.stat.standardOptions.withUnit('short')
    + g.panel.stat.options.withGraphMode('area')
    + g.panel.stat.options.withColorMode('value')
    + g.panel.stat.options.withTextMode('value_and_name')
    + g.panel.stat.standardOptions.color.withMode('thresholds')
    + g.panel.stat.standardOptions.thresholds.withSteps([
      { value: null, color: 'green' },
      { value: 10, color: 'yellow' },
      { value: 50, color: 'red' },
    ]),
}
