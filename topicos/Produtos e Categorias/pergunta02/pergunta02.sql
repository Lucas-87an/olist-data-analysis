/* QUAIS CATEGORIAS VENDEM MAIS EM VOLUMES */

SELECT
    p.product_category_name,
    COUNT(*) AS quantidade_itens_vendidos
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY quantidade_itens_vendidos DESC;
