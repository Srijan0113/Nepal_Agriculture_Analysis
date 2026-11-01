-- Analysis 08: Province-wise cereal production

SELECT
    province,
    SUM(production_mt) AS total_production_mt
FROM cereal_production_by_province
WHERE province <> 'Nepal'
GROUP BY province
ORDER BY total_production_mt DESC;

-- Analysis 09: Province-wise and Crop-wise production by province

SELECT
    province,
    crop,
    SUM(production_mt) AS total_production_mt
FROM cereal_production_by_province
WHERE province <> 'Nepal'
GROUP BY
   crop,
   province
    
 ORDER BY
    province,
    total_production_mt DESC;


-- Province wise highest production crop
With province_crop_production AS (
    Select
        province,
        crop,
        Sum(production_mt) AS total_production_mt
        FROM cereal_production_by_province
    WHERE province <> 'Nepal'
    GROUP BY province,crop
    order by total_production_mt desc
),

ranked_production AS(SELECT
    province,
    crop,
    RANK() Over(PARTITION BY province ORDER BY total_Production_mt DESC) As production_rank
    From province_crop_production)

Select province, crop From ranked_Production
Where production_rank = 1
order by province;


