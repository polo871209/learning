from contextlib import asynccontextmanager
from typing import cast
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.config import settings
from app.database import db
from app.routers import users, posts


@asynccontextmanager
async def lifespan(app: FastAPI):
    """
    Lifespan context manager for startup and shutdown events.
    This handles database connection pool initialization and cleanup.
    """
    # Startup: Initialize database pool
    await db.connect()
    print(f"Starting {settings.app_name}")

    yield

    # Shutdown: Close database pool
    await db.disconnect()
    print("Shutting down gracefully")


# Create FastAPI app
app = FastAPI(
    title=settings.app_name,
    description="FastAPI + PostgreSQL with raw SQL",
    version="1.0.0",
    lifespan=lifespan,
)

# CORS middleware (configure for your needs)
app.add_middleware(
    cast(type, CORSMiddleware),  # Cast to satisfy type checker
    allow_origins=["*"],  # In production, specify actual origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(users.router, prefix=settings.api_prefix)
app.include_router(posts.router, prefix=settings.api_prefix)


@app.get("/")
async def root():
    """Root endpoint."""
    return {
        "message": "Welcome to FastAPI + PostgreSQL API",
        "docs": "/docs",
        "redoc": "/redoc",
    }


@app.get("/health")
async def health_check():
    """Health check endpoint."""
    return {
        "status": "healthy",
        "database": "connected" if db.pool else "disconnected",
    }


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,  # Disable in production
    )
