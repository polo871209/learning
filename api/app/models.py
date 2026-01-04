from datetime import datetime
from sqlmodel import Field, SQLModel


class UserBase(SQLModel):
    name: str = Field(max_length=100)
    email: str = Field(max_length=255, unique=True, index=True)
    is_active: bool = Field(default=True)


class User(UserBase):
    id: int = Field(primary_key=True)
    created_at: datetime
    updated_at: datetime


class UserCreate(UserBase):
    pass


class UserUpdate(SQLModel):
    name: str | None = Field(default=None, max_length=100)
    email: str | None = Field(default=None, max_length=255)
    is_active: bool | None = None


class UserResponse(UserBase):
    id: int
    created_at: datetime
    updated_at: datetime


class UserListResponse(SQLModel):
    data: list[UserResponse]
    total: int
    page: int
    page_size: int


class PostBase(SQLModel):
    title: str = Field(max_length=200)
    content: str
    published: bool = Field(default=False)
    user_id: int = Field(foreign_key="users.id")


class Post(PostBase):
    id: int = Field(primary_key=True)
    created_at: datetime
    updated_at: datetime


class PostCreate(PostBase):
    pass


class PostUpdate(SQLModel):
    title: str | None = Field(default=None, max_length=200)
    content: str | None = None
    published: bool | None = None


class PostResponse(PostBase):
    id: int
    created_at: datetime
    updated_at: datetime


class PostWithUser(PostResponse):
    user_name: str
    user_email: str
