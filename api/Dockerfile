# syntax=docker/dockerfile:1

# Base stage with UV and Python setup
FROM cgr.dev/chainguard/wolfi-base:latest AS base-uv

RUN apk add --no-cache \
      ca-certificates \
      py3.14-pip \
      python-3.14 \
      uv

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# ============================================
# Migration Builder Stage
# ============================================
FROM base-uv AS migration-builder

WORKDIR /migrations

# Copy project files
COPY pyproject.toml uv.lock ./

# Install only migration dependencies
RUN uv sync --frozen --no-install-project --only-group migration

# Migration runtime stage
FROM cgr.dev/chainguard/wolfi-base:latest AS migrations

RUN apk add --no-cache \
      ca-certificates \
      python-3.14 \
      tzdata

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="/migrations" \
    PATH="/migrations/.venv/bin:$PATH"

WORKDIR /migrations

# Copy virtual environment from builder
COPY --from=migration-builder --chown=nonroot:nonroot /migrations/.venv /migrations/.venv

USER nonroot

# Copy alembic configuration and migrations
COPY --chown=nonroot:nonroot alembic.ini ./
COPY --chown=nonroot:nonroot alembic/ ./alembic/
COPY --chown=nonroot:nonroot app/models.py ./app/models.py
COPY --chown=nonroot:nonroot app/config.py ./app/config.py
COPY --chown=nonroot:nonroot app/__init__.py ./app/__init__.py

# Default command runs migrations
CMD ["python", "-m", "alembic", "upgrade", "head"]

# ============================================
# Application Builder Stage
# ============================================
FROM base-uv AS app-builder

WORKDIR /app

# Copy application dependencies (without alembic)
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen

# Application runtime stage
FROM cgr.dev/chainguard/wolfi-base:latest AS app

RUN apk add --no-cache \
      ca-certificates \
      python-3.14 \
      tzdata

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="/app"

WORKDIR /app

COPY --from=app-builder --chown=nonroot:nonroot /app/.venv /app/.venv

USER nonroot

ENV PATH="/app/.venv/bin:$PATH"

COPY --chown=nonroot:nonroot app/ ./app/

EXPOSE 8000/tcp
