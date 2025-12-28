"""create_initial_tables

Revision ID: 41742ed48865
Revises:
Create Date: 2025-12-28 10:20:35.437216

"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = "41742ed48865"
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Create users table
    op.execute("""
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(100) NOT NULL,
            email VARCHAR(255) NOT NULL UNIQUE,
            is_active BOOLEAN NOT NULL DEFAULT TRUE,
            created_at TIMESTAMP NOT NULL DEFAULT NOW(),
            updated_at TIMESTAMP NOT NULL DEFAULT NOW()
        )
    """)

    # Create index on email for faster lookups
    op.execute("""
        CREATE INDEX IF NOT EXISTS idx_users_email ON users(email)
    """)

    # Create posts table
    op.execute("""
        CREATE TABLE IF NOT EXISTS posts (
            id SERIAL PRIMARY KEY,
            title VARCHAR(200) NOT NULL,
            content TEXT NOT NULL,
            published BOOLEAN NOT NULL DEFAULT FALSE,
            user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            created_at TIMESTAMP NOT NULL DEFAULT NOW(),
            updated_at TIMESTAMP NOT NULL DEFAULT NOW()
        )
    """)

    # Create indexes on posts
    op.execute("""
        CREATE INDEX IF NOT EXISTS idx_posts_user_id ON posts(user_id)
    """)
    op.execute("""
        CREATE INDEX IF NOT EXISTS idx_posts_published ON posts(published)
    """)

    # Optional: Create full-text search index for posts
    op.execute("""
        CREATE INDEX IF NOT EXISTS idx_posts_search 
        ON posts USING GIN (to_tsvector('english', title || ' ' || content))
    """)


def downgrade() -> None:
    """Downgrade schema."""
    op.execute("DROP TABLE IF EXISTS posts CASCADE")
    op.execute("DROP TABLE IF EXISTS users CASCADE")
