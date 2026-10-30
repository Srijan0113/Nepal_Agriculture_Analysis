SELECT *
FROM fresh_vegetables_yearly
LIMIT 20;

-- Analysis 69: Year-over-year production 

WITH yearly_production AS (
    SELECT
        fiscal_year,
        production_mt
    FROM fresh_vegetables_yearly
    WHERE production_mt IS NOT NULL
),
production_comparison AS (
    SELECT
        fiscal_year,
        production_mt,
        LAG(production_mt) OVER (
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM yearly_production
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