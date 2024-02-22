WITH cte as(
SELECT d.division, s.product_code, d.product, total_sold_quantity, 
rank() over(partition by division order by total_sold_quantity desc) as rank_order 
FROM
(SELECT product_code, SUM(sold_quantity) as total_sold_quantity FROM fact_sales_monthly
WHERE fiscal_year = 2021
GROUP BY product_code) as s
JOIN 
(SELECT product_code, product, division FROM dim_product) as d
ON d.product_code = s.product_code
ORDER BY d.division)
SELECT * FROM cte
WHERE rank_order < 4;



