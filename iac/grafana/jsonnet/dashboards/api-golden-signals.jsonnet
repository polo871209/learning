// API Golden Signals Dashboard
// Displays the Four Golden Signals for API monitoring:
// 1. Latency - How long it takes to service a request
// 2. Traffic - How much demand is being placed on the system
// 3. Errors - The rate of requests that fail
// 4. Saturation - How "full" the service is

local g = import 'github.com/grafana/grafonnet/gen/grafonnet-latest/main.libsonnet';
local goldenSignals = import '../lib/golden-signals.libsonnet';

g.dashboard.new('API Golden Signals')
+ g.dashboard.withUid('api-golden-signals')
+ g.dashboard.withDescription('Golden Signals dashboard for API metrics: Latency, Traffic, Errors, and Saturation')
+ g.dashboard.withTags(['api', 'golden-signals', 'sre', 'monitoring'])
+ g.dashboard.withRefresh('30s')
+ g.dashboard.time.withFrom('now-1h')
+ g.dashboard.time.withTo('now')
+ g.dashboard.withTimezone('browser')
+ g.dashboard.withEditable(true)
+ g.dashboard.graphTooltip.withSharedCrosshair()

// Add datasource variable
+ g.dashboard.withVariables([
  g.dashboard.variable.datasource.new('datasource', 'prometheus'),
])

// Add panels
+ g.dashboard.withPanels([
  // === SUMMARY STATS ROW (Top) ===
  goldenSignals.requestRateStat('Total Request Rate', x=0, y=0),
  goldenSignals.errorRateStat('Error Rate (4xx + 5xx)', x=6, y=0),
  goldenSignals.avgLatencyStat('Avg Latency (p95)', x=12, y=0),
  goldenSignals.activeRequestsStat('Active Requests', x=18, y=0),

  // === LATENCY ROW ===
  goldenSignals.latencyByEndpointPanel('API Request Duration by Endpoint', x=0, y=4),
  goldenSignals.avgLatencyByEndpointPanel('Average Latency by Endpoint', x=12, y=4),

  // === TRAFFIC ROW ===
  goldenSignals.trafficByEndpointPanel('Request Rate by Endpoint', x=0, y=12),
  goldenSignals.trafficByMethodPanel('Request Rate by Method', x=12, y=12),

  // === ERROR ROW 1 ===
  goldenSignals.errorRatePanel('Error Rate by Status Code', x=0, y=20),
  goldenSignals.errorPercentagePanel('Error Percentage', x=12, y=20),

  // === ERROR ROW 2 ===
  goldenSignals.errorsByEndpointPanel('Errors by Endpoint', x=0, y=28),

  // === SATURATION ROW ===
  goldenSignals.saturationPanel('Active Requests by Endpoint', x=0, y=36),
  goldenSignals.saturationByPodPanel('Active Requests by Pod', x=12, y=36),

  // === REQUEST/RESPONSE SIZE ROW ===
  goldenSignals.requestSizePanel('Request Size (p95, avg)', x=0, y=44),
  goldenSignals.responseSizePanel('Response Size (p95, avg)', x=12, y=44),
])
