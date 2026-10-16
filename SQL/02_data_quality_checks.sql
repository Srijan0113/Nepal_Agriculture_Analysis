
-- Check missing values in cereal production data

SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (
        WHERE fiscal_year IS NULL
    ) AS missing_fiscal_year,
    COUNT(*) FILTER (
        WHERE crop IS NULL
    ) AS missing_crop,
    COUNT(*) FILTER (
        WHERE area_ha IS NULL
    ) AS missing_area,
    COUNT(*) FILTER (
        WHERE production_mt IS NULL
    ) AS missing_production,
    COUNT(*) FILTER (
        WHERE yield_mt_per_ha IS NULL
    ) AS missing_yield
FROM cereal_crops_yearly;


-- Check duplicate cereal production records

SELECT
    fiscal_year,
    crop,
    COUNT(*) AS duplicate_count
FROM cereal_crops_yearly
GROUP BY
    fiscal_year,
    crop
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- Check zero and negative values in cereal production

SELECT
    COUNT(*) FILTER (WHERE area_ha < 0) AS negative_area,
    COUNT(*) FILTER (WHERE production_mt < 0) AS negative_production,
    COUNT(*) FILTER (WHERE yield_mt_per_ha < 0) AS negative_yield,
    COUNT(*) FILTER (WHERE area_ha = 0) AS zero_area,
    COUNT(*) FILTER (WHERE production_mt = 0) AS zero_production
FROM cereal_crops_yearly;


-- Nepal Agriculture Analytics
-- Consolidated data quality checks
-- Checks every table in the public schema

DROP TABLE IF EXISTS dq_summary;

CREATE TEMP TABLE dq_summary (
    table_name TEXT,
    total_rows BIGINT,
    rows_with_nulls BIGINT,
    duplicate_rows BIGINT,
    rows_with_negative_numbers BIGINT
);

DO $$
DECLARE
    t RECORD;
BEGIN
    FOR t IN
        SELECT tablename
        FROM pg_tables
        WHERE schemaname = 'public'
        ORDER BY tablename
    LOOP
        EXECUTE format(
            $query$
            INSERT INTO dq_summary
            SELECT
                %L,
                COUNT(*),
                COUNT(*) FILTER (
                    WHERE EXISTS (
                        SELECT 1
                        FROM jsonb_each(to_jsonb(x)) AS e
                        WHERE e.value = 'null'::jsonb
                    )
                ),
                COUNT(*) - COUNT(DISTINCT to_jsonb(x)),
                COUNT(*) FILTER (
                    WHERE EXISTS (
                        SELECT 1
                        FROM jsonb_each(to_jsonb(x)) AS e
                        WHERE jsonb_typeof(e.value) = 'number'
                          AND (e.value #>> '{}')::numeric < 0
                    )
                )
            FROM public.%I AS x
            $query$,
            t.tablename,
            t.tablename
        );
    END LOOP;
END $$;

SELECT *
FROM dq_summary
ORDER BY table_name;


-- Inspect missing values in province-level cereal production
SELECT *
FROM cereal_production_by_province
WHERE fiscal_year IS NULL
   OR province IS NULL
   OR crop IS NULL
   OR production_mt IS NULL;

-- Inspect missing values in livestock products
SELECT *
FROM livestock_products_yearly
WHERE fiscal_year IS NULL
   OR product IS NULL
   OR value IS NULL;

-- Inspect missing values in pulses
SELECT *
FROM pulses_yearly
WHERE fiscal_year IS NULL
   OR crop IS NULL
   OR area_ha IS NULL
   OR production_mt IS NULL
   OR yield_kg_per_ha IS NULL;

-- Identify exact duplicate GDP records
SELECT
    commodity,
    percentage_contribution_to_agriculture_gdp,
    COUNT(*) AS occurrences
FROM agriculture_gdp_commodity_contribution
GROUP BY
    commodity,
    percentage_contribution_to_agriculture_gdp
HAVING COUNT(*) > 1;



-- Final Data Quality Summary
-- Nepal Agriculture Analytics

SELECT
    'cereal_production_by_province' AS table_name,
    'Missing production_mt' AS issue,
    COUNT(*) AS affected_rows
FROM cereal_production_by_province
WHERE production_mt IS NULL

UNION ALL

SELECT
    'livestock_products_yearly',
    'Missing value',
    COUNT(*)
FROM livestock_products_yearly
WHERE value IS NULL

UNION ALL

SELECT
    'pulses_yearly',
    'Missing area, production or yield',
    COUNT(*)
FROM pulses_yearly
WHERE area_ha IS NULL
   OR production_mt IS NULL
   OR yield_kg_per_ha IS NULL

UNION ALL

SELECT
    'agriculture_gdp_commodity_contribution',
    'Exact duplicate records beyond first occurrence',
    COALESCE(SUM(occurrences - 1), 0)::BIGINT
FROM (
    SELECT COUNT(*) AS occurrences
    FROM agriculture_gdp_commodity_contribution
    GROUP BY commodity, percentage_contribution_to_agriculture_gdp
    HAVING COUNT(*) > 1
) AS duplicates;
