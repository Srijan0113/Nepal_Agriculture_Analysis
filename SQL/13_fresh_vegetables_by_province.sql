-- Inspect fresh vegetables by province

SELECT *
FROM fresh_vegetables_by_province
LIMIT 10;

-- Analysis 70: Total vegetable production by province

SELECT
    province,
    SUM(production_mt) AS total_production_mt
FROM fresh_vegetables_by_province
GROUP BY province
ORDER BY total_production_mt DESC;


-- Analysis 71: Total cultivated area by province

SELECT
    province,
    SUM(area_ha) AS total_area_ha
FROM fresh_vegetables_by_province
GROUP BY province
ORDER BY total_area_ha DESC;


-- Analysis 72: Average yield by province

SELECT
    province,
    ROUND(AVG(yield_mt_per_ha), 2) AS average_yield_mt_per_ha
FROM fresh_vegetables_by_province
WHERE yield_mt_per_ha IS NOT NULL
GROUP BY province
ORDER BY average_yield_mt_per_ha DESC;


-- Analysis 73: Production contribution percentage by province

SELECT
    province,
    production_mt,
    ROUND(
        production_mt * 100.0 /
        NULLIF(SUM(production_mt) OVER (), 0),
        2
    ) AS production_share_pct
FROM fresh_vegetables_by_province
ORDER BY production_mt DESC;


-- Analysis 74: Highest and lowest producing provinces

SELECT
    MAX(production_mt) AS highest_production_mt,
    MIN(production_mt) AS lowest_production_mt,
    MAX(province) FILTER (
        WHERE production_mt = (SELECT MAX(production_mt)
                               FROM fresh_vegetables_by_province)
    ) AS highest_producing_province,
    MAX(province) FILTER (
        WHERE production_mt = (SELECT MIN(production_mt)
                               FROM fresh_vegetables_by_province)
    ) AS lowest_producing_province
FROM fresh_vegetables_by_province;


-- Analysis 75: Rank provinces by vegetable production

SELECT
    province,
    production_mt,
    RANK() OVER (
        ORDER BY production_mt DESC
    ) AS production_rank
FROM fresh_vegetables_by_province;


-- Analysis 76: Compare production, area and yield across provinces

SELECT
    province,
    area_ha,
    production_mt,
    yield_mt_per_ha,
    ROUND(
        production_mt / NULLIF(area_ha, 0),
        2
    ) AS calculated_yield_mt_per_ha
FROM fresh_vegetables_by_province
ORDER BY production_mt DESC;