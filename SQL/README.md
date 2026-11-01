# Nepal Agriculture Analytics — SQL Analysis

![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=for-the-badge&logo=postgresql&logoColor=white)

![SQL](https://img.shields.io/badge/Language-SQL-blue?style=for-the-badge)

![Datasets](https://img.shields.io/badge/Datasets-13-green?style=for-the-badge)

![Analysis](https://img.shields.io/badge/Analysis-PostgreSQL-orange?style=for-the-badge)

## 1. Overview

This repository contains the SQL analysis phase of the **Nepal Agriculture Analytics** project.

The project uses official agricultural statistics from Nepal to explore agricultural production, livestock population, agricultural products, fertilizer sales, and commodity contributions.

PostgreSQL is used to organize, validate, clean analytically where necessary, and analyze the datasets to identify meaningful patterns and trends in Nepal's agricultural sector.

The SQL analysis focuses on answering questions such as:

- How has agricultural production changed over time?
- Which crops contribute most to total production?
- Which provinces and districts have higher agricultural production?
- How have livestock populations and livestock product outputs changed?
- How have chemical fertilizer sales evolved?
- Which commodities have the highest reported agricultural GDP contributions?

The objective is to transform raw agricultural datasets into meaningful, data-driven findings using SQL.

---

## 2. Tools & Technologies

| Tool / Technology | Purpose |
|---|---|
| PostgreSQL | Relational database management and SQL analysis |
| pgAdmin | Database management and CSV data import |
| VS Code | Writing and executing SQL queries |
| SQL | Data exploration, validation, cleaning, and analysis |

---

## 3. Data Source

The project uses 13 original CSV datasets containing agricultural statistics.

The datasets cover:

- Cereal crops
- Provincial cereal production
- District-level cereal production
- Major cash crops
- Pulses
- Livestock population
- Livestock products
- Fruits
- Fresh vegetables
- Chemical fertilizer sales
- Agricultural GDP commodity contributions

**Source:** Official agricultural statistics from Nepal's Ministry of Agriculture, Forests and Environment.

The original CSV files are preserved in the project's `csv_source_files/` directory.

---

## 4. Database Setup

### Database Information

| Property | Value |
|---|---|
| Database Name | `nepal_agriculture_analytics` |
| Database System | PostgreSQL |
| Source Format | CSV |
| Number of Datasets | 13 |

### Create Database

```sql
CREATE DATABASE nepal_agriculture_analytics;
```

Connect to the newly created database using pgAdmin or your preferred PostgreSQL client.

### Data Import

The 13 original CSV files were imported into PostgreSQL as separate tables.

Each dataset was maintained independently to preserve its original structure and make the analysis easier to manage.

---

## 5. Dataset Overview

The following table shows the relationship between the original CSV files and their corresponding PostgreSQL tables.

| No. | Original CSV File | PostgreSQL Table |
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

---

## 6. SQL Project Structure

The SQL directory is organized into separate scripts for initial exploration, data-quality checks, and individual dataset analyses.

```text
SQL/
│
├── .vscode/
├── Cereal Production/
│
├── 01_data_exploration.sql
├── 02_data_quality_checks.sql
├── 03_crop_production_analysis.sql
├── 04_province_wise_cereal_production.sql
├── 05_cereal_production_by_district.sql
├── 06_major_cash_crops_yearly.sql
├── 07_major_cash_crops_by_province.sql
├── 08_pulses_yearly.sql
├── 09_livestock_population_yearly.sql
├── 10_livestock_products_yearly.sql
├── 11_major_fruits_yearly.sql
├── 12_fresh_vegetables_yearly.sql
├── 13_fresh_vegetables_by_province.sql
├── 14_chemical_fertilizer_sales_yearly.sql
├── 15_agriculture_gdp_commodity_contribution.sql
│
├── Consolidated Quality Summary.csv
├── Summary table.csv
├── Nepal_agriculture.session.sql
└── README.md
```

### SQL Script Descriptions

| SQL File | Description |
|---|---|
| `01_data_exploration.sql` | Initial exploration of the imported datasets. |
| `02_data_quality_checks.sql` | NULL checks, duplicate detection, negative-value checks, and data validation. |
| `03_crop_production_analysis.sql` | General crop production analysis. |
| `04_province_wise_cereal_production.sql` | Provincial cereal production comparisons. |
| `05_cereal_production_by_district.sql` | District-level cereal production analysis. |
| `06_major_cash_crops_yearly.sql` | Historical cash crop production, cultivated area, and yield analysis. |
| `07_major_cash_crops_by_province.sql` | Provincial cash crop production comparisons. |
| `08_pulses_yearly.sql` | Pulse production, yield, growth, and contribution analysis. |
| `09_livestock_population_yearly.sql` | Livestock population trends and category comparisons. |
| `10_livestock_products_yearly.sql` | Milk, meat, eggs, fish, and wool production analysis. |
| `11_major_fruits_yearly.sql` | Fruit production, productive area, yield, and total validation. |
| `12_fresh_vegetables_yearly.sql` | Yearly fresh vegetable production analysis. |
| `13_fresh_vegetables_by_province.sql` | Provincial fresh vegetable production comparisons. |
| `14_chemical_fertilizer_sales_yearly.sql` | Fertilizer sales trends, growth, and composition analysis. |
| `15_agriculture_gdp_commodity_contribution.sql` | Commodity contribution rankings and statistical analysis. |

---

## 7. Analysis Performed

### A. Data Exploration and Quality Checks

Before conducting the main analysis, the datasets were explored to understand their structure and identify potential data-quality issues.

Activities included:

- Inspecting imported tables and records.
- Identifying available agricultural categories.
- Checking distinct crop, livestock, and commodity names.
- Checking the number of records by fiscal year.
- Identifying missing values.
- Detecting duplicate records.
- Checking for negative values.
- Investigating inconsistencies in reported data.

### B. Cereal Production Analysis

Analyzed cereal crop production at yearly, provincial, and district levels.

Key analytical areas:

- Crop-wise production comparisons.
- Yearly cereal production trends.
- Provincial production comparisons.
- District-level production rankings.
- Production concentration across locations.
- Cultivated area and yield comparisons.

### C. Major Cash Crops Analysis

Analyzed the production and cultivation patterns of major cash crops.

Key analytical areas:

- Total production by cash crop.
- Year-wise production trends.
- Cultivated area comparisons.
- Average yield by crop.
- Year-over-year changes.
- Crop-wise production and area trends.
- Provincial cash crop production.
- Highest-producing crops by province.
- Provincial contribution percentages.

### D. Pulses Analysis

Analyzed pulse production and cultivation patterns.

Key analytical areas:

- Production by pulse crop.
- Year-wise production trends.
- Cultivated area comparisons.
- Calculated yield comparisons.
- Highest-producing pulse crop by year.
- Year-over-year production growth.
- Crop contribution percentages.
- Validation of reported total production against individual crop records.

### E. Livestock Population Analysis

Analyzed livestock population across different categories and fiscal years.

Key analytical areas:

- Total population by livestock category.
- Year-wise total population.
- Population comparisons by category and year.
- Highest livestock population category by year.
- Year-over-year population growth.
- Category-wise population contribution.

### F. Livestock Products Analysis

Analyzed historical production trends for different livestock products.

Products include:

- Milk
- Meat
- Eggs
- Fish
- Wool

Key analytical areas:

- Product-specific production trends.
- Year-over-year production growth.
- Milk production comparisons.
- Meat production comparisons.
- Egg production comparisons.
- Product-specific rankings where appropriate.

Different measurement units were kept separate to avoid invalid comparisons.

### G. Fruits Analysis

Analyzed fruit-group production and cultivation patterns.

Key analytical areas:

- Production by fruit group.
- Year-wise production trends.
- Total and productive area comparisons.
- Average yield by fruit group.
- Year-over-year production growth.
- Highest-producing fruit group by year.
- Productive area percentage.
- Validation of official total fruit production and area against individual fruit groups.
- Total fruit production trends and growth.

### H. Fresh Vegetables Analysis

Analyzed yearly fresh vegetable production and provincial differences.

Key analytical areas:

- Yearly vegetable production.
- Year-over-year production growth.
- Provincial production comparisons.
- Cultivated area by province.
- Average yield by province.
- Provincial contribution percentages.
- Production rankings.

### I. Chemical Fertilizer Sales Analysis

Analyzed chemical fertilizer sales across 15 fiscal years.

Fertilizer categories:

- Urea
- DAP
- Potash

Key analytical areas:

- Total sales by fertilizer type.
- Year-wise fertilizer sales trends.
- Total fertilizer sales by fiscal year.
- Year-over-year total sales growth.
- Growth by fertilizer type.
- Fertilizer contribution percentages.
- Highest and lowest sales years.
- Sales rankings.
- Fertilizer composition by year.

### J. Agriculture GDP Commodity Contribution

Analyzed reported commodity contribution percentages for FY 2024/25.

Key analytical areas:

- Commodity contribution rankings.
- Top 10 contributing commodities.
- Bottom 10 contributing commodities.
- Average contribution.
- Highest and lowest contribution values.

A separate analytical view was created to exclude identified aggregate categories, zero-contribution records, and exact duplicate combinations while preserving the original source table.

---

## 8. Data Quality and Cleaning Decisions

Data quality checks identified several issues across the source datasets.

### Identified Issues

- Missing values in selected datasets.
- An exact duplicate record in the agriculture GDP commodity contribution dataset.
- Missing observations for certain agricultural categories.
- Inconsistent yield scales in the pulses dataset.
- Different measurement units across livestock products.

### Cleaning Approach

The following principles were followed:

1. Original source tables were preserved.
2. Missing values were not automatically replaced with zero.
3. Duplicate records were investigated before being excluded from analytical calculations.
4. Aggregate rows were excluded from component-level calculations when necessary to prevent double-counting.
5. Different measurement units were not combined inappropriately.
6. Calculated values were used for validation without overwriting official source values.

### Agriculture GDP Analytical View

The original table:

`agriculture_gdp_commodity_contribution`

The analytical view:

`agriculture_gdp_commodity_clean`

The view applies the following conditions:

- Excludes zero-contribution records.
- Excludes `AGRICULTURE TOTAL WITH FORESTRY`.
- Excludes `CROPS TOTAL`.
- Excludes `LIVESTOCK TOTAL`.
- Uses `DISTINCT` to remove exact duplicate commodity-contribution combinations.

Example:

```sql
CREATE OR REPLACE VIEW agriculture_gdp_commodity_clean AS
SELECT DISTINCT
    commodity,
    contribution_pct
FROM agriculture_gdp_commodity_contribution
WHERE contribution_pct > 0
  AND TRIM(commodity) NOT IN (
      'AGRICULTURE TOTAL WITH FORESTRY',
      'CROPS TOTAL',
      'LIVESTOCK TOTAL'
  );
```

This approach keeps the original imported data intact while providing a filtered dataset for commodity-level analysis.

---

## Key Findings – Nepal Agriculture Analytics

### 1. Overall Crop Production Analysis

- Paddy was the highest-producing cereal crop, with total production of 58.55 million MT.
- Maize ranked second with approximately 24.33 million MT.
- Wheat followed with approximately 18.19 million MT.
- Millet contributed approximately 2.53 million MT, while barley and buckwheat had comparatively lower production.
- Paddy, maize and wheat account for the majority of recorded cereal production.

### 2. Province-wise Cereal Production

- Koshi recorded the highest cereal production at 2.86 million MT.
- Lumbini ranked second with 2.44 million MT, followed by Madhesh with 2.38 million MT.
- Karnali had the lowest production at 542,030 MT.
- Cereal production is concentrated in Koshi, Lumbini and Madhesh.

### 3. Highest-Producing Cereal Crop by Province

- Maize leads cereal production in Bagmati, Gandaki and Karnali.
- Paddy is the leading crop in Koshi, Lumbini and Sudurpashchim.
- Buckwheat is the highest-producing cereal in Madhesh.
- These results highlight differences in regional cereal production patterns.

### 4. District-wise Cereal Production

- Jhapa is the highest-producing district with 851,817 MT.
- Morang ranks second with 624,581 MT, followed by Kailali with 475,143 MT.
- Cereal production varies considerably across districts.

### 5. Major Cash Crop Production

- Sugarcane leads with approximately 33.13 million MT.
- Potato follows closely with 32.16 million MT.
- Oilseed production stands at approximately 2.61 million MT.
- Jute and cotton contribute comparatively smaller production volumes.

### 6. Cash Crop Production by Province

- Potato is the leading cash crop in Bagmati, Gandaki, Karnali, Koshi and Lumbini.
- Sugarcane leads in Madhesh and Sudurpashchim.
- This highlights regional specialization in cash crop production.

### 7. Pulse Production

- Lentil is the leading pulse crop throughout the observed period.
- Its production peaked at 262,835 MT in 2019/20 and declined to 141,257 MT in 2024/25.
- This indicates a substantial recent decline in lentil production.

### 8. Livestock Population

- Fowl is the largest livestock category, contributing 61.90% of total recorded livestock population.
- Goat contributes 11.89%, followed by laying hens at 11.05%.
- Fowl remains the dominant category across the observed years.
- Its population reached a peak in 2019/20 before declining.

### 9. Fruit Production

- Summer fruits account for the largest production share at 68.15%.
- Citrus fruits contribute 22.04%, while winter fruits contribute 9.82%.
- Summer fruits remain the leading fruit group, with production increasing over most of the observed period.

### 10. Fresh Vegetable Production

- Fresh vegetable production increased from 3,929,034 MT in 2015/16 to 4,572,267 MT in 2024/25.
- Production declined by 4.56% in 2016/17 and 7.23% in 2019/20, but increased in most subsequent years.
- The highest year-on-year growth was 7.91% in 2018/19.
- Production reached its highest recorded level in 2024/25.

### 11. Fresh Vegetable Production by Province

- Madhesh was the largest vegetable-producing province, contributing 30.31% of total production.
- Bagmati ranked second with 19.60%, followed by Koshi with 18.18%.
- Lumbini contributed 14.62%, while Gandaki contributed 7.45%.
- Sudurpashchim and Karnali contributed 6.53% and 3.31%, respectively.
- Madhesh produced approximately nine times as much as Karnali.

### 12. Chemical Fertilizer Sales

- Total fertilizer sales increased from 110,013 MT in 2010/11 to 441,305 MT in 2024/25.
- Sales reached their highest level of 458,318 MT in 2023/24.
- The sharpest decline occurred in 2021/22, when total sales dropped by 39.91%.
- Sales recovered significantly in 2022/23 and 2023/24 before declining by 3.71% in 2024/25.
- Fertilizer growth varied considerably by type, with different patterns for urea, DAP and potash.

### 13. Agriculture GDP Commodity Contribution

- The cleaned dataset contains 78 commodities.
- Vegetables were the largest individual contributor at 14.47%.
- Rice Paddy (Not Husked) contributed 12.82%, followed by Forestry Total at 8.71%.
- Raw Milk of Buffalo contributed 7.69%, while Maize (Corn) contributed 6.64%.
- Potatoes and wheat contributed 6.56% and 5.88%, respectively.
- The average commodity contribution was 1.28%, with a standard deviation of 2.73 percentage points.
- The lowest individual contributions were approximately 0.01%.

## 9. SQL Concepts and Functions Practised

This project provided practical experience with SQL querying, analytical functions, and data validation.

| SQL Concept | Application |
|---|---|
| `SELECT` | Retrieving data from tables |
| `WHERE` | Filtering records |
| `ORDER BY` | Sorting analytical results |
| `GROUP BY` | Grouping agricultural categories |
| `HAVING` | Filtering grouped results |
| `DISTINCT` | Identifying unique records |
| `COUNT()` | Counting records and categories |
| `SUM()` | Calculating total production and sales |
| `AVG()` | Calculating average yield and contribution |
| `MIN()` / `MAX()` | Identifying minimum and maximum values |
| `CASE WHEN` | Conditional categorization |
| CTEs | Structuring multi-step analytical queries |
| `LAG()` | Comparing current and previous fiscal years |
| `RANK()` | Ranking crops, provinces, and commodities |
| `ROW_NUMBER()` | Assigning sequential rankings |
| `SUM() OVER()` | Calculating contribution percentages |
| `FILTER` | Conditional aggregation |
| `NULLIF()` | Preventing division-by-zero errors |
| `ROUND()` | Formatting numerical results |
| `UNION ALL` | Combining compatible query results |
| `CREATE VIEW` | Creating reusable analytical datasets |

---

## 10. Important Analytical Considerations

Several considerations were maintained throughout the analysis:

- Fiscal-year ordering was used for historical comparisons.
- Aggregate rows such as `Total` were handled separately from individual categories.
- Missing observations were treated as NULL rather than assumed to be zero.
- Livestock products with different measurement units were analyzed separately.
- Reported yields were compared with calculated yields where appropriate.
- Source values were preserved.
- Commodity contribution percentages were interpreted according to their source definitions rather than automatically assuming they must sum to 100%.

---

## 11. Project Outcomes

The SQL phase established a structured foundation for further analysis of Nepal's agricultural sector.

Through PostgreSQL, the project covered:

- Exploration of 13 agricultural datasets.
- Data-quality assessment and validation.
- Historical agricultural production analysis.
- Provincial and district-level comparisons.
- Livestock population and product analysis.
- Fertilizer sales trend analysis.
- Agricultural commodity contribution analysis.
- Practical use of CTEs and window functions.

The resulting SQL queries and analytical views provide a foundation for further exploratory data analysis and visualization.

---

## 12. Next Steps

The project will continue with:

**Python — Exploratory Data Analysis**

- Data loading and validation using Pandas.
- Statistical analysis using NumPy and Pandas.
- Further investigation of agricultural trends and patterns.
- Data visualization using Matplotlib.

**Power BI — Interactive Dashboard**

- Data transformation using Power Query.
- Data modeling and relationships.
- DAX measures and KPIs.
- Interactive agricultural dashboards.

Python visualizations and project-level insights will be documented separately as those phases are completed.

---

## 13. Project Information

**Project:** Nepal Agriculture Analytics  
**Analysis Phase:** SQL Analysis  
**Database:** PostgreSQL  
**Datasets:** 13 official agricultural CSV files  
**SQL Scripts:** 15  
**Repository:** [GitHub — Nepal Agriculture Analytics](https://github.com/Srijan0113/Nepal_Agriculture_Analysis)

*This project is an independent data analytics project based on official agricultural statistics from Nepal.*