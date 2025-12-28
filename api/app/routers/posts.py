from typing import cast, Any
from fastapi import APIRouter, Depends, HTTPException, Query

from app.database import Database, get_db
from app.models import PostCreate, PostUpdate, PostResponse, PostWithUser
from app.queries import posts as post_queries


router = APIRouter(prefix="/posts", tags=["posts"])


@router.post("/", response_model=PostResponse, status_code=201)
async def create_post(
    post_data: PostCreate,
    db: Database = Depends(get_db),
):
    """Create a new post."""
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
        # Handle foreign key constraint (invalid user_id)
        if "foreign key" in str(e).lower():
            raise HTTPException(status_code=400, detail="Invalid user_id")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/{post_id}", response_model=PostResponse)
async def get_post(
    post_id: int,
    db: Database = Depends(get_db),
):
    """Get a post by ID."""
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
    """
    List posts with user information (JOIN example).
    This demonstrates how to handle complex queries with joins.
    """
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
    """Get all posts by a specific user."""
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
    """Update a post (partial update)."""
    # Check if post exists
    existing = await db.execute(
        post_queries.GET_POST_BY_ID,
        (post_id,),
        fetch="one",
    )

    if not existing:
        raise HTTPException(status_code=404, detail="Post not found")

    result = await db.execute(
        post_queries.UPDATE_POST,
        (post_data.title, post_data.content, post_data.published, post_id),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=500, detail="Failed to update post")

    return PostResponse(**cast(dict[str, Any], result))


@router.delete("/{post_id}", status_code=204)
async def delete_post(
    post_id: int,
    db: Database = Depends(get_db),
):
    """Delete a post."""
    result = await db.execute(
        post_queries.DELETE_POST,
        (post_id,),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=404, detail="Post not found")

    return None


# Example: Complex transaction with multiple operations
@router.post("/{post_id}/publish", response_model=PostResponse)
async def publish_post(
    post_id: int,
    db: Database = Depends(get_db),
):
    """
    Publish a post with transaction example.
    In a real app, this might update multiple tables (post, notifications, etc.)
    """
    async with db.get_connection() as conn:
        async with conn.transaction():
            # Update post
            async with conn.cursor() as cur:
                await cur.execute(
                    post_queries.UPDATE_POST,
                    (None, None, True, post_id),
                )
                result = await cur.fetchone()

                if not result:
                    raise HTTPException(status_code=404, detail="Post not found")

                # Here you could do additional operations like:
                # - Create notifications
                # - Update user statistics
                # - Log the activity
                # All within the same transaction

                return PostResponse(**dict(result))
