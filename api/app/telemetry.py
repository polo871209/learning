"""
OpenTelemetry configuration for metrics instrumentation.
"""

from opentelemetry import metrics
from opentelemetry.exporter.prometheus import PrometheusMetricReader
from opentelemetry.sdk.metrics import MeterProvider
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

    # Create meter provider with Prometheus reader
    meter_provider = MeterProvider(
        resource=resource, metric_readers=[prometheus_reader]
    )

    # Set the global meter provider
    metrics.set_meter_provider(meter_provider)

    return prometheus_reader
