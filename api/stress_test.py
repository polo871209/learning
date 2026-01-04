#!/usr/bin/env python3

import asyncio
import random
import time
from collections import defaultdict
from typing import Any, TypedDict

import aiohttp


class StatsDict(TypedDict):
    total_requests: int
    successful_requests: int
    failed_requests: int
    posts_created: int
    errors: defaultdict[str, int]


BASE_URL = "http://api.app.svc.cluster.local:8000"
API_PREFIX = "/api/v1"
CONCURRENT_PROCESSES = 10
DURATION_SECONDS = 600
TARGET_POSTS_PER_SECOND = 6
POST_INTERVAL = 1.0 / TARGET_POSTS_PER_SECOND


class StressTest:
    def __init__(self, base_url: str, api_prefix: str):
        self.base_url = base_url
        self.api_prefix = api_prefix
        self.stats: StatsDict = {
            "total_requests": 0,
            "successful_requests": 0,
            "failed_requests": 0,
            "posts_created": 0,
            "errors": defaultdict(int),
        }
        self.user_ids: list[int] = []
        self.post_ids: list[int] = []
        self.lock = asyncio.Lock()

    async def create_user(
        self, session: aiohttp.ClientSession
    ) -> dict[str, Any] | None:
        try:
            async with session.post(
                f"{self.base_url}{self.api_prefix}/users/",
                json={
                    "name": f"User_{random.randint(1000, 9999)}",
                    "email": f"user_{random.randint(10000, 99999)}@example.com",
                    "is_active": True,
                },
                timeout=aiohttp.ClientTimeout(total=10),
            ) as response:
                if response.status == 201:
                    user_data = await response.json()
                    async with self.lock:
                        self.user_ids.append(user_data["id"])
                    return user_data
                return None
        except Exception as e:
            await self._record_error(str(e))
            return None

    async def create_post(
        self, session: aiohttp.ClientSession
    ) -> dict[str, Any] | None:
        if not self.user_ids:
            return None

        try:
            async with session.post(
                f"{self.base_url}{self.api_prefix}/posts/",
                json={
                    "title": f"Post Title {random.randint(1000, 9999)}",
                    "content": f"This is post content number {random.randint(1, 1000)}",
                    "published": random.choice([True, False]),
                    "user_id": random.choice(self.user_ids),
                },
                timeout=aiohttp.ClientTimeout(total=10),
            ) as response:
                if response.status == 201:
                    post_data = await response.json()
                    async with self.lock:
                        self.post_ids.append(post_data["id"])
                        self.stats["posts_created"] += 1
                    return post_data
                return None
        except Exception as e:
            await self._record_error(str(e))
            return None

    async def get_users(self, session: aiohttp.ClientSession) -> dict[str, Any] | None:
        try:
            page = random.randint(1, 5)
            async with session.get(
                f"{self.base_url}{self.api_prefix}/users/",
                params={"page": page, "page_size": 10},
                timeout=aiohttp.ClientTimeout(total=10),
            ) as response:
                if response.status == 200:
                    return await response.json()
                return None
        except Exception as e:
            await self._record_error(str(e))
            return None

    async def get_posts(self, session: aiohttp.ClientSession) -> dict[str, Any] | None:
        try:
            page = random.randint(1, 5)
            async with session.get(
                f"{self.base_url}{self.api_prefix}/posts/",
                params={"page": page, "page_size": 10},
                timeout=aiohttp.ClientTimeout(total=10),
            ) as response:
                if response.status == 200:
                    return await response.json()
                return None
        except Exception as e:
            await self._record_error(str(e))
            return None

    async def get_user_by_id(
        self, session: aiohttp.ClientSession
    ) -> dict[str, Any] | None:
        if not self.user_ids:
            return None

        try:
            user_id = random.choice(self.user_ids)
            async with session.get(
                f"{self.base_url}{self.api_prefix}/users/{user_id}",
                timeout=aiohttp.ClientTimeout(total=10),
            ) as response:
                if response.status == 200:
                    return await response.json()
                return None
        except Exception as e:
            await self._record_error(str(e))
            return None

    async def get_post_by_id(
        self, session: aiohttp.ClientSession
    ) -> dict[str, Any] | None:
        if not self.post_ids:
            return None

        try:
            post_id = random.choice(self.post_ids)
            async with session.get(
                f"{self.base_url}{self.api_prefix}/posts/{post_id}",
                timeout=aiohttp.ClientTimeout(total=10),
            ) as response:
                if response.status == 200:
                    return await response.json()
                return None
        except Exception as e:
            await self._record_error(str(e))
            return None

    async def _record_error(self, error: str):
        async with self.lock:
            self.stats["errors"][error] += 1

    async def post_creator_process(self, process_id: int, duration: int):
        async with aiohttp.ClientSession() as session:
            end_time = time.time() + duration
            post_count = 0

            interval = POST_INTERVAL * CONCURRENT_PROCESSES

            while time.time() < end_time:
                start = time.time()

                result = await self.create_post(session)

                async with self.lock:
                    self.stats["total_requests"] += 1
                    if result is not None:
                        self.stats["successful_requests"] += 1
                        post_count += 1
                    else:
                        self.stats["failed_requests"] += 1

                elapsed = time.time() - start
                sleep_time = max(0, interval - elapsed)
                await asyncio.sleep(sleep_time)

            print(f"Process {process_id} created {post_count} posts")

    async def background_traffic_generator(self, process_id: int, duration: int):
        async with aiohttp.ClientSession() as session:
            end_time = time.time() + duration
            request_count = 0

            while time.time() < end_time:
                actions = [
                    (self.get_posts, 0.35),
                    (self.get_users, 0.25),
                    (self.get_post_by_id, 0.20),
                    (self.get_user_by_id, 0.15),
                    (self.create_user, 0.05),
                ]

                rand = random.random()
                cumulative = 0
                selected_action = actions[0][0]

                for action, weight in actions:
                    cumulative += weight
                    if rand <= cumulative:
                        selected_action = action
                        break

                try:
                    result = await selected_action(session)
                    async with self.lock:
                        self.stats["total_requests"] += 1
                        request_count += 1

                        if result is not None:
                            self.stats["successful_requests"] += 1
                        else:
                            self.stats["failed_requests"] += 1

                except Exception as e:
                    async with self.lock:
                        self.stats["failed_requests"] += 1
                    await self._record_error(str(e))

                await asyncio.sleep(random.uniform(0.05, 0.2))

            print(f"Background process {process_id} completed {request_count} requests")

    async def run(self, concurrent_processes: int, duration: int):
        print(f"Starting stress test with {concurrent_processes} concurrent processes")
        print(f"Duration: {duration} seconds")
        print(f"Target: {TARGET_POSTS_PER_SECOND} posts/second")
        print(f"Base URL: {BASE_URL}")
        print("-" * 50)

        print("Seeding initial data...")
        async with aiohttp.ClientSession() as session:
            for _ in range(10):
                await self.create_user(session)

            for _ in range(20):
                await self.create_post(session)

        async with self.lock:
            self.stats: StatsDict = {
                "total_requests": 0,
                "successful_requests": 0,
                "failed_requests": 0,
                "posts_created": 0,
                "errors": defaultdict(int),
            }

        print(f"Seeded {len(self.user_ids)} users and {len(self.post_ids)} posts")
        print("-" * 50)

        start_time = time.time()

        tasks = []

        for i in range(concurrent_processes):
            tasks.append(self.post_creator_process(i, duration))

        for i in range(concurrent_processes):
            tasks.append(self.background_traffic_generator(i, duration))

        await asyncio.gather(*tasks)

        elapsed_time = time.time() - start_time

        print("\n" + "=" * 50)
        print("STRESS TEST RESULTS")
        print("=" * 50)
        print(f"Duration: {elapsed_time:.2f} seconds")
        print(f"Total requests: {self.stats['total_requests']}")
        print(f"Successful requests: {self.stats['successful_requests']}")
        print(f"Failed requests: {self.stats['failed_requests']}")
        print(f"Posts created: {self.stats['posts_created']}")
        print(
            f"Success rate: {(self.stats['successful_requests'] / max(self.stats['total_requests'], 1)) * 100:.2f}%"
        )
        print(f"Total QPS: {self.stats['total_requests'] / elapsed_time:.2f}")
        print(
            f"Post creation rate: {self.stats['posts_created'] / elapsed_time:.2f} posts/second"
        )

        if self.stats["errors"]:
            print("\nErrors encountered:")
            for error, count in self.stats["errors"].items():
                print(f"  - {error}: {count} times")


async def main():
    test = StressTest(BASE_URL, API_PREFIX)
    try:
        await test.run(CONCURRENT_PROCESSES, DURATION_SECONDS)
    except KeyboardInterrupt:
        print("\nTest interrupted by user")
    except Exception as e:
        print(f"\nTest failed with error: {e}")


if __name__ == "__main__":
    asyncio.run(main())
