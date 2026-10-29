SELECT *
FROM livestock_population_yearly
LIMIT 10;

SELECT DISTINCT category
FROM livestock_population_yearly
ORDER BY category;


-- Analysis 39: Total livestock population by category

SELECT
    category,
    SUM(population) AS total_population
FROM livestock_population_yearly
GROUP BY category
ORDER BY total_population DESC;

-- Analysis 40: Year-wise total livestock population trend

SELECT
    fiscal_year,
    SUM(population) AS total_population
FROM livestock_population_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 41: Livestock population by year and category

SELECT
    fiscal_year,
    category,
    population
FROM livestock_population_yearly
ORDER BY category, fiscal_year;

-- Analysis 42: Highest livestock population category in each year

WITH yearly_livestock AS (
    SELECT
        fiscal_year,
        category,
        SUM(population) AS total_population
    FROM livestock_population_yearly
    GROUP BY fiscal_year, category
),
ranked_livestock AS (
    SELECT
        fiscal_year,
        category,
        total_population,
        RANK() OVER (
            PARTITION BY fiscal_year
            ORDER BY total_population DESC
        ) AS population_rank
    FROM yearly_livestock
)
SELECT
    fiscal_year,
    category,
    total_population
FROM ranked_livestock
WHERE population_rank = 1
ORDER BY fiscal_year;

-- Analysis 43: Year-over-year livestock population growth

WITH yearly_population AS (
    SELECT
        fiscal_year,
        SUM(population) AS total_population
    FROM livestock_population_yearly
    GROUP BY fiscal_year
),
population_comparison AS (
    SELECT
        fiscal_year,
        total_population,
        LAG(total_population) OVER (
            ORDER BY fiscal_year
        ) AS previous_year_population
    FROM yearly_population
)
SELECT
    fiscal_year,
    total_population,
    previous_year_population,
    ROUND(
        (
            (total_population - previous_year_population)
            / NULLIF(previous_year_population, 0)
        ) * 100,
        2
    ) AS population_growth_pct
FROM population_comparison
ORDER BY fiscal_year;

-- Analysis 44: Livestock category contribution to total population

WITH livestock_totals AS (
    SELECT
        category AS Livestock_Category,
        SUM(population) AS total_population
    FROM livestock_population_yearly
    GROUP BY category
)
SELECT
    Livestock_Category,
    total_population,
    ROUND(
        total_population * 100.0 /
        NULLIF(SUM(total_population) OVER (), 0),
        2
    ) AS population_contribution_pct
FROM livestock_totals
ORDER BY population_contribution_pct DESC;