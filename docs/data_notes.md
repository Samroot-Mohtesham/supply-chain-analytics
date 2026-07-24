# Data Discovery Notes

## Dataset Information

Dataset:
DataCo Supply Chain Dataset

Rows:
180519

Columns:
53


## Main Analysis Areas

1. Delivery Performance
2. Sales & Profitability
3. Customer Analysis
4. Product Analysis


## Data Quality Findings

Missing values found:

- Customer Lname: 8 missing values
- Customer Zipcode: 3 missing values


## Privacy Considerations

Customer personal information will not be used for analysis.

Columns containing personal data will be removed following GDPR principles.


## SQL Analysis Findings

### Delivery Performance

- 180,519 total orders analysed.
- 57.28% of orders were delayed.
- Only 18.70% arrived on time.

### Shipping Mode Analysis

- First Class had the highest delay risk at 95.32%.
- Standard Class had the lowest delay risk at 38.07%.
- Faster shipping modes do not necessarily produce better delivery performance.
- Further investigation is required to understand whether this is caused by stricter delivery expectations or operational issues.