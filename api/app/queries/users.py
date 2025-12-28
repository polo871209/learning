"""
SQL queries for user operations.

Best practices:
1. Keep SQL queries in separate files for maintainability
2. Use named parameters for complex queries
3. Document what each query does
4. Include example complex queries (joins, aggregations, etc.)
"""

# CREATE
CREATE_USER = """
    INSERT INTO users (name, email, is_active, created_at, updated_at)
    VALUES (%s, %s, %s, NOW(), NOW())
    RETURNING id, name, email, is_active, created_at, updated_at
"""

# READ
GET_USER_BY_ID = """
    SELECT id, name, email, is_active, created_at, updated_at
    FROM users
    WHERE id = %s
"""

GET_USER_BY_EMAIL = """
    SELECT id, name, email, is_active, created_at, updated_at
    FROM users
    WHERE email = %s
"""

GET_ALL_USERS = """
    SELECT id, name, email, is_active, created_at, updated_at
    FROM users
    WHERE is_active = %s
    ORDER BY created_at DESC
    LIMIT %s OFFSET %s
"""

GET_USERS_COUNT = """
    SELECT COUNT(*) as total
    FROM users
    WHERE is_active = %s
"""

# UPDATE
UPDATE_USER = """
    UPDATE users
    SET 
        name = COALESCE(%s, name),
        email = COALESCE(%s, email),
        is_active = COALESCE(%s, is_active),
        updated_at = NOW()
    WHERE id = %s
    RETURNING id, name, email, is_active, created_at, updated_at
"""

# DELETE (soft delete recommended)
DELETE_USER = """
    DELETE FROM users
    WHERE id = %s
    RETURNING id
"""

SOFT_DELETE_USER = """
    UPDATE users
    SET is_active = false, updated_at = NOW()
    WHERE id = %s
    RETURNING id
"""

# COMPLEX QUERIES EXAMPLES

# Search users with ILIKE (case-insensitive)
SEARCH_USERS = """
    SELECT id, name, email, is_active, created_at, updated_at
    FROM users
    WHERE 
        (name ILIKE %s OR email ILIKE %s)
        AND is_active = %s
    ORDER BY created_at DESC
    LIMIT %s OFFSET %s
"""

# Get users with their post count (JOIN + aggregation)
GET_USERS_WITH_POST_COUNT = """
    SELECT 
        u.id,
        u.name,
        u.email,
        u.is_active,
        u.created_at,
        u.updated_at,
        COUNT(p.id) as post_count
    FROM users u
    LEFT JOIN posts p ON u.id = p.user_id
    WHERE u.is_active = %s
    GROUP BY u.id, u.name, u.email, u.is_active, u.created_at, u.updated_at
    ORDER BY post_count DESC
    LIMIT %s OFFSET %s
"""

# Batch insert users (use with executemany)
BATCH_CREATE_USERS = """
    INSERT INTO users (name, email, is_active, created_at, updated_at)
    VALUES (%s, %s, %s, NOW(), NOW())
"""
