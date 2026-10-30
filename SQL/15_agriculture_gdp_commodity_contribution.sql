-- Change column name for clarity
ALTER TABLE agriculture_gdp_commodity_contribution
RENAME COLUMN percentage_contribution_to_agriculture_gdp TO contribution_pct;


-- Inspect agriculture GDP commodity contribution

SELECT *
FROM agriculture_gdp_commodity_contribution
--LIMIT 20;

-- Check distinct commodities

SELECT DISTINCT commodity
FROM agriculture_gdp_commodity_contribution
ORDER BY commodity;

-- Check commodity record counts

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT commodity) AS unique_commodities
FROM agriculture_gdp_commodity_contribution;



-- Identify exact duplicate records

SELECT
    commodity,
    contribution_pct,
    COUNT(*) AS duplicate_count
FROM agriculture_gdp_commodity_contribution
GROUP BY commodity, contribution_pct
HAVING COUNT(*) > 1;

-- Identify commodities ending with 'Total'

SELECT
    commodity,
    contribution_pct
FROM agriculture_gdp_commodity_contribution
WHERE TRIM(commodity) ILIKE '%total%'
ORDER BY contribution_pct DESC;


-- Create a deduplicated analytical view

CREATE OR REPLACE VIEW agriculture_gdp_commodity_clean AS
SELECT DISTINCT
    commodity,
    contribution_pct
FROM agriculture_gdp_commodity_contribution
WHERE contribution_pct > 0.0
 AND TRIM(commodity) NOT IN (
      'AGRICULTURE TOTAL WITH FORESTRY',
      'CROPS TOTAL',
      'LIVESTOCK TOTAL'
  );

Select sum(contribution_pct) as total_contribution
FROM agriculture_gdp_commodity_clean;

-- Analysis 86: Inspect cleaned commodity contribution data

SELECT *
FROM agriculture_gdp_commodity_clean
ORDER BY contribution_pct DESC;


-- Analysis 87: Total contribution by all individual commodities

SELECT
    COUNT(*) AS total_commodities,
    ROUND(SUM(contribution_pct), 2) AS total_contribution_pct
FROM agriculture_gdp_commodity_clean;


-- Analysis 88: Rank commodities by contribution percentage

SELECT
    commodity,
    contribution_pct,
    RANK() OVER (
        ORDER BY contribution_pct DESC
    ) AS contribution_rank
FROM agriculture_gdp_commodity_clean
ORDER BY contribution_rank;


-- Analysis 89: Top 10 commodities by contribution

SELECT
    commodity,
    contribution_pct
FROM agriculture_gdp_commodity_clean
ORDER BY contribution_pct DESC
LIMIT 10;


-- Analysis 90: Bottom 10 commodities by contribution

SELECT
    commodity,
    contribution_pct
FROM agriculture_gdp_commodity_clean
ORDER BY contribution_pct ASC
LIMIT 10;


-- Analysis 91: Overall contribution statistics

SELECT
    COUNT(*) AS total_commodities,
    ROUND(AVG(contribution_pct), 2) AS average_contribution_pct,
    ROUND(MAX(contribution_pct), 2) AS highest_contribution_pct,
    ROUND(MIN(contribution_pct), 2) AS lowest_contribution_pct,
    ROUND(STDDEV(contribution_pct), 2) AS contribution_stddev
FROM agriculture_gdp_commodity_clean;
