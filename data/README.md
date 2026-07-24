# Dataset

This project uses the DataCo Supply Chain Dataset.

The raw and processed CSV files are not included in this repository because of their large file sizes.

## Expected Local Structure

```text
data/
├── raw/
│   └── DataCoSupplyChainDataset.csv
└── processed/
    └── supply_chain_cleaned.csv
```

The processed dataset can be recreated by running:

```text
notebooks/01_data_discovery.ipynb
```

The notebook performs data exploration, privacy-column removal, column standardisation, feature engineering, date conversion, and processed-data export.