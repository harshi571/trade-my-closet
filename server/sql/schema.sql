CREATE TABLE IF NOT EXISTS users (
 id BIGSERIAL PRIMARY KEY, name VARCHAR(100) NOT NULL, email VARCHAR(255) UNIQUE NOT NULL,
 password_hash TEXT NOT NULL, points INTEGER NOT NULL DEFAULT 0 CHECK(points>=0),
 language VARCHAR(10) NOT NULL DEFAULT 'en', created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS items (
 id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id), title VARCHAR(120) NOT NULL,
 category VARCHAR(40) NOT NULL, item_condition VARCHAR(30) NOT NULL, description TEXT NOT NULL,
 points INTEGER NOT NULL CHECK(points BETWEEN 1 AND 100000), image_url TEXT,
 status VARCHAR(20) NOT NULL DEFAULT 'available' CHECK(status IN ('available','reserved','exchanged')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS wishlist (
 user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
 item_id BIGINT NOT NULL REFERENCES items(id) ON DELETE CASCADE, PRIMARY KEY(user_id,item_id)
);
CREATE TABLE IF NOT EXISTS swaps (
 id BIGSERIAL PRIMARY KEY, requester_id BIGINT NOT NULL REFERENCES users(id),
 owner_id BIGINT NOT NULL REFERENCES users(id), wanted_item_id BIGINT NOT NULL REFERENCES items(id),
 offered_item_id BIGINT REFERENCES items(id), method VARCHAR(10) NOT NULL CHECK(method IN ('swap','points')),
 status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK(status IN ('pending','accepted','rejected','completed','cancelled')),
 created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(), CHECK(requester_id<>owner_id)
);
CREATE TABLE IF NOT EXISTS point_transactions (
 id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id), amount INTEGER NOT NULL,
 swap_id BIGINT REFERENCES swaps(id), note TEXT NOT NULL, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE TABLE IF NOT EXISTS notifications (
 id BIGSERIAL PRIMARY KEY, user_id BIGINT NOT NULL REFERENCES users(id), message TEXT NOT NULL,
 read_at TIMESTAMPTZ, created_at TIMESTAMPTZ DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_items_category_status ON items(category,status);
CREATE INDEX IF NOT EXISTS idx_swaps_owner ON swaps(owner_id,status);
