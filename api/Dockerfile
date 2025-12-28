# syntax=docker/dockerfile:1

FROM cgr.dev/chainguard/wolfi-base:latest AS builder

RUN apk add --no-cache \
      ca-certificates \
      py3.14-pip \
      python-3.14 \
      uv

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

WORKDIR /app

COPY pyproject.toml uv.lock ./

RUN uv sync --frozen

# Runtime stage
FROM cgr.dev/chainguard/wolfi-base:latest

RUN apk add --no-cache \
      ca-certificates \
      python-3.14 \
      tzdata

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="/app"

WORKDIR /app

COPY --from=builder --chown=nonroot:nonroot /app/.venv /app/.venv

USER nonroot

ENV PATH="/app/.venv/bin:$PATH"

COPY --chown=nonroot:nonroot app/ ./app/

EXPOSE 8000/tcp

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
