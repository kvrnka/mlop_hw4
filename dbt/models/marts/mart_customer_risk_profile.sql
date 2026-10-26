WITH customer_transactions AS (

    SELECT
        -- используем хэш в качестве уникального ключа
        cityHash64(
            lowerUTF8(trimBoth(name_1)),
            lowerUTF8(trimBoth(name_2)),
            lowerUTF8(trimBoth(street)),
            trimBoth(post_code),
            upperUTF8(trimBoth(us_state))
        ) AS customer_key,

        transaction_time,
        amount,
        target

    FROM {{ ref('stg_transactions') }}

),

customer_metrics AS (

    SELECT
        customer_key,

        count() AS total_transactions,

        countIf(target = 1) AS fraud_count,

        -- доля фрода в процентах
        round(
            100.0 * countIf(target = 1) / count(),
            2
        ) AS fraud_rate,

        -- средний чек
        round(avg(amount), 2) AS avg_amount,

        -- общая сумма покупок
        round(
            sum(ifNull(amount, 0)),
            2
        ) AS total_amount,

        min(transaction_time) AS first_transaction_time,
        max(transaction_time) AS last_transaction_time

    FROM customer_transactions

    GROUP BY customer_key

)

SELECT
    customer_key,
    total_transactions,
    fraud_count,
    fraud_rate,
    avg_amount,
    total_amount,
    first_transaction_time,
    last_transaction_time,

    -- категория риска
    multiIf(
        fraud_count >= 3 AND fraud_rate >= 10, 'HIGH',
        fraud_count >= 1, 'MEDIUM',
        'LOW'
    ) AS risk_level

FROM customer_metrics
