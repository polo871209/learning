from datetime import datetime
from typing import Optional
from sqlmodel import Field, SQLModel


# Base models for database tables
class UserBase(SQLModel):
    """Base user model with shared fields."""

    name: str = Field(max_length=100)
    email: str = Field(max_length=255, unique=True, index=True)
    is_active: bool = Field(default=True)


class User(UserBase):
    """Full user model as stored in database."""

    id: int = Field(primary_key=True)
    created_at: datetime
    updated_at: datetime


# API Request/Response models
class UserCreate(UserBase):
    """Model for creating a new user."""

    pass


class UserUpdate(SQLModel):
    """Model for updating a user (all fields optional)."""

    name: Optional[str] = Field(default=None, max_length=100)
    email: Optional[str] = Field(default=None, max_length=255)
    is_active: Optional[bool] = None


class UserResponse(UserBase):
    """Model for user API responses."""

    id: int
    created_at: datetime
    updated_at: datetime


class UserListResponse(SQLModel):
    """Model for paginated user list responses."""

    data: list[UserResponse]
    total: int
    page: int
    page_size: int


# Example: More complex model with relationships (for reference)
class PostBase(SQLModel):
    """Base post model."""

    title: str = Field(max_length=200)
    content: str
    published: bool = Field(default=False)
    user_id: int = Field(foreign_key="users.id")


class Post(PostBase):
    """Full post model as stored in database."""

    id: int = Field(primary_key=True)
    created_at: datetime
    updated_at: datetime


class PostCreate(PostBase):
    """Model for creating a new post."""

    pass


class PostUpdate(SQLModel):
    """Model for updating a post (all fields optional)."""

    title: Optional[str] = Field(default=None, max_length=200)
    content: Optional[str] = None
    published: Optional[bool] = None


class PostResponse(PostBase):
    """Model for post API responses."""

    id: int
    created_at: datetime
    updated_at: datetime


class PostWithUser(PostResponse):
    """Post response with user information (for complex queries)."""

    user_name: str
    user_email: str
