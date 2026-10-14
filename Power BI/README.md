
# 🇳🇵 Nepal Agriculture Analytics | Power BI Dashboard

An interactive Power BI dashboard exploring Nepal's agricultural sector through crop production, provincial and district performance, livestock, fertilizer sales, and agricultural GDP contribution.


##  Project Overview

Nepal Agriculture Analytics is a data analytics project built in Power BI to explore agricultural production, productivity, regional differences, livestock patterns, fertilizer sales, and the economic contribution of agricultural commodities in Nepal.

The project uses official agricultural datasets and applies data cleaning, transformation, data modeling, DAX calculations, and interactive visualizations to make agricultural information easier to analyze.

The report contains a dedicated Home Page and five analytical pages.

###  Project Objectives

- Analyze historical crop production, cultivated area, and yield.
- Compare production and productivity across different crop groups.
- Identify leading provinces and districts in agricultural production.
- Explore livestock population and livestock product trends.
- Analyze fertilizer sales by type and over time.
- Examine agricultural commodity contributions to GDP.
- Build an interactive dashboard for exploring agricultural data.
- Communicate useful patterns and findings through data visualization.

---

##  Dashboard Preview

The following screenshots show the six pages of the Power BI report.

### 1. Home Page

The landing page introduces the project and provides navigation to the five analytical report pages.

![Nepal Agriculture Analytics Home Page](/images/Homepage.png)

### 2. Agriculture Overview

Provides an overview of agricultural indicators, historical crop production, top crops, GDP contribution, and leading cereal-producing districts.

![Agriculture Overview Dashboard](/images/Agriculture_Overview.png)

### 3. Crop Production Analysis

Explores crop production, cultivated area, yield comparison, crop composition, and production trends.

![Crop Production Analysis Dashboard](/images/Crop_Production_Analysis.png)

### 4. Provincial & District Analysis

Compares provincial crop production and district-level cereal production, cultivated area, and leading districts.

![Provincial and District Analysis Dashboard](/images/Provincial_and_District_Analysis.png)

### 5. Livestock Analysis

Examines livestock population trends, population by category, livestock products, and recorded product values over time.

![Livestock Analysis Dashboard](/images/Livestock_Analysis.png)

### 6. Fertilizer & GDP Analysis

Analyzes fertilizer sales trends, sales by fertilizer type, fertilizer composition, and agricultural GDP contribution by commodity.

![Fertilizer and GDP Analysis Dashboard](/images/Fertilizer_and_GDP_Analysis.png)

---

##  Tools & Technologies

| Tool | Purpose |
|---|---|
| Power BI Desktop | Dashboard development and visualization |
| Power Query | Data cleaning, transformation, and ETL |
| DAX | Measures, KPIs, and analytical calculations |
| CSV | Source data format |
| Git & GitHub | Version control and project documentation |

---

##  Source Datasets

The project uses 13 CSV files covering crop production, provincial and district statistics, livestock, fertilizer sales, and agricultural GDP contribution.

###  1. Crop Production Datasets

| CSV Filename | Description |
|---|---|
| `01_cereal_crops_yearly.csv` | Historical cereal crop area, production, and yield |
| `04_major_cash_crops_yearly.csv` | Historical major cash crop statistics |
| `06_pulses_yearly.csv` | Historical pulse crop area, production, and yield |
| `09_major_fruits_yearly.csv` | Fruit area, productive area, production, and yield |
| `10_fresh_vegetables_yearly.csv` | Historical fresh vegetable area and production |

###  2. Provincial & District Datasets

| CSV Filename | Description |
|---|---|
| `02_cereal_production_by_province_2024_25.csv` | Cereal production by province |
| `03_cereal_production_by_district_2024_25.csv` | District-level cereal production, area, and yield |
| `05_major_cash_crops_by_province_2024_25.csv` | Major cash crop statistics by province |
| `11_fresh_vegetables_by_province_2024_25.csv` | Fresh vegetable statistics by province |

###  3. Livestock Datasets

| CSV Filename | Description |
|---|---|
| `07_livestock_population_yearly.csv` | Historical livestock population by category |
| `08_livestock_products_yearly.csv` | Recorded livestock product values over time |

###  4. Fertilizer Dataset

