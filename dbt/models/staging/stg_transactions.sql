SELECT
    transaction_time,

    toDate(transaction_time) AS transaction_date,
    toHour(transaction_time) AS transaction_hour,
    {{ dbt_date.day_of_week('transaction_time') }} AS day_of_week,

    merch,
    cat_id,
    amount,

    name_1,
    name_2,
    gender,

    street,
    one_city,
    us_state,
    post_code,

    lat,
    lon,
    population_city,
    jobs,

    merchant_lat,
    merchant_lon,

    target,

    {{ amount_bucket('amount') }} AS amount_bucket

FROM {{ source('raw', 'transactions') }}
