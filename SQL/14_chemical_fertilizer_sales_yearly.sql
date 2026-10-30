-- Inspect chemical fertilizer sales data

SELECT *
FROM chemical_fertilizer_sales_yearly;

-- Check records by fiscal year

SELECT
    fiscal_year,
    COUNT(*) AS total_records
FROM chemical_fertilizer_sales_yearly
GROUP BY fiscal_year
ORDER BY fiscal_year;

-- Analysis 77: Total sales by fertilizer type

SELECT
    SUM(urea_mt) AS total_urea_mt,
    SUM(dap_mt) AS total_dap_mt,
    SUM(potash_mt) AS total_potash_mt
FROM chemical_fertilizer_sales_yearly;


-- Analysis 78: Total fertilizer sales by fiscal year

SELECT
    fiscal_year,
    urea_mt,
    dap_mt,
    potash_mt,
    (urea_mt + dap_mt + potash_mt) AS total_fertilizer_mt
FROM chemical_fertilizer_sales_yearly
ORDER BY fiscal_year;


-- Analysis 79: Year-wise fertilizer sales trend by type

SELECT
    fiscal_year,
    urea_mt,
    dap_mt,
    potash_mt
FROM chemical_fertilizer_sales_yearly
ORDER BY fiscal_year;


-- Analysis 80: Year-over-year total fertilizer sales growth

WITH yearly_sales AS (
    SELECT
        fiscal_year,
        (urea_mt + dap_mt + potash_mt) AS total_fertilizer_mt
    FROM chemical_fertilizer_sales_yearly
),
sales_comparison AS (
    SELECT
        fiscal_year,
        total_fertilizer_mt,
        LAG(total_fertilizer_mt) OVER (
            ORDER BY fiscal_year
        ) AS previous_year_sales
    FROM yearly_sales
)
SELECT
    fiscal_year,
    total_fertilizer_mt,
    previous_year_sales,
    ROUND(
        (total_fertilizer_mt - previous_year_sales) * 100.0
        / NULLIF(previous_year_sales, 0),
        2
    ) AS growth_pct
FROM sales_comparison
ORDER BY fiscal_year;


-- Analysis 81: Year-over-year growth by fertilizer type

WITH fertilizer_growth AS (
    SELECT
        fiscal_year,
        urea_mt,
        dap_mt,
        potash_mt,
        LAG(urea_mt) OVER (ORDER BY fiscal_year) AS previous_urea,
        LAG(dap_mt) OVER (ORDER BY fiscal_year) AS previous_dap,
        LAG(potash_mt) OVER (ORDER BY fiscal_year) AS previous_potash
    FROM chemical_fertilizer_sales_yearly
)
SELECT
    fiscal_year,
    ROUND(
        (urea_mt - previous_urea) * 100.0
        / NULLIF(previous_urea, 0), 2
    ) AS urea_growth_pct,
    ROUND(
        (dap_mt - previous_dap) * 100.0
        / NULLIF(previous_dap, 0), 2
    ) AS dap_growth_pct,
    ROUND(
        (potash_mt - previous_potash) * 100.0
        / NULLIF(previous_potash, 0), 2
    ) AS potash_growth_pct
FROM fertilizer_growth
ORDER BY fiscal_year;


-- Analysis 82: Fertilizer contribution to total sales

WITH fertilizer_totals AS (
    SELECT
        SUM(urea_mt) AS total_urea,
        SUM(dap_mt) AS total_dap,
        SUM(potash_mt) AS total_potash
    FROM chemical_fertilizer_sales_yearly
),
all_fertilizer AS (
    SELECT 'Urea' AS fertilizer, total_urea AS sales_mt
    FROM fertilizer_totals

    UNION ALL

    SELECT 'DAP', total_dap
    FROM fertilizer_totals

    UNION ALL

    SELECT 'Potash', total_potash
    FROM fertilizer_totals
)
SELECT
    fertilizer,
    sales_mt,
    ROUND(
        sales_mt * 100.0 / NULLIF(SUM(sales_mt) OVER (), 0),
        2
    ) AS contribution_pct
FROM all_fertilizer
ORDER BY sales_mt DESC;


-- Analysis 83: Highest and lowest total fertilizer sales years

WITH yearly_sales AS (
    SELECT
        fiscal_year,
        (urea_mt + dap_mt + potash_mt) AS total_fertilizer_mt
    FROM chemical_fertilizer_sales_yearly
)
SELECT
    MAX(total_fertilizer_mt) AS highest_sales_mt,
    MIN(total_fertilizer_mt) AS lowest_sales_mt,
    MAX(fiscal_year) FILTER (
        WHERE total_fertilizer_mt = (
            SELECT MAX(total_fertilizer_mt) FROM yearly_sales
        )
    ) AS highest_sales_year,
    MAX(fiscal_year) FILTER (
        WHERE total_fertilizer_mt = (
            SELECT MIN(total_fertilizer_mt) FROM yearly_sales
        )
    ) AS lowest_sales_year
FROM yearly_sales;


-- Analysis 84: Rank fiscal years by total fertilizer sales

SELECT
    fiscal_year,
    (urea_mt + dap_mt + potash_mt) AS total_fertilizer_mt,
    RANK() OVER (
        ORDER BY (urea_mt + dap_mt + potash_mt) DESC
    ) AS sales_rank
FROM chemical_fertilizer_sales_yearly
ORDER BY sales_rank;


-- Analysis 85: Compare fertilizer sales composition by year

SELECT
    fiscal_year,
    ROUND(
        urea_mt * 100.0 /
        NULLIF(urea_mt + dap_mt + potash_mt, 0), 2
    ) AS urea_share_pct,
    ROUND(
        dap_mt * 100.0 /
        NULLIF(urea_mt + dap_mt + potash_mt, 0), 2
    ) AS dap_share_pct,
    ROUND(
        potash_mt * 100.0 /
        NULLIF(urea_mt + dap_mt + potash_mt, 0), 2
    ) AS potash_share_pct
FROM chemical_fertilizer_sales_yearly
ORDER BY fiscal_year;