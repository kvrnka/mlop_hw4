
CREATE DATABASE IF NOT EXISTS transactions_db;

CREATE TABLE IF NOT EXISTS transactions_db.transactions
(
    transaction_time DateTime64(3),

    merch String CODEC(ZSTD(1)),
    cat_id LowCardinality(String),
    amount Nullable(Decimal(18, 2)),

    name_1 String,
    name_2 String,
    gender LowCardinality(String),

    street String,
    one_city String,
    us_state LowCardinality(String),
    post_code String,

    lat Nullable(Float64),
    lon Nullable(Float64),
    population_city Nullable(UInt64),

    jobs String,

    merchant_lat Nullable(Float64),
    merchant_lon Nullable(Float64),

    target UInt8
)
ENGINE = MergeTree()
ORDER BY (us_state, cat_id);
