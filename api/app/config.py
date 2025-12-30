from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings loaded from environment variables."""

    # Database
    database_url: str = "postgresql://postgres:postgres@localhost:5432/mydb"
    db_pool_min_size: int = 2
    db_pool_max_size: int = 20
    db_pool_timeout: int = 30

    # Application
    app_name: str = "FastAPI PostgreSQL API"
    debug: bool = False

    # API
    api_prefix: str = "/api/v1"

    model_config = SettingsConfigDict(
        env_file=".env",
        env_file_encoding="utf-8",
        case_sensitive=False,
        extra="ignore",  # Ignore extra fields for backward compatibility
    )

    @property
    def sqlalchemy_database_url(self) -> str:
        """
        Convert psycopg3 URL to SQLAlchemy URL for Alembic.
        psycopg3 uses: postgresql://...
        SQLAlchemy with psycopg uses: postgresql+psycopg://...
        """
        if self.database_url.startswith("postgresql://"):
            return self.database_url.replace(
                "postgresql://", "postgresql+psycopg://", 1
            )
        return self.database_url


# Global settings instance
settings = Settings()
