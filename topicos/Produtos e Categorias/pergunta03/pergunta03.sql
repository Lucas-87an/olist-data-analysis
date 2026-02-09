/* CATEGORIAS COM ALTO VOLUME DE QUANTIDADES MAS BAIXO FATURAMENTO */

WITH categoria_metricas AS (
    SELECT
        p.product_category_name,
        COUNT(*) AS quantidade_itens_vendidos,
        ROUND(SUM(oi.price)::NUMERIC, 2) AS faturamento
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
)

SELECT
    product_category_name,
    quantidade_itens_vendidos,
    faturamento
FROM categoria_metricas
WHERE quantidade_itens_vendidos > 1000
  AND faturamento < 500000
ORDER BY quantidade_itens_vendidos DESC;










