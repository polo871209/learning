import logging

from opentelemetry import trace

from app.config import settings


class TraceContextFormatter(logging.Formatter):
    """Custom formatter that adds trace_id and span_id to log records"""

    def format(self, record: logging.LogRecord) -> str:
        # Get current span context
        span = trace.get_current_span()
        span_context = span.get_span_context()

        # Add trace_id and span_id to the record
        if span_context.is_valid:
            record.trace_id = format(span_context.trace_id, "032x")
            record.span_id = format(span_context.span_id, "016x")
        else:
            record.trace_id = "0" * 32
            record.span_id = "0" * 16

        return super().format(record)


class ColoredTraceFormatter(TraceContextFormatter):
    """Colored formatter with trace context for console output"""

    LEVEL_COLORS = {
        logging.DEBUG: "\033[36m",  # Cyan
        logging.INFO: "\033[32m",  # Green
        logging.WARNING: "\033[33m",  # Yellow
        logging.ERROR: "\033[31m",  # Red
        logging.CRITICAL: "\033[35m",  # Magenta
    }
    RESET = "\033[0m"

    def format(self, record: logging.LogRecord) -> str:
        # Add color to level name
        color = self.LEVEL_COLORS.get(record.levelno, self.RESET)
        record.levelname = f"{color}{record.levelname}{self.RESET}"

        return super().format(record)


class AccessLogFormatter(logging.Formatter):
    """Formatter for uvicorn access logs with trace context"""

    def format(self, record: logging.LogRecord) -> str:
        # Add trace context
        span = trace.get_current_span()
        span_context = span.get_span_context()

        if span_context.is_valid:
            record.trace_id = format(span_context.trace_id, "032x")
            record.span_id = format(span_context.span_id, "016x")
        else:
            record.trace_id = "0" * 32
            record.span_id = "0" * 16

        # Extract uvicorn access log info from args
        if (
            hasattr(record, "args")
            and record.args
            and isinstance(record.args, tuple)
            and len(record.args) >= 5
        ):
            client_addr, method, full_path, http_version, status_code = record.args[:5]
            record.client_addr = str(client_addr)
            # Uvicorn passes version as "1.1", we need to add "HTTP/" prefix
            record.request_line = f"{method} {full_path} HTTP/{http_version}"
            record.status_code = str(status_code)
        else:
            record.client_addr = "unknown"
            record.request_line = ""
            record.status_code = "0"

        return super().format(record)


class LogConfig:
    """Logging configuration for the application"""

    LOGGER_NAME: str = settings.app_name
    LOG_FORMAT: str = "%(levelname)s %(trace_id)s %(span_id)s %(message)s"
    ACCESS_LOG_FORMAT: str = "%(levelname)s %(client_addr)s %(trace_id)s %(span_id)s %(request_line)s %(status_code)s"
    LOG_LEVEL: str = "DEBUG" if settings.debug else "INFO"

    @classmethod
    def get_config(cls) -> dict:
        """Get the logging configuration as a dictionary"""
        return {
            "version": 1,
            "disable_existing_loggers": False,
            "formatters": {
                "default": {
                    "()": "app.logger.ColoredTraceFormatter",
                    "fmt": cls.LOG_FORMAT,
                },
                "access": {
                    "()": "app.logger.AccessLogFormatter",
                    "fmt": cls.ACCESS_LOG_FORMAT,
                },
            },
            "handlers": {
                "default": {
                    "formatter": "default",
                    "class": "logging.StreamHandler",
                    "stream": "ext://sys.stdout",
                },
                "access": {
                    "formatter": "access",
                    "class": "logging.StreamHandler",
                    "stream": "ext://sys.stdout",
                },
            },
            "loggers": {
                "": {  # Root logger catches all
                    "handlers": ["default"],
                    "level": cls.LOG_LEVEL,
                },
                "uvicorn.access": {
                    "handlers": ["access"],
                    "level": cls.LOG_LEVEL,
                    "propagate": False,
                },
            },
        }


def setup_logging():
    """Initialize logging configuration"""
    from logging.config import dictConfig

    dictConfig(LogConfig.get_config())


def get_logger(name: str | None = None) -> logging.Logger:
    """
    Get a logger instance.

    Args:
        name: Optional logger name. If not provided, uses the app name from settings.

    Returns:
        Logger instance
    """
    if name is None:
        name = settings.app_name
    return logging.getLogger(name)


# Create a global logger instance that can be imported directly
logger = get_logger()
