/* CLIENTES RECORRENTES */

SELECT
    COUNT(*) AS total_clientes_recorrentes
FROM (
    SELECT
        c.customer_unique_id
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_unique_id
    HAVING COUNT(o.order_id) > 1
);