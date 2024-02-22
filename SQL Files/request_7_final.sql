WITH mo as(
SELECT date_add(date, INTERVAL 4 MONTH) as fiscal_date, f.product_code, f.customer_code, d.customer,
       sold_quantity, f.fiscal_year, g.gross_price as gp_per_unit, 
       ROUND(g.gross_price*sold_quantity, 2) as total_gross_price
FROM fact_sales_monthly AS f
JOIN fact_gross_price AS g ON
g.product_code = f.product_code
and f.fiscal_year = g.fiscal_year
JOIN dim_customer AS d ON
d.customer_code  = f.customer_code
WHERE customer = 'Atliq Exclusive')
SELECT MONTH(fiscal_date) as fiscal_month, YEAR(fiscal_date) as fiscal_year, SUM(total_gross_price) as gross_sales_amount
FROM mo
GROUP BY fiscal_date
ORDER BY gross_sales_amount DESC;
