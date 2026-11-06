# Nepal Agriculture Analytics — Python Analysis

This folder contains the **Python-based data analysis and exploratory analysis** for the Nepal Agriculture Analytics project.

The analysis uses official Nepal agriculture datasets to explore agricultural production, livestock, fertilizer use, agricultural GDP contribution, and geographical differences across provinces and districts.

The Python analysis complements the project's **SQL analysis and Power BI dashboard** by providing programmatic data exploration, statistical analysis, validation, and visual insights.

---

##  Objectives

The Python analysis focuses on:

- Exploring and understanding the structure of agricultural datasets
- Cleaning and validating data before analysis
- Analyzing agricultural production trends
- Examining livestock production
- Analyzing fertilizer sales and composition
- Exploring agricultural GDP commodity contributions
- Comparing agricultural production across provinces
- Identifying major agricultural production districts
- Comparing production with productivity/yield
- Generating meaningful visualizations and insights

The analysis intentionally focuses on **major, decision-relevant analyses** rather than producing large numbers of repetitive charts.

---

##  Tools & Libraries

The analysis was performed using:

- **Python**
- **Pandas** — data manipulation, cleaning, aggregation, and analysis
- **NumPy** — numerical operations
- **Matplotlib** — data visualization
- **Seaborn** — statistical and categorical visualization
- **Jupyter Notebook** — interactive analysis environment

---

## 📂 Analysis Notebooks

### 1. Crop Production Analysis

This notebook focuses on agricultural crop production data and examines production patterns across available years and crop categories.

### Main analysis areas

- Crop production overview
- Production by crop
- Production trends across fiscal years
- Major crop comparisons
- Production growth/comparison
- Data quality checks
- Visual analysis of crop production patterns

The analysis helps establish the overall picture of Nepal's crop production before moving into more detailed geographical analysis.

---

### 2. Livestock Analysis

This notebook analyzes Nepal's livestock production datasets.

### Main analysis areas

- Livestock product production
- Milk production
- Meat production
- Egg production
- Production comparisons across years
- Comparison between calculated totals and reported totals where applicable
- Year-over-year changes
- Production trends

The analysis helps identify major livestock products and understand how livestock production has changed over time.

---

### 3. Fertilizer & Agricultural GDP Analysis

This notebook combines analysis of fertilizer sales with agricultural GDP commodity contribution data.

### Fertilizer analysis

The fertilizer dataset covers fiscal years from **2010/11 to 2024/25**.

Key analyses include:

- Total fertilizer sales by fiscal year
- Urea, DAP, and Potash sales
- Fertilizer-type contribution
- Year-over-year growth
- Long-term fertilizer sales trends
- Comparison of calculated totals with reported totals
- Identification of unusual/inconsistent reported values

The analysis found that **Urea represents the largest share of total fertilizer sales** across the analyzed period.

### Agricultural GDP analysis

The GDP dataset contains commodity-level contribution to agriculture GDP.

Key analyses include:

- Commodity contribution to agricultural GDP
- Ranking of commodities
- Major contributors to agriculture GDP
- Distribution of commodity contribution values
- Data quality checks

The analysis identifies commodities such as **vegetables, rice paddy, maize, potatoes, and wheat** among the major contributors in the available dataset.

---

### 4. Province & District Analysis

This notebook focuses on the geographical distribution of agricultural production using **2024/25** province- and district-level datasets.

### Province-level datasets

- Province cereal production
- Major cash crops by province
- Fresh vegetables by province

### District-level dataset

- District cereal production

### Main analysis areas

#### Cereal Production

- Total cereal production by province
- Province contribution to total cereal production
- Dominant cereal crop in each province
- Dominant crop contribution within each province

#### Major Cash Crops

- Total cash-crop production by province
- Province contribution to total cash-crop production
- Dominant cash crop in each province
- Dominant crop contribution
- Yield comparison across provinces and crops

#### Fresh Vegetables

- Total vegetable production by province
- Province contribution to total vegetable production
- Cultivated area vs production
- Vegetable yield by province

#### District Cereals

- Top 10 districts by cereal production
- Province contribution from district-level records
- Top 10 districts by cereal yield

---

##  Key Insights from the Province & District Analysis

### Cereal Production

- **Koshi** recorded the highest province-level cereal production, contributing **24.66%** of the total.
- **Lumbini** and **Madhesh** were also major cereal-producing provinces.
- Paddy was the dominant cereal in several major production provinces, while maize was dominant in Bagmati, Gandaki, and Karnali.
- At district level, **Jhapa** recorded the highest cereal production, followed by **Morang** and **Kailali**.

