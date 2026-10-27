-- Analysis 25: Total cash crop production by province

SELECT
    province,
    SUM(production_mt) AS total_production_mt
FROM major_cash_crops_by_province
WHERE province <> 'Nepal'
GROUP BY province
ORDER BY total_production_mt DESC;

-- Analysis 26: Crop-wise cash crop production by province

SELECT
    province,
    crop,
    SUM(production_mt) AS total_production_mt
FROM major_cash_crops_by_province
WHERE province <> 'Nepal'
GROUP BY province, crop
ORDER BY province, total_production_mt DESC;

-- Analysis 27: Highest producing cash crop in each province

WITH crop_production AS (
    SELECT
        province,
        crop,
        SUM(production_mt) AS total_production_mt
    FROM major_cash_crops_by_province
    WHERE province <> 'Nepal'
    GROUP BY province, crop
),
ranked_crops AS (
    SELECT
        province,
        crop,
        total_production_mt,
        RANK() OVER (
            PARTITION BY province
            ORDER BY total_production_mt DESC
        ) AS crop_rank
    FROM crop_production
)
SELECT
    province,
    crop,
    total_production_mt
FROM ranked_crops
WHERE crop_rank = 1
ORDER BY province;

-- Analysis 28: Province-wise share of cash crop production

SELECT
    province,
    SUM(production_mt) AS total_production_mt,
    ROUND(
        SUM(production_mt) * 100.0 /
        NULLIF(SUM(SUM(production_mt)) OVER (), 0),
        2
    ) AS production_share_pct
FROM major_cash_crops_by_province
WHERE province <> 'Nepal'
GROUP BY province
ORDER BY production_share_pct DESC;