CREATE_POST = """
    INSERT INTO posts (title, content, published, user_id, created_at, updated_at)
    VALUES (%s, %s, %s, %s, NOW(), NOW())
    RETURNING id, title, content, published, user_id, created_at, updated_at
"""

GET_POST_BY_ID = """
    SELECT id, title, content, published, user_id, created_at, updated_at
    FROM posts
    WHERE id = %s
"""

GET_ALL_POSTS = """
    SELECT id, title, content, published, user_id, created_at, updated_at
    FROM posts
    WHERE published = %s
    ORDER BY created_at DESC
    LIMIT %s OFFSET %s
"""

GET_POSTS_BY_USER = """
    SELECT id, title, content, published, user_id, created_at, updated_at
    FROM posts
    WHERE user_id = %s
    ORDER BY created_at DESC
"""

GET_POSTS_WITH_USER = """
    SELECT 
        p.id,
        p.title,
        p.content,
        p.published,
        p.user_id,
        p.created_at,
        p.updated_at,
        u.name as user_name,
        u.email as user_email
    FROM posts p
    INNER JOIN users u ON p.user_id = u.id
    WHERE p.published = %s
    ORDER BY p.created_at DESC
    LIMIT %s OFFSET %s
"""

SEARCH_POSTS = """
    SELECT 
        id, 
        title, 
        content, 
        published, 
        user_id, 
        created_at, 
        updated_at,
        ts_rank(
            to_tsvector('english', title || ' ' || content),
            plainto_tsquery('english', %s)
        ) as rank
    FROM posts
    WHERE 
        to_tsvector('english', title || ' ' || content) @@ plainto_tsquery('english', %s)
        AND published = true
    ORDER BY rank DESC, created_at DESC
    LIMIT %s OFFSET %s
"""

GET_POPULAR_POSTS = """
    WITH post_stats AS (
        SELECT 
            p.id,
            p.title,
            p.content,
            p.published,
            p.user_id,
            p.created_at,
            p.updated_at,
            u.name as user_name,
            COUNT(c.id) as comment_count
        FROM posts p
        INNER JOIN users u ON p.user_id = u.id
        LEFT JOIN comments c ON p.id = c.post_id
        WHERE p.published = true
        GROUP BY p.id, p.title, p.content, p.published, p.user_id, p.created_at, p.updated_at, u.name
    )
    SELECT * FROM post_stats
    WHERE comment_count > %s
    ORDER BY comment_count DESC, created_at DESC
    LIMIT %s
"""

UPDATE_POST = """
    UPDATE posts
    SET 
        title = COALESCE(%s, title),
        content = COALESCE(%s, content),
        published = COALESCE(%s, published),
        updated_at = NOW()
    WHERE id = %s
    RETURNING id, title, content, published, user_id, created_at, updated_at
"""

DELETE_POST = """
    DELETE FROM posts
    WHERE id = %s
    RETURNING id
"""
