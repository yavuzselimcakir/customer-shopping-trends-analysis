-- SQLite queries for Customer Shopping Trends Analysis.
-- Run the notebook's SQLite setup cell first to create and populate shopping.
-- Column names use lowercase snake_case, including purchase_amount_usd.

-- 1. Record counts and average purchase amount by category.
SELECT
    category,
    COUNT(*) AS num_records,
    ROUND(AVG(purchase_amount_usd), 2) AS average_purchase_amount
FROM shopping
GROUP BY category
ORDER BY num_records DESC;

-- 2. Compare subscribers and non-subscribers.
SELECT
    subscription_status,
    COUNT(*) AS num_records,
    ROUND(AVG(purchase_amount_usd), 2) AS average_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM shopping
GROUP BY subscription_status
ORDER BY subscription_status;

-- 3. Average review rating by shipping type.
SELECT
    shipping_type,
    COUNT(*) AS num_records,
    ROUND(AVG(review_rating), 2) AS avg_review_rating
FROM shopping
GROUP BY shipping_type
ORDER BY AVG(review_rating) DESC;

-- 4. Categories whose average purchase amount exceeds the overall average.
SELECT
    category,
    COUNT(*) AS num_records,
    ROUND(AVG(purchase_amount_usd), 2) AS average_purchase_amount
FROM shopping
GROUP BY category
HAVING AVG(purchase_amount_usd) > (
    SELECT AVG(purchase_amount_usd)
    FROM shopping
)
ORDER BY AVG(purchase_amount_usd) DESC;

-- 5. Purchase-frequency distribution within each subscription group.
-- Preserve the original frequency labels because their definitions are unverified.
WITH subscription_totals AS (
    SELECT
        subscription_status,
        COUNT(*) AS subscription_total
    FROM shopping
    GROUP BY subscription_status
),
frequency_counts AS (
    SELECT
        subscription_status,
        frequency_of_purchases,
        COUNT(*) AS frequency_count
    FROM shopping
    GROUP BY subscription_status, frequency_of_purchases
)
SELECT
    freq.subscription_status,
    freq.frequency_of_purchases,
    freq.frequency_count,
    totals.subscription_total,
    ROUND(
        100.0 * freq.frequency_count / totals.subscription_total,
        2
    ) AS percentage
FROM frequency_counts AS freq
JOIN subscription_totals AS totals
    ON freq.subscription_status = totals.subscription_status
ORDER BY
    freq.subscription_status,
    freq.frequency_count DESC,
    freq.frequency_of_purchases;
