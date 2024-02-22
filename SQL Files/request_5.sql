SELECT * FROM (
SELECT p.product_code, p.product, manufacturing_cost FROM fact_manufacturing_cost AS m
JOIN dim_product AS p
ON p.product_code = m.product_code
WHERE manufacturing_cost = (SELECT max(manufacturing_cost) FROM fact_manufacturing_cost)) AS max_cost
CROSS JOIN (
SELECT p.product_code, p.product, manufacturing_cost FROM fact_manufacturing_cost AS m
JOIN dim_product AS p
ON p.product_code = m.product_code
WHERE manufacturing_cost = (SELECT min(manufacturing_cost) FROM fact_manufacturing_cost)) AS min_cost;






