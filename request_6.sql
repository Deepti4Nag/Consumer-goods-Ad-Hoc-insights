SELECT c.customer_code, 
       c.customer, 
       pct.average_discount_percentage
FROM( 
SELECT customer_code, pre_invoice_discount_pct as average_discount_percentage
FROM fact_pre_invoice_deductions
WHERE pre_invoice_discount_pct > (SELECT ROUND(AVG(pre_invoice_discount_pct), 2) FROM fact_pre_invoice_deductions
WHERE fiscal_year = 2021) and
fiscal_year = 2021) AS pct
JOIN 
(SELECT customer_code, customer FROM dim_customer
WHERE market = 'India') AS c
ON c.customer_code = pct.customer_code
ORDER BY average_discount_percentage DESC
LIMIT 5;




