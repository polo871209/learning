#!/usr/bin/env python3
"""
Development server startup script.

Usage:
    python dev.py
    or
    uv run python dev.py
"""

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        reload_dirs=["app"],
        log_level="info",
    )
