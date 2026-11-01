
-- Nepal Agriculture Analytics
-- Analysis 01: Total crop production

SELECT
    crop,
    SUM(production_mt) AS total_production_mt
FROM cereal_crops_yearly
GROUP BY crop
ORDER BY total_production_mt DESC;


-- Analysis 02: Year-wise cereal production trend

SELECT
    fiscal_year,
    SUM(production_mt) AS total_production_mt
FROM cereal_crops_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 03: Crop-wise production trend

SELECT
    fiscal_year,
    crop,
    production_mt
FROM cereal_crops_yearly
ORDER BY
    crop,
    fiscal_year;

-- Analysis 04: Total cultivated area by crop

SELECT
    crop,
    SUM(area_ha) AS total_area_ha
FROM cereal_crops_yearly
GROUP BY crop
ORDER BY total_area_ha DESC;

-- Analysis 05: Average yield by crop

SELECT
    crop,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM cereal_crops_yearly
GROUP BY crop
ORDER BY avg_yield_mt_per_ha DESC;

-- Analysis 06: Year-wise cultivated area trend

SELECT
    fiscal_year,
    SUM(area_ha) AS total_area_ha
FROM cereal_crops_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 07: Year-wise average cereal crop yield

SELECT
    fiscal_year,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM cereal_crops_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

--  Crop contribution to total cereal production

SELECT
    crop,
    SUM(production_mt) AS total_production_mt,
    ROUND(
        SUM(production_mt) * 100.0 /
        SUM(SUM(production_mt)) OVER (), 2
    ) AS contribution_pct
FROM cereal_crops_yearly
GROUP BY crop
ORDER BY total_production_mt DESC;


--  Highest-producing cereal crop in each fiscal year

WITH yearly_crop_production AS (
    SELECT
        fiscal_year,
        crop,
        SUM(production_mt) AS total_production_mt
    FROM cereal_crops_yearly
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


-- Year-over-year production growth by cereal crop

WITH crop_production AS (
    SELECT
        fiscal_year,
        crop,
        SUM(production_mt) AS production_mt
    FROM cereal_crops_yearly
    GROUP BY fiscal_year, crop
),
production_comparison AS (
    SELECT
        fiscal_year,
        crop,
        production_mt,
        LAG(production_mt) OVER (
            PARTITION BY crop
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM crop_production
)
SELECT
    fiscal_year,
    crop,
    production_mt,
    previous_year_production,
    ROUND(
        (production_mt - previous_year_production) * 100.0 /
        NULLIF(previous_year_production, 0), 2
    ) AS growth_pct
FROM production_comparison
ORDER BY crop, fiscal_year;


-- Identify cereal crops with the highest production growth
-- across the available period

WITH crop_yearly_totals AS (
    SELECT
        fiscal_year,
        crop,
        SUM(production_mt) AS production_mt
    FROM cereal_crops_yearly
    GROUP BY fiscal_year, crop
),
crop_period_summary AS (
    SELECT
        crop,
        FIRST_VALUE(production_mt) OVER (
            PARTITION BY crop
            ORDER BY fiscal_year
        ) AS first_year_production,
        LAST_VALUE(production_mt) OVER (
            PARTITION BY crop
            ORDER BY fiscal_year
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        ) AS latest_year_production
    FROM crop_yearly_totals
)
SELECT DISTINCT
    crop,
    first_year_production,
    latest_year_production,
    ROUND(
        (latest_year_production - first_year_production) * 100.0 /
        NULLIF(first_year_production, 0), 2
    ) AS overall_growth_pct
FROM crop_period_summary
ORDER BY overall_growth_pct DESC;