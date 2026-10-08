# Customer Shopping Trends Analysis

## Objective

Compare shopping patterns across product categories, subscription groups and shipping methods using Python, SQLite and an interactive dashboard.

## Tools

Python, pandas, matplotlib, seaborn, SQLite, Google Colab and Looker Studio.

## Analysis

The original Python exploration is followed by five SQL questions:

| Question | SQL skills |
| --- | --- |
| Record counts and average purchase amounts by category? | Aggregates, `GROUP BY`, `ORDER BY` |
| Average purchase amount and previous purchases by subscription status? | Multiple aggregates, `GROUP BY` |
| Average review ratings by shipping method? | `AVG`, `COUNT`, `GROUP BY` |
| Which categories exceed the overall average purchase amount? | `HAVING`, subquery |
| How do purchase-frequency distributions compare within subscription groups? | CTE, `JOIN`, percentage calculations |

The pandas DataFrame `df` populates the in-memory SQLite table `shopping`. Normalized SQL column names include `purchase_amount_usd`.

## Interactive Dashboard

[**Open the Shopping Behaviour Dashboard**](https://datastudio.google.com/reporting/f0ccf6e5-f97a-4308-88d4-eae2d700d9c5)

The dashboard shows four summary metrics and category, subscription and shipping-method comparisons. Category and subscription-status filters update the displayed metrics.

| Unfiltered metric | Value |
| --- | ---: |
| Records | 3,900 |
| Average purchase amount | $59.76 |
| Average review rating | 3.75 |
| Subscription rate | 27% |

Subscription rate is `AVG(is_subscriber)`, where subscribers are coded as 1 and non-subscribers as 0.

## Selected Findings

- Clothing has the most records: 1,737.
- Footwear has the highest average purchase amount ($60.26); Outerwear has the lowest ($57.17).
- Subscribers average $59.49 per recorded purchase, compared with $59.87 for non-subscribers.
- Subscribers average 26.08 previous purchases, compared with 25.08 for non-subscribers.

## Run the Project

1. Open `custome-data-analysis.ipynb` in Google Colab.
2. Upload `shopping_trends_updated.csv` to the session's working directory using the Colab Files panel.
3. Select **Runtime → Run all** to load `df`, produce the plots, populate SQLite and run the queries.
4. The export cell generates `shopping_dashboard.csv` for dashboard use. This generated file is not included in the repository.

For a local notebook environment, install the analysis packages with:

```bash
pip install pandas matplotlib seaborn
```

Python includes `sqlite3`; no separate SQLite installation is required. All queries are embedded in the notebook, so `analysis.sql` is optional in Colab. That SQL file requires `shopping` to be populated in the **same connection** using the notebook's import cells; it does not import the CSV.

## Repository Files

- `custome-data-analysis.ipynb` — Python exploration, SQL queries and dashboard CSV export.
- `shopping_trends_updated.csv` — supplied dataset.
- `analysis.sql` — the same five queries as a standalone SQL file.
- `README.md` — project documentation and dashboard link.

## Limitations

Results describe a dataset snapshot and do not establish causal effects. The source URL and collection methodology are not yet documented. Purchase amounts do not establish company revenue for a defined period.

Frequency labels remain as supplied: `Every 3 Months` and `Quarterly` may overlap; `Bi-Weekly` is ambiguous and may overlap with `Fortnightly`. They are not merged without source clarification.
