# Nepal Agriculture Analytics — SQL Analysis

## Overview

This repository contains the SQL analysis phase of the **Nepal Agriculture Analytics** project, using official agricultural data from Nepal.

PostgreSQL was used to explore, validate, and analyze agricultural datasets to understand production trends, provincial differences, livestock statistics, fertilizer sales, and agricultural commodity contributions.

The objective is to extract meaningful insights from official agricultural data using SQL queries and analytical techniques.

## Tools & Technologies

- **Database:** PostgreSQL
- **SQL Environment:** pgAdmin / VS Code
- **Language:** SQL
- **Data Source:** Official Nepal agricultural statistics

## Database Setup

Create the database in PostgreSQL:

```sql
CREATE DATABASE nepal_agriculture_analytics;
```

Import the original CSV files into PostgreSQL as separate tables.

Database name:

`nepal_agriculture_analytics`

## Dataset Overview

The analysis uses 13 original CSV datasets.

| No. | Source CSV File | Database Table |
|---|---|---|
| 01 | `01_cereal_crops_yearly.csv` | `cereal_crops_yearly` |
| 02 | `02_cereal_production_by_province_2024_25.csv` | `cereal_production_by_province` |
| 03 | `03_cereal_production_by_district_2024_25.csv` | `cereal_production_by_district` |
| 04 | `04_major_cash_crops_yearly.csv` | `major_cash_crops_yearly` |
| 05 | `05_major_cash_crops_by_province_2024_25.csv` | `major_cash_crops_by_province` |
| 06 | `06_pulses_yearly.csv` | `pulses_yearly` |
| 07 | `07_livestock_population_yearly.csv` | `livestock_population_yearly` |
| 08 | `08_livestock_products_yearly.csv` | `livestock_products_yearly` |
| 09 | `09_major_fruits_yearly.csv` | `major_fruits_yearly` |
| 10 | `10_fresh_vegetables_yearly.csv` | `fresh_vegetables_yearly` |
| 11 | `11_fresh_vegetables_by_province_2024_25.csv` | `fresh_vegetables_by_province` |
| 12 | `12_chemical_fertilizer_sales_yearly.csv` | `chemical_fertilizer_sales_yearly` |
| 13 | `13_agriculture_gdp_commodity_contribution_2024_25.csv` | `agriculture_gdp_commodity_contribution` |

## SQL Project Structure

The SQL work is organized into separate scripts for data exploration, data-quality checks, and dataset-specific analysis.

- `01_data_exploration.sql` — Initial database and dataset exploration.
- `02_data_quality_checks.sql` — Data validation, NULL checks, duplicate checks, and negative-value checks.
- `03_crop_production_analysis.sql` — Initial crop production analysis.
- Additional SQL scripts — Separate analytical queries for the individual agricultural datasets.

Each dataset was analyzed independently to maintain clarity and avoid unnecessary combinations of unrelated data.

## Analysis Performed

### 1. Crop Production Analysis

- Year-wise cereal production trends.
- Crop-wise production and cultivated area.
- Provincial and district-level production comparisons.
- Major cash crop production and yield analysis.
- Pulse production trends and year-over-year growth.
- Highest-producing crops and provincial rankings.

### 2. Livestock Analysis

- Livestock population by category.
- Year-wise livestock population trends.
- Livestock population growth using `LAG()`.
- Milk, meat, egg, fish, and wool production analysis.
- Product-specific production comparisons.

Different livestock product units were kept separate to avoid invalid comparisons.

### 3. Fruits and Vegetables Analysis

- Fruit-group-wise production trends.
- Productive area and cultivated area comparisons.
- Yield analysis.
- Official total validation against individual fruit groups.
- Fresh vegetable production trends.
- Provincial production comparisons and rankings.

### 4. Fertilizer Sales Analysis

- Total fertilizer sales by type.
- Year-wise fertilizer sales trends.
- Year-over-year growth analysis.
- Fertilizer contribution percentages.
- Fertilizer sales composition and rankings.

### 5. Agricultural GDP Commodity Contribution

- Commodity contribution rankings.
- Top and bottom contributing commodities.
- Average, minimum, and maximum contribution statistics.
- Cleaned analytical view for commodity-level analysis.

## SQL Concepts Practised

The project provided practical experience with:

- `SELECT`, `WHERE`, `ORDER BY`, and `GROUP BY`
- Aggregate functions: `SUM()`, `AVG()`, `MIN()`, `MAX()`, and `COUNT()`
- `CASE WHEN` conditional logic
- Common Table Expressions (CTEs)
- Window functions
- `LAG()` for year-over-year comparisons
- `RANK()` for ranking agricultural categories
- `SUM() OVER()` for contribution calculations
- `FILTER` for conditional aggregation
- `NULLIF()` for safe division
- `ROUND()` for numerical formatting
- `CREATE OR REPLACE VIEW` for reusable cleaned datasets
- `UNION ALL` for combining compatible query results

## Data Quality & Cleaning Decisions

Data quality checks were performed before the main analysis.

The following issues were identified:

- Missing values in selected datasets.
- An exact duplicate record in the agriculture GDP commodity contribution dataset.
- Missing observations for certain agricultural categories.
- Inconsistent yield scales in the pulses dataset.
- Different measurement units across livestock products.

### Cleaning Approach

- Original source tables were preserved.
- Missing values were not automatically replaced with zero.
- Source data was not modified simply to make calculations easier.
- Aggregate rows were excluded from component-level calculations where appropriate.
- The agriculture GDP analytical view excludes zero-contribution records, the three identified aggregate categories, and exact duplicate combinations.

The cleaned GDP view is:

`agriculture_gdp_commodity_clean`

This view preserves the original source table while providing a filtered dataset for analysis.

## Important Analytical Considerations

- Aggregate rows such as `Total` were handled separately to avoid double-counting.
- Production values were compared only when measurement units were compatible.
- Year-over-year calculations used chronological fiscal-year ordering.
- Missing observations were treated as missing data rather than zero production.
- Reported source values were preserved, with calculated values used for validation where appropriate.

## Project Objective

The SQL analysis aims to understand:

1. How agricultural production has changed over time in Nepal.
2. Which crops and agricultural categories contribute most to production.
3. How agricultural production differs across provinces and districts.
4. How livestock populations and livestock product outputs have evolved.
5. How fertilizer sales have changed over time.
6. Which commodities have the highest reported agricultural GDP contributions.

## Next Steps

The SQL analysis will be used alongside Python (Pandas) for exploratory data analysis and statistical analysis, and Power BI for interactive dashboards and visual reporting.

---

**Project:** Nepal Agriculture Analytics  
**Database:** PostgreSQL  
**Data Coverage:** 13 official agricultural datasets