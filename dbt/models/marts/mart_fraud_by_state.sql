SELECT
    us_state,

    count() AS total_transactions,

    countIf(target = 1) AS fraud_count,

    round(
        100.0 * countIf(target = 1) / count(),
        2
    ) AS fraud_rate,

    uniqExact(
        tuple(name_1, name_2, street, post_code)
    ) AS unique_customers,

    uniqExact(merch) AS unique_merchants,

    round(
        sum(ifNull(amount, 0)),
        2
    ) AS total_amount,

    round(
        sumIf(ifNull(amount, 0), target = 1),
        2
    ) AS fraud_amount

FROM {{ ref('stg_transactions') }}

GROUP BY us_state
