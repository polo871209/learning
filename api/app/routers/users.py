from typing import cast, Any
from fastapi import APIRouter, Depends, HTTPException, Query

from app.database import Database, get_db
from app.models import UserCreate, UserUpdate, UserResponse, UserListResponse
from app.queries import users as user_queries


router = APIRouter(prefix="/users", tags=["users"])


@router.post("/", response_model=UserResponse, status_code=201)
async def create_user(
    user_data: UserCreate,
    db: Database = Depends(get_db),
):
    """Create a new user."""
    try:
        result = await db.execute(
            user_queries.CREATE_USER,
            (user_data.name, user_data.email, user_data.is_active),
            fetch="one",
        )

        if not result:
            raise HTTPException(status_code=500, detail="Failed to create user")

        return UserResponse(**cast(dict[str, Any], result))

    except Exception as e:
        # Handle unique constraint violation (duplicate email)
        if "unique constraint" in str(e).lower():
            raise HTTPException(status_code=400, detail="Email already exists")
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/{user_id}", response_model=UserResponse)
async def get_user(
    user_id: int,
    db: Database = Depends(get_db),
):
    """Get a user by ID."""
    result = await db.execute(
        user_queries.GET_USER_BY_ID,
        (user_id,),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=404, detail="User not found")

    return UserResponse(**cast(dict[str, Any], result))


@router.get("/", response_model=UserListResponse)
async def list_users(
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    is_active: bool = Query(True),
    db: Database = Depends(get_db),
):
    """List users with pagination."""
    offset = (page - 1) * page_size

    # Get users with total count in single query using window function
    users_result = await db.execute(
        user_queries.GET_ALL_USERS,
        (is_active, page_size, offset),
        fetch="all",
    )

    # Extract total from first row, or default to 0 if no results
    total = 0
    if users_result:
        first_row = cast(list[dict[str, Any]], users_result)[0]
        total = cast(int, first_row["total_count"])

    return UserListResponse(
        data=[
            UserResponse(**cast(dict[str, Any], user)) for user in (users_result or [])
        ],
        total=total,
        page=page,
        page_size=page_size,
    )


@router.patch("/{user_id}", response_model=UserResponse)
async def update_user(
    user_id: int,
    user_data: UserUpdate,
    db: Database = Depends(get_db),
):
    """Update a user (partial update)."""
    try:
        result = await db.execute(
            user_queries.UPDATE_USER,
            (user_data.name, user_data.email, user_data.is_active, user_id),
            fetch="one",
        )

        if not result:
            raise HTTPException(status_code=404, detail="User not found")

        return UserResponse(**cast(dict[str, Any], result))

    except Exception as e:
        if "unique constraint" in str(e).lower():
            raise HTTPException(status_code=400, detail="Email already exists")
        raise HTTPException(status_code=500, detail=str(e))


@router.delete("/{user_id}", status_code=204)
async def delete_user(
    user_id: int,
    soft: bool = Query(True, description="Soft delete (deactivate) vs hard delete"),
    db: Database = Depends(get_db),
):
    """Delete a user (soft or hard delete)."""
    query = user_queries.SOFT_DELETE_USER if soft else user_queries.DELETE_USER

    result = await db.execute(
        query,
        (user_id,),
        fetch="one",
    )

    if not result:
        raise HTTPException(status_code=404, detail="User not found")

    return None


@router.get("/search/", response_model=list[UserResponse])
async def search_users(
    q: str = Query(..., min_length=1),
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    is_active: bool = Query(True),
    db: Database = Depends(get_db),
):
    """Search users by name or email (case-insensitive)."""
    offset = (page - 1) * page_size
    search_term = f"%{q}%"

    results = await db.execute(
        user_queries.SEARCH_USERS,
        (search_term, search_term, is_active, page_size, offset),
        fetch="all",
    )

    return [UserResponse(**cast(dict[str, Any], user)) for user in (results or [])]


# Example: Complex query endpoint
@router.get("/with-stats/", response_model=list[dict])
async def get_users_with_stats(
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=100),
    is_active: bool = Query(True),
    db: Database = Depends(get_db),
):
    """
    Get users with their post count (example of complex query).
    Returns raw dict to show flexibility with complex queries.
    """
    offset = (page - 1) * page_size

    results = await db.execute(
        user_queries.GET_USERS_WITH_POST_COUNT,
        (is_active, page_size, offset),
        fetch="all",
    )

    return results or []


# Example: Transaction usage
@router.post("/batch/", status_code=201)
async def create_users_batch(
    users: list[UserCreate],
    db: Database = Depends(get_db),
):
    """
    Create multiple users in a transaction using efficient batch insert.
    Uses executemany for better performance.
    """
    if not users:
        raise HTTPException(status_code=400, detail="No users provided")

    try:
        # Use executemany for efficient batch insert
        await db.execute_many(
            user_queries.BATCH_CREATE_USERS,
            [(user.name, user.email, user.is_active) for user in users],
        )

        return {
            "created": len(users),
            "message": f"Successfully created {len(users)} users",
        }
    except Exception as e:
        # Handle unique constraint violation (duplicate email)
        if "unique constraint" in str(e).lower():
            raise HTTPException(
                status_code=400, detail="One or more emails already exist"
            )
        raise HTTPException(status_code=500, detail=str(e))
