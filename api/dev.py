#!/usr/bin/env python3

if __name__ == "__main__":
    import uvicorn
    from app.logger import LogConfig

    uvicorn.run(
        "app.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True,
        reload_dirs=["app"],
        log_config=LogConfig.get_config(),
    )
