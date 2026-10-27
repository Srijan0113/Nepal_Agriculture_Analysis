-- Nepal Agriculture Analytics
-- Analysis 16: Total production by cash crop

SELECT
    crop,
    SUM(production_mt) AS total_production_mt
FROM major_cash_crops_yearly
GROUP BY crop
ORDER BY total_production_mt DESC;

-- Analysis 17: Year-wise cash crop production trend

SELECT
    fiscal_year,
    SUM(production_mt) AS total_production_mt
FROM major_cash_crops_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 18: Total cultivated area by cash crop

SELECT
    crop,
    SUM(area_ha) AS total_area_ha
FROM major_cash_crops_yearly
GROUP BY crop
ORDER BY total_area_ha DESC;

-- Analysis 19: Average yield by cash crop

SELECT
    crop,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM major_cash_crops_yearly
GROUP BY crop
ORDER BY avg_yield_mt_per_ha DESC;

-- Analysis 20: Year-wise cultivated area trend

SELECT
    fiscal_year,
    SUM(area_ha) AS total_area_ha
FROM major_cash_crops_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 21: Year-wise average cash crop yield

SELECT
    fiscal_year,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM major_cash_crops_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 22: Crop-wise production trend

SELECT
    fiscal_year,
    crop,
    production_mt
FROM major_cash_crops_yearly
ORDER BY crop, fiscal_year;

-- Analysis 23: Crop-wise cultivated area trend

SELECT
    fiscal_year,
    crop,
    area_ha
FROM major_cash_crops_yearly
ORDER BY crop, fiscal_year;

-- Analysis 24: Production and area comparison by crop

SELECT
    crop,
    SUM(production_mt) AS total_production_mt,
    SUM(area_ha) AS total_area_ha,
    ROUND(
        SUM(production_mt) / NULLIF(SUM(area_ha), 0),
        2
    ) AS weighted_yield_mt_per_ha
FROM major_cash_crops_yearly
GROUP BY crop
ORDER BY weighted_yield_mt_per_ha DESC;