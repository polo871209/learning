# syntax=docker/dockerfile:1
# ref: https://github.com/BretFisher/mastodon/blob/chainguard/Dockerfile 

# wolfi-baselayout
FROM az871209/baseimage:latest AS base

FROM az871209/baseimage-dev:latest AS prep-python
COPY --from=base / /base-chroot

RUN apk add --no-script --no-commit-hooks --no-cache --root /base-chroot bash-binsh
RUN apk add --no-cache --root /base-chroot \
      python-3.14

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Smoketest
RUN chroot /base-chroot python --version
RUN apk del --no-script --no-commit-hooks --no-cache --root /base-chroot bash-binsh

FROM base AS python-prod
COPY --from=prep-python /base-chroot /
USER nonroot

FROM az871209/baseimage-dev:latest AS base-uv

RUN apk add --no-cache \
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
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen --only-group migration

# Migration runtime stage
FROM python-prod AS migrations

ENV PYTHONPATH="/migrations" \
    PATH="/migrations/.venv/bin:$PATH"

WORKDIR /migrations
COPY --from=migration-builder --chown=nonroot:nonroot /migrations/.venv /migrations/.venv

COPY --chown=nonroot:nonroot alembic.ini ./
COPY --chown=nonroot:nonroot alembic/ ./alembic/
COPY --chown=nonroot:nonroot app/models.py ./app/models.py
COPY --chown=nonroot:nonroot app/config.py ./app/config.py
COPY --chown=nonroot:nonroot app/__init__.py ./app/__init__.py

# ============================================
# Application Builder Stage
# ============================================
FROM base-uv AS app-builder

WORKDIR /app
COPY pyproject.toml uv.lock ./

RUN uv sync --frozen

# Application runtime stage
FROM python-prod AS app

ENV PYTHONPATH="/app" \
    PATH="/app/.venv/bin:$PATH"

WORKDIR /app
COPY --from=app-builder --chown=nonroot:nonroot /app/.venv /app/.venv

COPY --chown=nonroot:nonroot app/ ./app/
