from contextlib import asynccontextmanager
from typing import AsyncGenerator, Any, cast
import psycopg
from psycopg.rows import dict_row
from psycopg.sql import SQL, Composable
from psycopg_pool import AsyncConnectionPool

from app.config import settings


class Database:
    def __init__(self):
        self.pool: AsyncConnectionPool | None = None

    async def connect(self):
        self.pool = AsyncConnectionPool(
            conninfo=settings.database_url,
            min_size=settings.db_pool_min_size,
            max_size=settings.db_pool_max_size,
            timeout=settings.db_pool_timeout,
            open=False,
        )
        await self.pool.open()
        print("Database pool created successfully")

    async def disconnect(self):
        if self.pool:
            await self.pool.close()
            print("Database pool closed")

    @asynccontextmanager
    async def get_connection(self) -> AsyncGenerator[psycopg.AsyncConnection, None]:
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
        async with self.get_connection() as conn:
            async with conn.cursor(row_factory=dict_row) as cur:
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
        async with self.get_connection() as conn:
            async with conn.cursor() as cur:
                await cur.executemany(cast(Any, query), params_list)


db = Database()


async def get_db() -> Database:
    return db
