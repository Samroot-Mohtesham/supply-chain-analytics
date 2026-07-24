-- ============================================================
-- Project: Supply Chain Analytics
-- File: 02_data_quality_checks.sql
-- Purpose: Validate the processed dataset after PostgreSQL import
-- ============================================================


-- 1. Dataset size, unique orders and date range
SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT order_id) AS unique_orders,
    MIN(order_date_dateorders) AS earliest_order,
    MAX(order_date_dateorders) AS latest_order
FROM supply_chain_orders;


-- 2. Check missing values in important analytical fields
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL)
        AS missing_order_id,

    COUNT(*) FILTER (WHERE category_name IS NULL)
        AS missing_category_name,

    COUNT(*) FILTER (WHERE order_country IS NULL)
        AS missing_order_country,

    COUNT(*) FILTER (WHERE shipping_mode IS NULL)
        AS missing_shipping_mode,

    COUNT(*) FILTER (WHERE sales IS NULL)
        AS missing_sales,

    COUNT(*) FILTER (WHERE order_profit_per_order IS NULL)
        AS missing_profit,

    COUNT(*) FILTER (WHERE delivery_performance IS NULL)
        AS missing_delivery_performance
FROM supply_chain_orders;


-- 3. Check for exact duplicate rows
SELECT
    COUNT(*) - COUNT(DISTINCT TO_JSONB(supply_chain_orders))
        AS exact_duplicate_rows
FROM supply_chain_orders;


-- 4. Validate late-delivery-risk values
SELECT
    late_delivery_risk,
    COUNT(*) AS row_count
FROM supply_chain_orders
GROUP BY late_delivery_risk
ORDER BY late_delivery_risk;


-- 5. Validate delivery-performance categories
SELECT
    delivery_performance,
    COUNT(*) AS row_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain_orders
GROUP BY delivery_performance
ORDER BY row_count DESC;


-- 6. Validate profitability categories
SELECT
    profitability_category,
    COUNT(*) AS row_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM supply_chain_orders
GROUP BY profitability_category
ORDER BY row_count DESC;


-- 7. Check the engineered shipping-delay field
SELECT
    COUNT(*) AS inconsistent_shipping_delay_rows
FROM supply_chain_orders
WHERE shipping_delay_days IS DISTINCT FROM
      (
          days_for_shipping_real
          - days_for_shipment_scheduled
      );


-- 8. Check the engineered delivery-performance field
SELECT
    COUNT(*) AS inconsistent_delivery_performance_rows
FROM supply_chain_orders
WHERE delivery_performance IS DISTINCT FROM
      CASE
          WHEN shipping_delay_days < 0 THEN 'Early'
          WHEN shipping_delay_days = 0 THEN 'On Time'
          ELSE 'Delayed'
      END;


-- 9. Check the engineered profitability category
SELECT
    COUNT(*) AS inconsistent_profitability_category_rows
FROM supply_chain_orders
WHERE profitability_category IS DISTINCT FROM
      CASE
          WHEN profit_margin < 0 THEN 'Loss'
          WHEN profit_margin < 20 THEN 'Low Margin'
          ELSE 'Healthy Margin'
      END;


-- 10. Check the engineered profit-margin calculation
SELECT
    COUNT(*) AS inconsistent_profit_margin_rows
FROM supply_chain_orders
WHERE sales_per_customer <> 0
  AND ABS(
        profit_margin
        - (
            benefit_per_order
            / NULLIF(sales_per_customer, 0)
          ) * 100
      ) > 0.01;


-- 11. Check for invalid numerical values
SELECT
    COUNT(*) FILTER (WHERE order_item_quantity < 0)
        AS negative_quantities,

    COUNT(*) FILTER (
        WHERE late_delivery_risk NOT IN (0, 1)
    ) AS invalid_delivery_risk_values,

    COUNT(*) FILTER (
        WHERE days_for_shipping_real < 0
    ) AS negative_shipping_days
FROM supply_chain_orders;