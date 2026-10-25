
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