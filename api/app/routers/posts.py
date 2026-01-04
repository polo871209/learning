from typing import Any, cast

from fastapi import APIRouter, Depends, HTTPException, Query

from app.database import Database, get_db
from app.models import PostCreate, PostResponse, PostUpdate, PostWithUser
from app.queries import posts as post_queries

router = APIRouter(prefix="/posts", tags=["posts"])


@router.post("/", response_model=PostResponse, status_code=201)
async def create_post(
    post_data: PostCreate,
    db: Database = Depends(get_db),
):
    try:
        result = await db.execute(
            post_queries.CREATE_POST,
            (
                post_data.title,
                post_data.content,
                post_data.published,
                post_data.user_id,
            ),
            fetch="one",
        )

        if not result:
            raise HTTPException(status_code=500, detail="Failed to create post")

        return PostResponse(**cast(dict[str, Any], result))

    except Exception as e:
        if "foreign key" in str(e).lower():
            raise HTTPException(status_code=400, detail="Invalid user_id")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/{post_id}", response_model=PostResponse)
async def get_post(
    post_id: int,
    db: Database = Depends(get_db),
):
    result = await db.execute(
        post_queries.GET_POST_BY_ID,
        (post_id,),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=404, detail="Post not found")

    return PostResponse(**cast(dict[str, Any], result))


@router.get("/", response_model=list[PostWithUser])
async def list_posts(
    published: bool = Query(True),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    db: Database = Depends(get_db),
):
    offset = (page - 1) * page_size

    results = await db.execute(
        post_queries.GET_POSTS_WITH_USER,
        (published, page_size, offset),
        fetch="all",
    )

    return [PostWithUser(**cast(dict[str, Any], post)) for post in (results or [])]


@router.get("/user/{user_id}", response_model=list[PostResponse])
async def get_user_posts(
    user_id: int,
    db: Database = Depends(get_db),
):
    results = await db.execute(
        post_queries.GET_POSTS_BY_USER,
        (user_id,),
        fetch="all",
    )

    return [PostResponse(**cast(dict[str, Any], post)) for post in (results or [])]


@router.patch("/{post_id}", response_model=PostResponse)
async def update_post(
    post_id: int,
    post_data: PostUpdate,
    db: Database = Depends(get_db),
):
    result = await db.execute(
        post_queries.UPDATE_POST,
        (post_data.title, post_data.content, post_data.published, post_id),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=404, detail="Post not found")

    return PostResponse(**cast(dict[str, Any], result))


@router.delete("/{post_id}", status_code=204)
async def delete_post(
    post_id: int,
    db: Database = Depends(get_db),
):
    result = await db.execute(
        post_queries.DELETE_POST,
        (post_id,),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=404, detail="Post not found")

    return None


@router.post("/{post_id}/publish", response_model=PostResponse)
async def publish_post(
    post_id: int,
    db: Database = Depends(get_db),
):
    async with db.get_connection() as conn:
        async with conn.transaction():
            async with conn.cursor() as cur:
                await cur.execute(
                    post_queries.UPDATE_POST,
                    (None, None, True, post_id),
                )
                result = await cur.fetchone()

                if not result:
                    raise HTTPException(status_code=404, detail="Post not found")

                return PostResponse(**dict(result))
