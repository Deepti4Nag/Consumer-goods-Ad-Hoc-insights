SELECT fiscal_2020.segment, 
       product_count_2020, 
       product_count_2021, 
       (product_count_2021-product_count_2020) as difference
FROM (
SELECT segment,
		COUNT(DISTINCT p.product_code) AS product_count_2020
FROM gdb023.dim_product as p
JOIN fact_sales_monthly AS s
ON p.product_code = s.product_code
WHERE fiscal_year = 2020
GROUP BY segment) AS fiscal_2020
 JOIN 
 (SELECT segment,
		COUNT(DISTINCT p.product_code) AS product_count_2021
FROM gdb023.dim_product as p
JOIN fact_sales_monthly AS s
ON p.product_code = s.product_code
WHERE fiscal_year = 2021
GROUP BY segment) AS fiscal_2021
ON fiscal_2021.segment = fiscal_2020.segment
ORDER BY difference DESC;