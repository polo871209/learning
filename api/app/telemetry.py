"""
OpenTelemetry configuration for metrics instrumentation.
"""

from opentelemetry import metrics
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.metrics.view import View
from opentelemetry.sdk.resources import SERVICE_NAME, Resource


def setup_telemetry(service_name: str) -> PrometheusMetricReader:
    """
    Setup OpenTelemetry with Prometheus exporter.

    Args:
        service_name: Name of the service for telemetry

    Returns:
        PrometheusMetricReader instance for exposing metrics
    """
    # Create a resource with service name
    resource = Resource(attributes={SERVICE_NAME: service_name})

    # Create Prometheus metric reader
    prometheus_reader = PrometheusMetricReader()

    # Define views to rename http.server metrics to api metrics
    # Covers the Four Golden Signals:
    # 1. Latency - api_duration_milliseconds
    # 2. Traffic - api_request_count (derived from duration histogram)
    # 3. Errors - api_duration_milliseconds with http_status_code label
    # 4. Saturation - api_active_requests
    views = [
        # Saturation: Active requests (gauge)
        View(
            instrument_name="http.server.active_requests",
            name="api_active_requests",
        ),
        # Latency: Request duration (histogram)
        View(
            instrument_name="http.server.duration",
            name="api_duration_milliseconds",
        ),
        # Additional: Response size
        View(
            instrument_name="http.server.response.size",
            name="api_response_size_bytes",
        ),
        # Additional: Request size
        View(
            instrument_name="http.server.request.size",
            name="api_request_size_bytes",
        ),
    ]

    # Create meter provider with Prometheus reader and custom views
    meter_provider = MeterProvider(
        resource=resource, metric_readers=[prometheus_reader], views=views
    )

    # Set the global meter provider
    metrics.set_meter_provider(meter_provider)

    return prometheus_reader
