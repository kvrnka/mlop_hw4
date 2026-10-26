SELECT
    cat_id,

    count() AS total_transactions,

    countIf(target = 1) AS fraud_count,

    round(
        100.0 * countIf(target = 1) / count(),
        2
    ) AS fraud_rate,

    round(sum(ifNull(amount, 0)), 2) AS total_amount,

    round(
        sumIf(ifNull(amount, 0), target = 1),
        2
    ) AS fraud_amount

FROM {{ ref('stg_transactions') }}

GROUP BY cat_id
