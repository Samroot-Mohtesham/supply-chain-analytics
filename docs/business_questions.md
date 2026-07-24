# Business Questions and Findings

## 1. What is the overall business performance?

The dataset contains 180,519 records representing 65,752 unique orders between January 2015 and January 2018.

### Executive KPIs

- Total Sales: $36.78 million
- Total Profit: $3.97 million
- Unique Orders: 65,752
- Average Profit Margin: 12.04%
- Late Delivery Risk: 54.83%
- Average Shipping Delay: 0.57 days

---

## 2. How reliable is the delivery process?

Delivery performance shows significant operational challenges:

- 57.28% of records were delayed.
- 24.02% were delivered early.
- Only 18.70% were delivered exactly on time.
- 37,698 unique orders were associated with delayed deliveries.

This indicates an opportunity to improve fulfilment reliability and delivery planning.

---

## 3. Which shipping modes have the highest delivery risk?

Shipping performance varies considerably by shipping mode:

- First Class recorded the highest late-delivery risk at approximately 95.32%.
- Second Class recorded the second-highest risk at approximately 76.63%.
- Standard Class recorded the lowest late-delivery risk at approximately 38.07%.

Premium or faster shipping options did not consistently produce better delivery performance. This may indicate overly aggressive delivery promises or operational capacity constraints.

---

## 4. Are delivery delays concentrated in specific markets?

Late-delivery risk was relatively consistent across markets and regions.

The comparatively small geographic differences suggest that delivery delays are more likely caused by broader operational processes than by one specific country or region.

---

## 5. Which product categories drive sales and profitability?

Product performance varies significantly across categories.

The analysis compares:

- Total sales
- Total profit
- Unique orders
- Average profit margin
- Average shipping delay

High-margin categories are not always the largest contributors to total profit. Sales volume and customer demand also have a major influence on category profitability.

---

## 6. Which customer segments contribute the most revenue?

Customer-segment analysis evaluates:

- Total sales
- Total profit
- Unique orders
- Average profit margin
- Late-delivery risk

This helps identify the most valuable customer segments and compare their operational performance.

---

## 7. How are delivery performance and profitability connected?

The analysis compares delivery categories with profitability categories:

- Healthy Margin
- Low Margin
- Loss

Delayed deliveries occur across both profitable and loss-making transactions. Operational improvements should therefore prioritize combinations with high profit exposure and high delivery risk.

---

## 8. Which country and category combinations have the greatest delayed-profit exposure?

The analysis identifies delayed orders by:

- Country
- Product category
- Delayed sales
- Delayed profit
- Average delay duration

This helps prioritize supply-chain improvements in high-value markets and product categories.

---

## Analytical Note

The dataset contains multiple product-level records for some orders. Therefore:

- `COUNT(*)` represents dataset records or line items.
- `COUNT(DISTINCT order_id)` represents unique orders.
- Delivery percentages in this project are calculated at record level unless stated otherwise.