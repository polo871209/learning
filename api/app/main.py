from contextlib import asynccontextmanager
from typing import cast

from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware
from opentelemetry.instrumentation.fastapi import FastAPIInstrumentor
from opentelemetry.instrumentation.psycopg import PsycopgInstrumentor
from prometheus_client import CONTENT_TYPE_LATEST, generate_latest

from app.config import settings
from app.database import db
from app.logger import get_logger, setup_logging
from app.routers import posts, users
from app.telemetry import setup_telemetry

# Initialize logging before anything else
setup_logging()
logger = get_logger()


@asynccontextmanager
async def lifespan(app: FastAPI):
    setup_telemetry(service_name=settings.app_name)
    logger.info("OpenTelemetry instrumentation initialized")

    await db.connect()
    logger.info(f"Starting {settings.app_name}")

    yield

    await db.disconnect()
    logger.info("Shutting down gracefully")


app = FastAPI(
    title=settings.app_name,
    description="FastAPI + PostgreSQL with raw SQL",
    version="1.0.0",
    lifespan=lifespan,
)

app.add_middleware(
    cast(type, CORSMiddleware),
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(users.router, prefix=settings.api_prefix)
app.include_router(posts.router, prefix=settings.api_prefix)

FastAPIInstrumentor.instrument_app(app)
PsycopgInstrumentor().instrument()


@app.get("/")
async def root():
    return {
        "message": "Welcome to FastAPI + PostgreSQL API",
        "docs": "/docs",
        "redoc": "/redoc",
    }


@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "database": "connected" if db.pool else "disconnected",
    }


@app.get("/metrics")
async def metrics():
    return Response(content=generate_latest(), media_type=CONTENT_TYPE_LATEST)
