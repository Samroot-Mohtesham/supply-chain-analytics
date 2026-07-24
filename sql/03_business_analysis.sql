-- ============================================================
-- Project: Supply Chain Analytics
-- File: 03_business_analysis.sql
-- Purpose: Analyse supply chain, sales and delivery performance
-- ============================================================


-- ============================================================
-- 1. EXECUTIVE KPI OVERVIEW
-- ============================================================

SELECT
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin_pct,
    ROUND(AVG(late_delivery_risk) * 100, 2)
        AS late_delivery_risk_pct,
    ROUND(AVG(shipping_delay_days), 2)
        AS average_shipping_delay_days
FROM supply_chain_orders;


-- ============================================================
-- 2. DELIVERY PERFORMANCE
-- ============================================================

SELECT
    delivery_performance,
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain_orders
GROUP BY delivery_performance
ORDER BY total_records DESC;


-- ============================================================
-- 3. SHIPPING MODE PERFORMANCE
-- ============================================================

SELECT
    shipping_mode,
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS unique_orders,

    ROUND(
        AVG(late_delivery_risk) * 100,
        2
    ) AS late_delivery_risk_pct,

    ROUND(
        AVG(
            CASE
                WHEN delivery_performance = 'Delayed'
                THEN 1.0
                ELSE 0.0
            END
        ) * 100,
        2
    ) AS delayed_records_pct,

    ROUND(
        AVG(shipping_delay_days),
        2
    ) AS average_shipping_delay_days

FROM supply_chain_orders
GROUP BY shipping_mode
ORDER BY late_delivery_risk_pct DESC;


-- ============================================================
-- 4. MARKET DELIVERY PERFORMANCE
-- ============================================================

SELECT
    market,
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS unique_orders,

    ROUND(
        AVG(late_delivery_risk) * 100,
        2
    ) AS late_delivery_risk_pct,

    ROUND(
        AVG(shipping_delay_days),
        2
    ) AS average_shipping_delay_days

FROM supply_chain_orders
GROUP BY market
ORDER BY late_delivery_risk_pct DESC;


-- ============================================================
-- 5. COUNTRY SALES AND PROFITABILITY
-- ============================================================

SELECT
    order_country,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin_pct,
    ROUND(AVG(late_delivery_risk) * 100, 2)
        AS late_delivery_risk_pct

FROM supply_chain_orders
GROUP BY order_country
ORDER BY total_sales DESC;


-- ============================================================
-- 6. PRODUCT CATEGORY PERFORMANCE
-- ============================================================

SELECT
    category_name,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin_pct,
    ROUND(AVG(shipping_delay_days), 2)
        AS average_shipping_delay_days

FROM supply_chain_orders
GROUP BY category_name
ORDER BY total_profit DESC;


-- ============================================================
-- 7. CUSTOMER SEGMENT PERFORMANCE
-- ============================================================

SELECT
    customer_segment,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order), 2) AS total_profit,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(AVG(profit_margin), 2) AS average_profit_margin_pct,
    ROUND(AVG(late_delivery_risk) * 100, 2)
        AS late_delivery_risk_pct

FROM supply_chain_orders
GROUP BY customer_segment
ORDER BY total_sales DESC;


-- ============================================================
-- 8. DELIVERY PERFORMANCE VS PROFITABILITY
-- ============================================================

SELECT
    delivery_performance,
    profitability_category,
    COUNT(*) AS total_records,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(order_profit_per_order), 2) AS total_profit

FROM supply_chain_orders
GROUP BY
    delivery_performance,
    profitability_category
ORDER BY
    delivery_performance,
    total_profit DESC;


-- ============================================================
-- 9. HIGH-VALUE DELAYED ORDER EXPOSURE
-- ============================================================

SELECT
    order_country,
    category_name,
    COUNT(DISTINCT order_id) AS delayed_unique_orders,
    ROUND(SUM(sales), 2) AS delayed_sales,
    ROUND(SUM(order_profit_per_order), 2) AS delayed_profit,
    ROUND(AVG(shipping_delay_days), 2)
        AS average_delay_days

FROM supply_chain_orders
WHERE delivery_performance = 'Delayed'
GROUP BY
    order_country,
    category_name
ORDER BY delayed_profit DESC
LIMIT 20;