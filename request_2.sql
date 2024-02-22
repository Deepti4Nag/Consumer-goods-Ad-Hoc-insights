SELECT * ,
       ROUND((unique_products_2021-unique_products_2020)*100/unique_products_2020, 2) AS percentage_change FROM 
( 
SELECT COUNT(DISTINCT product_code) as unique_products_2020
FROM fact_sales_monthly
WHERE fiscal_year = 2020) AS fiscal_2020 
CROSS JOIN 
(
SELECT COUNT(DISTINCT product_code) as unique_products_2021
FROM fact_sales_monthly
WHERE fiscal_year = 2021) AS fiscal_2021
