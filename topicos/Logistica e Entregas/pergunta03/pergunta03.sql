/* TOTAL DE PEDIDOS ENTREGUES FORA DO PRAZO */

SELECT
    COUNT(DISTINCT o.order_id) AS total_pedidos_fora_prazo
FROM orders o
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date
ORDER BY total_pedidos_fora_prazo DESC;







