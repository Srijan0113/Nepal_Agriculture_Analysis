SELECT *
FROM major_fruits_yearly
LIMIT 20;


SELECT DISTINCT fruit_group
FROM major_fruits_yearly
ORDER BY fruit_group;

-- Analysis 53: Total production by fruit group

SELECT
    fruit_group,
    SUM(production_mt) AS total_production_mt
FROM major_fruits_yearly
WHERE fruit_group <> 'Total Fruits'
  AND production_mt IS NOT NULL
GROUP BY fruit_group
ORDER BY total_production_mt DESC;

-- Analysis 54: Year-wise fruit production trend

SELECT
    fiscal_year,
    SUM(production_mt) AS total_production_mt
FROM major_fruits_yearly
WHERE fruit_group <> 'Total Fruits'
  AND production_mt IS NOT NULL
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 55: Total cultivated and productive area by fruit group

SELECT
    fruit_group,
    SUM(total_area_ha) AS total_area_ha,
    SUM(productive_area_ha) AS productive_area_ha
FROM major_fruits_yearly
WHERE fruit_group <> 'Total Fruits'
GROUP BY fruit_group
ORDER BY total_area_ha DESC;


-- Analysis 56: Average yield by fruit group

SELECT
    fruit_group,
    ROUND(AVG(yield_mt_per_ha), 2) AS avg_yield_mt_per_ha
FROM major_fruits_yearly
WHERE fruit_group <> 'Total Fruits'
  AND yield_mt_per_ha IS NOT NULL
GROUP BY fruit_group
ORDER BY avg_yield_mt_per_ha DESC;

-- Analysis 57: Year-wise production by fruit group

SELECT
    fiscal_year,
    fruit_group,
    production_mt
FROM major_fruits_yearly
WHERE fruit_group <> 'Total Fruits'
ORDER BY fruit_group, fiscal_year;

-- Analysis 58: Year-over-year production growth by fruit group

WITH yearly_production AS (
    SELECT
        fiscal_year,
        fruit_group,
        production_mt
    FROM major_fruits_yearly
    WHERE fruit_group <> 'Total Fruits'
      AND production_mt IS NOT NULL
),
production_comparison AS (
    SELECT
        fiscal_year,
        fruit_group,
        production_mt,
        LAG(production_mt) OVER (
            PARTITION BY fruit_group
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM yearly_production
)
SELECT
    fiscal_year,
    fruit_group,
    production_mt,
    previous_year_production,
    ROUND(
        (
            (production_mt - previous_year_production)
            / NULLIF(previous_year_production, 0)
        ) * 100,
        2
    ) AS growth_pct
FROM production_comparison
ORDER BY fruit_group, fiscal_year;

-- Analysis 59: Highest producing fruit group in each year

WITH ranked_fruit_groups AS (
    SELECT
        fiscal_year,
        fruit_group,
        production_mt,
        RANK() OVER (
            PARTITION BY fiscal_year
            ORDER BY production_mt DESC
        ) AS production_rank
    FROM major_fruits_yearly
    WHERE fruit_group <> 'Total Fruits'
      AND production_mt IS NOT NULL
)
SELECT
    fiscal_year,
    fruit_group,
    production_mt
FROM ranked_fruit_groups
WHERE production_rank = 1
ORDER BY fiscal_year;


-- Analysis 60: Productive area percentage by fruit group

SELECT
    fiscal_year,
    fruit_group,
    total_area_ha,
    productive_area_ha,
    ROUND(
        productive_area_ha * 100.0 /
        NULLIF(total_area_ha, 0),
        2
    ) AS productive_area_pct
FROM major_fruits_yearly
WHERE fruit_group <> 'Total Fruits'
  AND total_area_ha > 0
ORDER BY fruit_group, fiscal_year;


-- Analysis 61: Fruit group contribution to total production

WITH fruit_group_totals AS (
    SELECT
        fruit_group,
        SUM(production_mt) AS total_production_mt
    FROM major_fruits_yearly
    WHERE fruit_group <> 'Total Fruits'
      AND production_mt IS NOT NULL
    GROUP BY fruit_group
)
SELECT
    fruit_group,
    total_production_mt,
    ROUND(
        total_production_mt * 100.0 /
        NULLIF(SUM(total_production_mt) OVER (), 0),
        2
    ) AS production_contribution_pct
FROM fruit_group_totals
ORDER BY production_contribution_pct DESC;


-- Analysis 62: Validate official total fruits production against fruit groups

SELECT
    fiscal_year,

    SUM(production_mt) FILTER (
        WHERE fruit_group <> 'Total Fruits'
    ) AS calculated_total_mt,

    MAX(production_mt) FILTER (
        WHERE fruit_group = 'Total Fruits'
    ) AS source_total_mt,

    ROUND(
        SUM(production_mt) FILTER (
            WHERE fruit_group <> 'Total Fruits'
        )
        -
        MAX(production_mt) FILTER (
            WHERE fruit_group = 'Total Fruits'
        ),
        2
    ) AS difference_mt

FROM major_fruits_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;


-- Analysis 63: Validate official total area against fruit groups

SELECT
    fiscal_year,

    SUM(total_area_ha) FILTER (
        WHERE fruit_group <> 'Total Fruits'
    ) AS calculated_total_area_ha,

    MAX(total_area_ha) FILTER (
        WHERE fruit_group = 'Total Fruits'
    ) AS source_total_area_ha,

    SUM(productive_area_ha) FILTER (
        WHERE fruit_group <> 'Total Fruits'
    ) AS calculated_productive_area_ha,

    MAX(productive_area_ha) FILTER (
        WHERE fruit_group = 'Total Fruits'
    ) AS source_productive_area_ha

FROM major_fruits_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;


-- Analysis 64: Validate official total fruits yield

SELECT
    fiscal_year,

    MAX(yield_mt_per_ha) FILTER (
        WHERE fruit_group = 'Total Fruits'
    ) AS source_total_yield,

    ROUND(
        MAX(production_mt) FILTER (
            WHERE fruit_group = 'Total Fruits'
        )
        /
        NULLIF(
            MAX(productive_area_ha) FILTER (
                WHERE fruit_group = 'Total Fruits'
            ),
            0
        ),
        2
    ) AS calculated_total_yield

FROM major_fruits_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;


-- Analysis 65: Official total fruits production trend

SELECT
    fiscal_year,
    total_area_ha,
    productive_area_ha,
    production_mt,
    yield_mt_per_ha
FROM major_fruits_yearly
WHERE fruit_group = 'Total Fruits'
ORDER BY fiscal_year;


-- Analysis 66: Year-over-year total fruits production growth

WITH total_fruit_production AS (
    SELECT
        fiscal_year,
        production_mt
    FROM major_fruits_yearly
    WHERE fruit_group = 'Total Fruits'
      AND production_mt IS NOT NULL
),
production_comparison AS (
    SELECT
        fiscal_year,
        production_mt,
        LAG(production_mt) OVER (
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM total_fruit_production
)
SELECT
    fiscal_year,
    production_mt,
    previous_year_production,
    ROUND(
        (
            (production_mt - previous_year_production)
            / NULLIF(previous_year_production, 0)
        ) * 100,
        2
    ) AS growth_pct
FROM production_comparison
ORDER BY fiscal_year;