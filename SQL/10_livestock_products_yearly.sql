Select * From livestock_products_yearly
Limit 20;

SELECT DISTINCT product
FROM livestock_products_yearly
ORDER BY product;

-- Inspect product units and available records

SELECT
    product,
    COUNT(*) AS total_records,
    MIN(value) AS minimum_value,
    MAX(value) AS maximum_value
FROM livestock_products_yearly
GROUP BY product
ORDER BY product;


-- Analysis 45: Year-wise milk production

SELECT
    fiscal_year,
    product,
    value AS production_mt
FROM livestock_products_yearly
WHERE product IN (
    'Buff. Milk (Mt.)',
    'Cow Milk (Mt.)',
    'Milk Production (Mt.)'
)
ORDER BY fiscal_year, product;


-- Compare calculated milk production with source total

WITH milk_comparison AS (
    SELECT
        fiscal_year,

        SUM(value) FILTER (
            WHERE product IN ('Buff. Milk (Mt.)', 'Cow Milk (Mt.)')
        ) AS calculated_milk_production_mt,

        MAX(value) FILTER (
            WHERE product = 'Milk Production (Mt.)'
        ) AS source_milk_production_mt

    FROM livestock_products_yearly
    GROUP BY fiscal_year
)
SELECT
    fiscal_year,
    calculated_milk_production_mt,
    source_milk_production_mt,
    calculated_milk_production_mt - source_milk_production_mt
        AS difference_mt
FROM milk_comparison
ORDER BY fiscal_year;

-- Analysis 46: Year-wise meat production

SELECT
    fiscal_year,
    product,
    value AS production_mt
FROM livestock_products_yearly
WHERE product IN (
    'Buff (Mt.)',
    'Chevon (Mt.)',
    'Chicken (Mt.)',
    'Mutton (Sheep) (Mt.)',
    'Pork (Mt.)',
    'Duck (Mt.)',
    'Meat (Net) Production (Mt.)'
)
ORDER BY fiscal_year, product;

-- Compare calculated meat production with source total

WITH meat_comparison AS (
    SELECT
        fiscal_year,

        SUM(value) FILTER (
            WHERE product IN (
                'Buff (Mt.)',
                'Chevon (Mt.)',
                'Chicken (Mt.)',
                'Mutton (Sheep) (Mt.)',
                'Pork (Mt.)',
                'Duck (Mt.)'
            )
        ) AS calculated_meat_production_mt,

        MAX(value) FILTER (
            WHERE product = 'Meat (Net) Production (Mt.)'
        ) AS source_meat_production_mt

    FROM livestock_products_yearly
    GROUP BY fiscal_year
)
SELECT
    fiscal_year,
    calculated_meat_production_mt,
    source_meat_production_mt,
    calculated_meat_production_mt - source_meat_production_mt
        AS difference_mt
FROM meat_comparison
ORDER BY fiscal_year;

-- Analysis 47: Year-wise egg production

SELECT
    fiscal_year,
    product,
    value AS production_thousand
FROM livestock_products_yearly
WHERE product ILIKE '%Duck Egg%'
   OR product ILIKE '%Egg Production%'
   OR product ILIKE '%Hen Egg%'
ORDER BY fiscal_year, product;


--  Compare calculated egg production with source total

WITH egg_comparison AS (
    SELECT
        fiscal_year,

        SUM(value) FILTER (
            WHERE product ILIKE '%Duck Egg%'
               OR product ILIKE '%Hen Egg%'
        ) AS calculated_egg_production_thousand,

        MAX(value) FILTER (
            WHERE product ILIKE '%Egg Production%'
        ) AS source_egg_production_thousand

    FROM livestock_products_yearly
    GROUP BY fiscal_year
)
SELECT
    fiscal_year,
    calculated_egg_production_thousand,
    source_egg_production_thousand,
    calculated_egg_production_thousand -
        source_egg_production_thousand AS difference_thousand
FROM egg_comparison
ORDER BY fiscal_year;


-- Analysis 48: Year-wise fish and wool production

SELECT
    fiscal_year,
    product,
    value,
    CASE
        WHEN product = 'Fish Production (Mt)' THEN 'MT'
        WHEN product = 'Wool Production(Kg.)' THEN 'KG'
    END AS unit
FROM livestock_products_yearly
WHERE product IN (
    'Fish Production (Mt)',
    'Wool Production(Kg.)'
)
ORDER BY product, fiscal_year;

-- Analysis 49: Year-over-year milk production growth

WITH milk_production AS (
    SELECT
        fiscal_year,
        product,
        value AS production_mt
    FROM livestock_products_yearly
    WHERE product = 'Milk Production (Mt.)'
      AND value IS NOT NULL
),
milk_comparison AS (
    SELECT
        fiscal_year,
        product,
        production_mt,
        LAG(production_mt) OVER (
            PARTITION BY product
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM milk_production
)
SELECT
    fiscal_year,
    product,
    production_mt,
    previous_year_production,
    ROUND(
        (
            (production_mt - previous_year_production)
            / NULLIF(previous_year_production, 0)
        ) * 100,
        2
    ) AS growth_pct
FROM milk_comparison
ORDER BY product, fiscal_year;

-- Analysis 50: Year-over-year meat production growth

WITH meat_production AS (
    SELECT
        fiscal_year,
        product,
        value AS production_mt
    FROM livestock_products_yearly
    WHERE product ='Meat (Net) Production (Mt.)'
      AND value IS NOT NULL
),
meat_comparison AS (
    SELECT
        fiscal_year,
        product,
        production_mt,
        LAG(production_mt) OVER (
            PARTITION BY product
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM meat_production
)
SELECT
    fiscal_year,
    product,
    production_mt,
    previous_year_production,
    ROUND(
        (
            (production_mt - previous_year_production)
            / NULLIF(previous_year_production, 0)
        ) * 100,
        2
    ) AS growth_pct
FROM meat_comparison
ORDER BY product, fiscal_year;

-- Analysis 51: Year-over-year egg production growth

WITH egg_production AS (
    SELECT
        fiscal_year,
        product,
        value AS production_thousand
    FROM livestock_products_yearly
    WHERE product ILIKE '%Egg Production%'
   
      AND value IS NOT NULL
),
egg_comparison AS (
    SELECT
        fiscal_year,
        product,
        production_thousand,
        LAG(production_thousand) OVER (
            PARTITION BY product
            ORDER BY fiscal_year
        ) AS previous_year_production
    FROM egg_production
)
SELECT
    fiscal_year,
    product,
    production_thousand,
    previous_year_production,
    ROUND(
        (
            (production_thousand - previous_year_production)
            / NULLIF(previous_year_production, 0)
        ) * 100,
        2
    ) AS growth_pct
FROM egg_comparison
ORDER BY product, fiscal_year;

-- Analysis 52: Highest milk-producing category in each year

WITH milk_categories AS (
    SELECT
        fiscal_year,
        product,
        value AS production_mt
    FROM livestock_products_yearly
    WHERE product IN (
        'Buff. Milk (Mt.)',
        'Cow Milk (Mt.)'
    )
      AND value IS NOT NULL
),
ranked_milk AS (
    SELECT
        fiscal_year,
        product,
        production_mt,
        RANK() OVER (
            PARTITION BY fiscal_year
            ORDER BY production_mt DESC
        ) AS production_rank
    FROM milk_categories
)
SELECT
    fiscal_year,
    product,
    production_mt
FROM ranked_milk
WHERE production_rank = 1
ORDER BY fiscal_year;