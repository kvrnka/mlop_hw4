SELECT
    us_state,
    total_transactions,
    fraud_count,
    fraud_rate

FROM {{ ref('mart_fraud_by_state') }}

WHERE
    fraud_rate < 0
    OR fraud_rate > 100
    OR fraud_count > total_transactions
    OR total_transactions = 0
