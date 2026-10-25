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

