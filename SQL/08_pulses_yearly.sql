-- Analysis 29: Total production by pulse crop

SELECT
    crop,
    SUM(production_mt) AS total_production_mt
FROM pulses_yearly
WHERE crop <> 'Total'
  AND production_mt IS NOT NULL
GROUP BY crop
ORDER BY total_production_mt DESC;

-- Analysis 30: Year-wise pulse production trend

SELECT
    fiscal_year,
    SUM(production_mt) AS total_production_mt
FROM pulses_yearly
WHERE crop <> 'Total'
  AND production_mt IS NOT NULL
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 31: Total cultivated area by pulse crop

SELECT
    crop,
    SUM(area_ha) AS total_area_ha
FROM pulses_yearly
WHERE crop <> 'Total'
    And area_ha IS NOT NULL
GROUP BY crop
ORDER BY total_area_ha DESC;

-- Analysis 32: Average calculated yield by pulse crop

SELECT
    crop,
    ROUND(
        AVG(
            production_mt / NULLIF(area_ha, 0) * 1000
        ),
        2
    ) AS avg_yield_kg_per_ha
FROM pulses_yearly
WHERE crop <> 'Total'
  AND area_ha > 0
  AND production_mt IS NOT NULL
GROUP BY crop
ORDER BY avg_yield_kg_per_ha DESC;

-- Analysis 33: Year-wise average calculated yield

SELECT
    fiscal_year,
    ROUND(
        AVG(
            production_mt / NULLIF(area_ha, 0) * 1000
        ),
        2
    ) AS avg_yield_kg_per_ha
FROM pulses_yearly
WHERE crop <> 'Total'
  AND area_ha > 0
  AND production_mt IS NOT NULL
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 34: Crop-wise production trend

SELECT
    fiscal_year,
    crop,
    production_mt
FROM pulses_yearly
WHERE crop <> 'Total'
ORDER BY
    crop,
    fiscal_year;

-- Analysis 35: Crop-wise cultivated area trend

SELECT
    fiscal_year,
    crop,
    area_ha
FROM pulses_yearly
WHERE crop <> 'Total'
ORDER BY
    crop,
    fiscal_year;

-- Analysis 36: Highest producing pulse crop in each year

WITH yearly_crop_production AS (
    SELECT
        fiscal_year,
        crop,
        SUM(production_mt) AS total_production_mt
    FROM pulses_yearly
    Where production_mt IS NOT NULL 
        AND crop <> 'Total'
    GROUP BY fiscal_year, crop
),
ranked_crops AS (
    SELECT
        fiscal_year,
        crop,
        total_production_mt,
        RANK() OVER (
            PARTITION BY fiscal_year
            ORDER BY total_production_mt DESC
        ) AS production_rank
    FROM yearly_crop_production
)
SELECT
    fiscal_year,
    crop,
    total_production_mt
FROM ranked_crops
WHERE production_rank = 1 
ORDER BY fiscal_year;

-- Analysis 37: Year-over-year pulse production growth

WITH yearly_production AS (
    SELECT
        fiscal_year,
        SUM(production_mt) AS total_production_mt
    FROM pulses_yearly
    WHERE crop <> 'Total'
      AND production_mt IS NOT NULL
    GROUP BY fiscal_year
),
production_comparison AS (
    SELECT
        fiscal_year,
        total_production_mt,
        LAG(total_production_mt) OVER (
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM yearly_production
)
SELECT
    fiscal_year,
    total_production_mt,
    previous_year_production,
    ROUND(
        (
            (total_production_mt - previous_year_production)
            / NULLIF(previous_year_production, 0)
        ) * 100,
        2
    ) AS production_growth_pct
FROM production_comparison
ORDER BY fiscal_year;


-- Analysis 38: Crop contribution to total pulse production

WITH crop_production AS (
    SELECT
        crop,
        SUM(production_mt) AS total_production_mt
    FROM pulses_yearly
    WHERE crop <> 'Total'
      AND production_mt IS NOT NULL
    GROUP BY crop
)
SELECT
    crop,
    total_production_mt,
    ROUND(
        total_production_mt * 100.0 /
        NULLIF(SUM(total_production_mt) OVER (), 0),
        2
    ) AS production_contribution_pct
FROM crop_production
ORDER BY production_contribution_pct DESC;


-- Checking the number of rows for each pulse crop in the dataset   
SELECT
    crop,
    COUNT(*) AS total_rows
FROM pulses_yearly
GROUP BY crop
ORDER BY crop;

-- Validate source Total against individual crop production

SELECT
    fiscal_year,
    SUM(production_mt) FILTER (
        WHERE crop <> 'Total'
    ) AS calculated_total_mt,
    MAX(production_mt) FILTER (
        WHERE crop = 'Total'
    ) AS source_total_mt
FROM pulses_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Diagnostic: Inspect pulse yield values across recent years

SELECT
    fiscal_year,
    crop,
    area_ha,
    production_mt,
    yield_kg_per_ha,
    ROUND(
        (production_mt / NULLIF(area_ha, 0)) * 1000,
        2
    ) AS calculated_yield_kg_per_ha
FROM pulses_yearly
WHERE crop <> 'Total'
  AND fiscal_year IN ('2021/22', '2022/23', '2023/24', '2024/25')
ORDER BY fiscal_year, crop;



/* Data Quality Finding — Pulses Yield Inconsistency

The official `06_pulses_yearly.csv` dataset contains inconsistent values in the `yield_kg_per_ha` column. Earlier records contain values around 1,000–1,400, while some records from 2022/23 onward contain values around 1.00–1.31.

A comparison of the reported yield against calculated yield (production in MT divided by cultivated area in hectares, multiplied by 1,000) indicates a likely unit or scaling inconsistency.

Action taken: Original source data were preserved without modification. Calculated yield was used for analytical comparisons to maintain a consistent kg/ha unit.

Formula: Calculated Yield (kg/ha) = (Production (MT) / Cultivated Area (ha)) × 1,000.

*/

