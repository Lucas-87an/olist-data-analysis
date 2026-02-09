/* QUAIS CATEGORIAS MAIS FATURAM */

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price)::NUMERIC, 2) AS faturamento
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY faturamento DESC;


