-- Analysis 10: Inspect district dataset row types

SELECT
    row_type,
    COUNT(*) AS total_rows
FROM cereal_production_by_district
where province <> 'NEPAL'
GROUP BY row_type
ORDER BY row_type;

-- Analysis 11: Total cereal production by district

SELECT
    district,
    SUM(production_mt) AS total_production_mt
FROM cereal_production_by_district
WHERE row_type = 'District'
GROUP BY district
ORDER BY total_production_mt DESC;

-- Analysis 12: Cultivated area by district

SELECT
    district,
    SUM(area_ha) AS total_area_ha
FROM cereal_production_by_district
WHERE row_type = 'District'
GROUP BY district
ORDER BY total_area_ha DESC;

-- Analysis 13: Average cereal yield by district

SELECT
    district,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM cereal_production_by_district
WHERE row_type = 'District'
GROUP BY district
ORDER BY avg_yield_mt_per_ha DESC;

-- Analysis 14: District production comparison within provinces

SELECT
    province,
    district,
    SUM(production_mt) AS total_production_mt
FROM cereal_production_by_district
WHERE row_type = 'District'
GROUP BY
    province,
    district
ORDER BY
    province,
    total_production_mt DESC;


-- Analysis 15: District-wise cereal yield by province

SELECT
    province,
    district,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM cereal_production_by_district
WHERE row_type = 'District'
GROUP BY
    province,
    district
ORDER BY
    province,
    avg_yield_mt_per_ha DESC;
    