WITH zy as (
SELECT m.product_code, m.customer_code, d.channel, sold_quantity FROM fact_sales_monthly as m
JOIN dim_customer as d 
ON d.customer_code = m.customer_code
WHERE fiscal_year = 2021)
SELECT zy.channel, ROUND(SUM(p.gross_price*sold_quantity)/1000000, 2) as gross_sales_mln, 
	ROUND(SUM(p.gross_price*sold_quantity)/1000000, 2)*100/SUM(ROUND(SUM(p.gross_price*sold_quantity)/1000000, 2)) 
    OVER() as percentage 
    FROM zy
JOIN 
fact_gross_price as p
ON p.product_code = zy.product_code
WHERE p.fiscal_year = 2021
GROUP BY zy.channel
ORDER BY gross_sales_mln DESC;


