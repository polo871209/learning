from contextlib import asynccontextmanager
from typing import AsyncGenerator, Any, cast
import psycopg
from psycopg.rows import dict_row
from psycopg.sql import SQL, Composable
from psycopg_pool import AsyncConnectionPool

from app.config import settings


class Database:
    """Database connection pool manager."""

    def __init__(self):
        self.pool: AsyncConnectionPool | None = None

    async def connect(self):
        """Initialize the connection pool."""
        self.pool = AsyncConnectionPool(
            conninfo=settings.database_url,
            min_size=settings.db_pool_size,
            max_size=settings.db_pool_size + settings.db_max_overflow,
            timeout=settings.db_pool_timeout,
            open=False,
        )
        await self.pool.open()
        print("Database pool created successfully")

    async def disconnect(self):
        """Close the connection pool."""
        if self.pool:
            await self.pool.close()
            print("Database pool closed")

    @asynccontextmanager
    async def get_connection(self) -> AsyncGenerator[psycopg.AsyncConnection, None]:
        """
        Get a database connection from the pool.

        Usage:
            async with db.get_connection() as conn:
                async with conn.cursor() as cur:
                    await cur.execute("SELECT * FROM users")
                    results = await cur.fetchall()
        """
        if not self.pool:
            raise RuntimeError("Database pool not initialized")

        async with self.pool.connection() as conn:
            yield conn

    async def execute(
        self,
        query: str,
        params: tuple | dict | None = None,
        fetch: str = "none",
    ) -> list[dict[str, Any]] | dict[str, Any] | None:
        """
        Execute a SQL query with automatic connection management.

        Args:
            query: SQL query to execute
            params: Query parameters (tuple for positional, dict for named)
            fetch: How to fetch results - "none", "one", "all"

        Returns:
            Query results based on fetch parameter

        Example:
            # Insert
            await db.execute(
                "INSERT INTO users (name, email) VALUES (%s, %s)",
                ("John", "john@example.com")
            )

            # Select one
            user = await db.execute(
                "SELECT * FROM users WHERE id = %s",
                (user_id,),
                fetch="one"
            )

            # Select all
            users = await db.execute(
                "SELECT * FROM users WHERE active = %s",
                (True,),
                fetch="all"
            )
        """
        async with self.get_connection() as conn:
            async with conn.cursor(row_factory=dict_row) as cur:
                # Cast query to Any to bypass psycopg3 LiteralString type checking
                # This is safe because we're using parameterized queries
                await cur.execute(cast(Any, query), params)

                if fetch == "one":
                    return await cur.fetchone()
                elif fetch == "all":
                    return await cur.fetchall()
                elif fetch == "none":
                    return None
                else:
                    raise ValueError(f"Invalid fetch parameter: {fetch}")

    async def execute_many(
        self,
        query: str,
        params_list: list[tuple] | list[dict],
    ) -> None:
        """
        Execute a query multiple times with different parameters.
        Useful for bulk inserts.

        Example:
            await db.execute_many(
                "INSERT INTO users (name, email) VALUES (%s, %s)",
                [("John", "john@example.com"), ("Jane", "jane@example.com")]
            )
        """
        async with self.get_connection() as conn:
            async with conn.cursor() as cur:
                # Cast query to Any to bypass psycopg3 LiteralString type checking
                await cur.executemany(cast(Any, query), params_list)

    async def transaction(self):
        """
        Start a database transaction context.

        Usage:
            async with db.get_connection() as conn:
                async with conn.transaction():
                    async with conn.cursor() as cur:
                        await cur.execute("UPDATE accounts SET balance = balance - 100 WHERE id = 1")
                        await cur.execute("UPDATE accounts SET balance = balance + 100 WHERE id = 2")
                    # Transaction commits automatically if no exception
                    # Transaction rolls back if exception occurs
        """
        # This is just a reference method - use conn.transaction() directly
        raise NotImplementedError(
            "Use conn.transaction() directly within a connection context"
        )


# Global database instance
db = Database()


async def get_db() -> Database:
    """
    FastAPI dependency for database access.

    Usage in routes:
        @router.get("/users")
        async def get_users(database: Database = Depends(get_db)):
            users = await database.execute("SELECT * FROM users", fetch="all")
            return users
    """
    return db