### Cash Crops

- **Madhesh** was the largest contributor to province-level cash-crop production at **34.74%**.
- **Koshi** was the second-largest contributor.
- Potato was the dominant cash crop in several provinces, while sugarcane dominated in Madhesh and Sudurpashchim.
- Yield comparisons were performed separately by crop because different crops have different yield scales.

### Fresh Vegetables

- **Madhesh** recorded the largest share of fresh vegetable production at **30.31%**.
- **Bagmati** recorded the highest vegetable yield at **16.69 MT/Ha**.
- The analysis also compared cultivated area with production to distinguish production scale from productivity.

### District Productivity

- **Jhapa** recorded the highest cereal yield at **5.87 MT/Ha**.
- High production and high yield were not always the same, demonstrating the difference between **production scale and productivity**.

---

##  Data Cleaning & Validation

Data quality checks were performed before the major analyses.

The checks included:

- Missing values
- Duplicate records
- Data types
- Unique values
- Province naming consistency
- Subtotal/total records
- Calculated totals vs reported totals where applicable

### Geographic Data Cleaning

For province-level comparisons:

- National-level `Nepal` records were excluded.
- Province names were standardized where inconsistent.

For district-level analysis:

- Province subtotal records were removed.
- Only records identified as district-level observations were retained.

### Missing Values

Missing values were not automatically replaced with zero or estimated values.

For example, the province cereal dataset contains a missing production value for:

- Province: **Madhesh**
- Crop: **Buckwheat**
- Fiscal Year: **2024/25**

This value was retained as missing to avoid introducing an unsupported estimate.

---

## 📈 Visualization Approach

The notebooks use visualizations to support the analytical results.

Common visualization types include:

- Bar charts
- Horizontal ranking charts
- Trend charts
- Contribution percentage charts
- Scatter plots
- Comparative categorical charts

The visualizations are used to answer specific analytical questions rather than simply display every available variable.

---

## 🔄 General Analysis Workflow

```text
Official Agriculture Data
        ↓
Load Data with Pandas
        ↓
Inspect Structure & Data Types
        ↓
Check Missing Values & Duplicates
        ↓
Validate Data
        ↓
Clean / Standardize Data
        ↓
Exploratory Analysis
        ↓
Aggregation & Calculations
        ↓
Statistical / Comparative Analysis
        ↓
Visualization
        ↓
Major Findings & Limitations
```

---

## 📁 Data Source

The Python notebooks use datasets stored in the project's:

```text
../csv_source_files
```

directory.

The analysis preserves the original source data and performs cleaning and transformations within the analysis workflow rather than modifying the original CSV files.

---

##  Important Limitations

- Several analyses are based on different datasets with different time periods and geographic coverage.
- Province and district datasets are not identical in structure.
- The province and district geographical analysis primarily represents **2024/25**.
- Missing values are retained where the official source does not provide a value.
- Calculated totals may differ from reported totals where source data contains inconsistencies.
- Yield comparisons across different crops should be interpreted carefully because crops have different agronomic characteristics.
- The district cereal dataset used in the province/district notebook does not contain a crop-level column, so district analysis is limited to overall cereal production and yield.

---

##  Role in the Overall Project

The Python analysis is one component of the larger **Nepal Agriculture Analytics** project.

```text
                 Nepal Agriculture Analytics
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
      Python             SQL             Power BI
        │                 │                 │
    EDA & Stats      Data Analysis      Dashboard
        │                 │                 │
        └─────────────────┼─────────────────┘
                          │
                  Agricultural Insights
```

### Python

Used for:

- Exploratory Data Analysis
- Statistical calculations
- Data validation
- Programmatic aggregation
- Trend analysis
- Visualization
- Finding patterns and anomalies

### SQL

Used for:

- Structured querying
- Aggregation
- Filtering
- CTEs
- Window functions
- Comparative analysis
- Database-based analytical workflows

### Power BI

Used for:

- Interactive dashboards
- KPI reporting
- Geographic and category-level analysis
- Slicers and filters
- Business-oriented visualization
- Communicating final insights

---

##  Key Takeaway

The Python analysis provides a deeper analytical layer for the Nepal Agriculture Analytics project, moving from **raw official agricultural data → cleaned datasets → statistical analysis → visual exploration → actionable agricultural insights**.

The analysis demonstrates practical use of **Pandas, NumPy, Matplotlib, Seaborn, and Jupyter Notebook** for real-world agricultural data analysis.