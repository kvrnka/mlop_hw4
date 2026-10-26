SELECT
    transaction_time,
    amount,
    target

FROM {{ ref('stg_transactions') }}

WHERE amount < 0
