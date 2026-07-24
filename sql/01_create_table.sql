-- ============================================================
-- Project: Supply Chain Analytics
-- File: 01_create_table.sql
-- Purpose: Create the PostgreSQL table for the processed dataset
-- ============================================================

DROP TABLE IF EXISTS supply_chain_orders;

CREATE TABLE supply_chain_orders (
    type                         VARCHAR(30),
    days_for_shipping_real       INTEGER,
    days_for_shipment_scheduled  INTEGER,
    benefit_per_order            NUMERIC(14, 2),
    sales_per_customer           NUMERIC(14, 2),
    delivery_status              VARCHAR(50),
    late_delivery_risk           SMALLINT,
    category_name                VARCHAR(100),
    customer_country             VARCHAR(100),
    customer_id                  INTEGER,
    customer_segment             VARCHAR(50),
    department_name              VARCHAR(100),
    market                       VARCHAR(50),
    order_city                   VARCHAR(150),
    order_country                VARCHAR(100),
    order_date_dateorders        TIMESTAMP,
    order_id                     INTEGER,
    order_item_discount          NUMERIC(14, 2),
    order_item_discount_rate     NUMERIC(10, 6),
    order_item_profit_ratio      NUMERIC(14, 6),
    order_item_quantity          INTEGER,
    sales                        NUMERIC(14, 2),
    order_item_total             NUMERIC(14, 2),
    order_profit_per_order       NUMERIC(14, 2),
    order_region                 VARCHAR(100),
    order_state                  VARCHAR(150),
    order_status                 VARCHAR(50),
    product_name                 VARCHAR(255),
    product_price                NUMERIC(14, 2),
    shipping_date_dateorders     TIMESTAMP,
    shipping_mode                VARCHAR(50),
    shipping_delay_days          INTEGER,
    delivery_performance         VARCHAR(20),
    profit_margin                NUMERIC(14, 6),
    profitability_category       VARCHAR(30),

    CONSTRAINT chk_late_delivery_risk
        CHECK (late_delivery_risk IN (0, 1)),

    CONSTRAINT chk_delivery_performance
        CHECK (
            delivery_performance IN ('Early', 'On Time', 'Delayed')
        ),

    CONSTRAINT chk_profitability_category
        CHECK (
            profitability_category IN (
                'Loss',
                'Low Margin',
                'Healthy Margin'
            )
        ),

    CONSTRAINT chk_order_quantity
        CHECK (order_item_quantity >= 0)
);