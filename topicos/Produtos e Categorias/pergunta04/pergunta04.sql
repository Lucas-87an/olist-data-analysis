/* PRODUTOS MAIS VENDIDOS VS PRODUTOS COM MAIOR FATURAMENTO */

SELECT
    p.product_id,
    p.product_category_name,
    COUNT(*) AS quantidade_vendida,
    ROUND(SUM(oi.price)::NUMERIC, 2) AS faturamento_produto
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND p.product_category_name IS NOT NULL
GROUP BY p.product_id, p.product_category_name
ORDER BY quantidade_vendida DESC;


