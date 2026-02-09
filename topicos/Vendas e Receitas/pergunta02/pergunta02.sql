/* COMO O FATURAMENTO EVOLUIU AO LONGO DO TEMPO (MES/ANO) */

SELECT 
	round(sum(p.payment_value)::NUMERIC,2) AS faturamento,
	EXTRACT(year from o.order_purchase_timestamp) AS ano,
	EXTRACT(month from o.order_purchase_timestamp) AS mes
FROM payments p 
LEFT JOIN orders o ON p.order_id = o.order_id
GROUP BY ano, mes
ORDER BY ano;