from opentelemetry import metrics
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.view import View
from opentelemetry.sdk.resources import SERVICE_NAME, Resource


def setup_telemetry(service_name: str) -> PrometheusMetricReader:
    resource = Resource(attributes={SERVICE_NAME: service_name})
    prometheus_reader = PrometheusMetricReader()

    views = [
        View(
            instrument_name="http.server.active_requests",
            name="api_active_requests",
        ),
        View(
            instrument_name="http.server.duration",
            name="api_duration_milliseconds",
        ),
        View(
            instrument_name="http.server.response.size",
            name="api_response_size_bytes",
        ),
        View(
            instrument_name="http.server.request.size",
            name="api_request_size_bytes",
        ),
    ]

    meter_provider = MeterProvider(
        resource=resource, metric_readers=[prometheus_reader], views=views
    )

    metrics.set_meter_provider(meter_provider)

    return prometheus_reader
