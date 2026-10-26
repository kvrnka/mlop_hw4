SELECT
    transaction_date,
    us_state,

    count() AS total_transactions,

    round(sum(ifNull(amount, 0)), 2) AS total_amount,

    round(avg(amount), 2) AS avg_amount,

    round(
        quantileExact(0.95)(toFloat64(amount)),
        2
    ) AS p95_amount,

    countIf(amount_bucket = 'LARGE')
        AS large_transactions,

    -- доля крупных транзакций в процентах
    round(
        100.0 * countIf(amount_bucket = 'LARGE')
        / count(),
        2
    ) AS large_transaction_share

FROM {{ ref('stg_transactions') }}

GROUP BY
    transaction_date,
    us_state