| CSV Filename | Description |
|---|---|
| `12_chemical_fertilizer_sales_yearly.csv` | Annual Urea, DAP, Potash, and total fertilizer sales |

###  5. Agricultural GDP Dataset

| CSV Filename | Description |
|---|---|
| `13_agriculture_gdp_commodity_contribution_2024_25.csv` | Agricultural commodity contribution percentages for FY 2024/25 |

**Data source:** Official agricultural statistics from Nepal's Ministry of Agriculture and Livestock Development and the government publications used in the project.

Dataset coverage varies. Historical datasets support trend analysis, while the provincial, district, and GDP contribution datasets cover FY 2024/25.

---

##  Power Query: Data Cleaning & Transformation

Power Query was used to clean, standardize, and prepare the datasets before building the data model and report visuals.

### Key Data Preparation Activities

- Standardized column names and data types.
- Cleaned text fields and removed unnecessary HTML tags.
- Handled missing values where appropriate.
- Identified query errors and inconsistencies for further investigation.
- Converted pulse yield values from kg/ha to Mt/ha where applicable.
- Standardized column names across compatible datasets.
- Added missing columns where required to align compatible schemas.
- Removed Nepal-level aggregate rows where appropriate for provincial comparisons.
- Prepared dimension tables for fiscal years, provinces, districts, and crops.

### 1. Agriculture_Crop_Production_Yearly

**Source CSV files appended:**

- `01_cereal_crops_yearly.csv`
- `04_major_cash_crops_yearly.csv`
- `06_pulses_yearly.csv`
- `09_major_fruits_yearly.csv`
- `10_fresh_vegetables_yearly.csv`

**Purpose:** Create a consolidated yearly crop dataset for analyzing production, cultivated area, and yield across crop groups.

**Transformations performed:**

- Standardized common crop, area, production, and yield fields.
- Converted pulse yield values from kg/ha to Mt/ha where applicable.
- Renamed `Fruit_Group` to `Crop`.
- Renamed `Productive_Area_Ha` to `Area_Ha` for fruit records.
- Added a crop label for fresh vegetable records.
- Aligned column structures before appending.

### 2. Agriculture_Production_By_Province

**Source CSV files appended:**

- `02_cereal_production_by_province_2024_25.csv`
- `05_major_cash_crops_by_province_2024_25.csv`
- `11_fresh_vegetables_by_province_2024_25.csv`

**Purpose:** Compare provincial crop production for FY 2024/25.

**Transformations performed:**

- Standardized common column names.
- Added missing area and yield fields where required for schema alignment.
- Removed Nepal-level aggregate rows where appropriate.
- Standardized province and crop fields.

### Datasets Kept Separate

The following datasets were retained as separate tables because they represent different analytical subjects or structures:

- `03_cereal_production_by_district_2024_25.csv`
- `07_livestock_population_yearly.csv`
- `08_livestock_products_yearly.csv`
- `12_chemical_fertilizer_sales_yearly.csv`
- `13_agriculture_gdp_commodity_contribution_2024_25.csv`

The district cereal dataset was not appended to the yearly crop production dataset. Livestock population, livestock products, fertilizer sales, and GDP contribution were also kept separate.

---

##  Power BI Data Model

The report uses dimension tables to support filtering and analysis across the relevant datasets.

### Dimension Tables

| Dimension | Purpose |
|---|---|
| `Dim_Fiscal_Year` | Fiscal-year filtering |
| `Dim_Province` | Province-level filtering |
| `Dim_District` | District-level filtering |
| `Dim_Crop` | Crop-level filtering |
| `_Measures` | Organization of DAX measures |

Relationships were configured to support fiscal-year, province, district, and crop filtering where applicable.

The agricultural GDP contribution dataset represents FY 2024/25 and is handled separately from historical time-series analysis.

---

##  DAX Measures

DAX measures were created to calculate KPIs and support the dashboard visuals.

### Total Crop Production

```dax
Total Crop Production (Mt) =
SUM (
    Agriculture_Crop_Production_Yearly[Production_Mt]
)
```

### Total Crop Area

```dax
Total Crop Area (Ha) =
SUM (
    Agriculture_Crop_Production_Yearly[Area_Ha]
)
```

### Average Crop Yield

