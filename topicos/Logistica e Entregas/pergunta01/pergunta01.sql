/* TEMPO MÉDIO DE ENTREGA */

SELECT
    ROUND(
        AVG(
            EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_approved_at)) 
            / 86400
        )
    ) AS tempo_medio_entrega_dias
FROM orders o
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_approved_at IS NOT NULL;


