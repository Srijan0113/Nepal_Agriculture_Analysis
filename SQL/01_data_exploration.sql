
-- Project: Nepal Agriculture Analytics
-- Database: nepal_agriculture_analytics
-- Purpose: Initial database and source-data inspection

-- 1. Confirm the active database and user
SELECT
    current_database() AS database_name,
    current_user AS connected_user;

-- 2. List tables available in the public schema
SELECT
    table_name
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;


-- Create table for historical cereal crop production

CREATE TABLE IF NOT EXISTS cereal_crops_yearly (
    fiscal_year VARCHAR(7),
    crop VARCHAR(100),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC
);


SELECT COUNT(*) AS total_rows
FROM cereal_crops_yearly;

SELECT *
FROM cereal_crops_yearly
LIMIT 5;


-- 02. Cereal production by province
CREATE TABLE IF NOT EXISTS cereal_production_by_province (
    fiscal_year VARCHAR(7),
    province VARCHAR(100),
    crop VARCHAR(100),
    production_mt NUMERIC
);

-- 03. Cereal production by district
CREATE TABLE IF NOT EXISTS cereal_production_by_district (
    fiscal_year VARCHAR(7),
    province VARCHAR(100),
    district VARCHAR(100),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC,
    row_type VARCHAR(50)
);

-- 04. Major cash crops yearly
CREATE TABLE IF NOT EXISTS major_cash_crops_yearly (
    fiscal_year VARCHAR(7),
    crop VARCHAR(100),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC
);

-- 05. Major cash crops by province
CREATE TABLE IF NOT EXISTS major_cash_crops_by_province (
    fiscal_year VARCHAR(7),
    province VARCHAR(100),
    crop VARCHAR(100),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC
);

-- 06. Pulses yearly
CREATE TABLE IF NOT EXISTS pulses_yearly (
    fiscal_year VARCHAR(7),
    crop VARCHAR(100),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_kg_per_ha NUMERIC
);

-- 07. Livestock population yearly
CREATE TABLE IF NOT EXISTS livestock_population_yearly (
    fiscal_year VARCHAR(7),
    category VARCHAR(100),
    population NUMERIC
);

-- 08. Livestock products yearly
CREATE TABLE IF NOT EXISTS livestock_products_yearly (
    fiscal_year VARCHAR(7),
    product VARCHAR(150),
    value NUMERIC
);

-- 09. Major fruits yearly
CREATE TABLE IF NOT EXISTS major_fruits_yearly (
    fruit_group VARCHAR(100),
    fiscal_year VARCHAR(7),
    total_area_ha NUMERIC,
    productive_area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC
);

-- 10. Fresh vegetables yearly
CREATE TABLE IF NOT EXISTS fresh_vegetables_yearly (
    fiscal_year VARCHAR(7),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC
);

-- 11. Fresh vegetables by province
CREATE TABLE IF NOT EXISTS fresh_vegetables_by_province (
    fiscal_year VARCHAR(7),
    province VARCHAR(100),
    area_ha NUMERIC,
    production_mt NUMERIC,
    yield_mt_per_ha NUMERIC
);

-- 12. Chemical fertilizer sales yearly
CREATE TABLE IF NOT EXISTS chemical_fertilizer_sales_yearly (
    fiscal_year VARCHAR(7),
    urea_mt NUMERIC,
    dap_mt NUMERIC,
    potash_mt NUMERIC,
    total_icl_stcl_mt NUMERIC
);

-- 13. Agriculture GDP commodity contribution
CREATE TABLE IF NOT EXISTS agriculture_gdp_commodity_contribution (
    commodity VARCHAR(200),
    percentage_contribution_to_agriculture_gdp NUMERIC
);


SELECT
    table_name,
    (xpath(
        '/row/count/text()',
        query_to_xml(
            format('SELECT COUNT(*) AS count FROM public.%I', table_name),
            false,
            true,
            ''
        )
    ))[1]::text::bigint AS total_rows
FROM information_schema.tables
WHERE table_schema = 'public'
  AND table_type = 'BASE TABLE'
ORDER BY table_name;

