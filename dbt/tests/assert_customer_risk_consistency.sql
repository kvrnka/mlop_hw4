SELECT *
FROM {{ ref('mart_customer_risk_profile') }}

WHERE
    fraud_count > total_transactions
    OR fraud_rate < 0
    OR fraud_rate > 100
    OR first_transaction_time > last_transaction_time
    OR (
        fraud_count = 0
        AND risk_level != 'LOW'
    )