```dax
Average Crop Yield (Mt/Ha) =
DIVIDE (
    [Total Crop Production (Mt)],
    [Total Crop Area (Ha)]
)
```

This measure calculates total recorded production divided by total recorded area. Its interpretation depends on the consistency of the source data and units.

### Province Production

```dax
Province Production (Mt) =
SUM (
    Agriculture_Production_By_Province[Production_Mt]
)
```

### District Cereal Production

```dax
District Cereal Production (Mt) =
SUM (
    Cereal_Production_by_District[Production_Mt]
)
```

### Total Livestock Population

```dax
Total Livestock Population =
SUM (
    Livestock_Population_Yearly[Population]
)
```

### Total Fertilizer Sales

```dax
Total Fertilizer Sales (Mt) =
SUM (
    Chemical_Fertilizer_Sales_Yearly[Total_Fertilizer_Sales_Mt]
)
```

*Note: The fertilizer measure above assumes the column was renamed to `Total_Fertilizer_Sales_Mt` in Power Query. If the model still uses `Total_ICL_STCL_Mt`, retain that actual column reference instead.*

Additional measures were created for crop area, province yield, district cereal area and yield, livestock products, fertilizer types, GDP contribution, crop counts, province counts, district rankings, and other report KPIs.

---

##  Dashboard Pages & Analytical Questions

###  Home Page

- What is the purpose of the project?
- How can users navigate between the analytical report pages?

### 1. Agriculture Overview

- How has crop production changed over time?
- Which crops have the highest recorded production?
- Which commodities have the highest recorded GDP contribution?
- Which districts lead in cereal production?
- What do the overall crop, livestock, and fertilizer indicators show?

### 2. Crop Production Analysis

- Which crops have the highest production?
- Which crops have the largest recorded cultivated area?
- How do recorded crop yields compare?
- How does crop area relate to production?
- How is recorded production distributed across crops?
- How does production change over time for different crops?

### 3. Provincial & District Analysis

- Which provinces have the highest recorded crop production?
- Which districts lead in cereal production?
- How does cereal production relate to cultivated area across districts?
- Which district has the highest cereal production within each province?

### 4. Livestock Analysis

- How has livestock population changed over time?
- Which livestock categories have the largest recorded populations?
- Which livestock products have the highest recorded values?
- How have livestock product values changed over time?

### 5. Fertilizer & GDP Analysis

- How have fertilizer sales changed over time?
- Which fertilizer type has the highest recorded sales?
- How do fertilizer sales compare by type?
- Which agricultural commodities have the highest recorded GDP contribution?

---

##  Data Limitations

- Data coverage and fiscal-year availability vary across datasets.
- Provincial and district cereal comparisons are limited to FY 2024/25.
- GDP contribution data represents FY 2024/25, not a historical time series.
- Yield calculations depend on consistent units and reliable source area and production values.
- Differences between recorded and calculated yields require careful interpretation.
- Livestock product values should not be interpreted as monetary or physical quantities until their units are confirmed.
- Summed crop areas across different crop groups should not automatically be interpreted as unique agricultural land area.

Original source values are preserved. Questionable values are not silently replaced with invented values.

---

## 🚀 Project Status

-  Source CSV collection and preparation
-  Power Query cleaning and transformation
-  Appending compatible yearly crop datasets
-  Appending compatible provincial datasets
-  Power BI data model and dimension tables
-  DAX measures and KPIs
-  Five analytical dashboard pages
-  Home Page and navigation
-  Final dashboard validation and quality checks

---

## 📁 Repository Structure

```text
Nepal_Agriculture_Analysis/
│
├── csv_source_files/
│   └── 13 source CSV files
│
├── images/
│   └── Dashboard screenshots
│
├── Power BI/
│   ├── Nepal Agriculture Analysis.pbix
│   ├── Nepal Agriculture Analysis.pdf
│   └── README.md
│
└── README.md
```

*This structure is illustrative. Adjust folder names and file paths to match the actual repository.*

---

## 👨‍💻 Author

**Srijan Poudel**

BCA Graduate | Data Analytics & Data Science Enthusiast

**Technologies:** Power BI, Power Query, DAX

---

If you find this project useful, feel free to explore the report and its analytical approach.
