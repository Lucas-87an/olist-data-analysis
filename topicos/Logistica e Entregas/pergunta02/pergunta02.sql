/* ESTADOS COM MAIS ATRASOS DE ENTREGA */

SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_pedidos_atrasados
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_date IS NOT NULL
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY c.customer_state
ORDER BY total_pedidos_atrasados DESC;

/* ESTADOS COM MAIS PEDIDOS */
SELECT
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS total_pedidos
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY total_pedidos DESC;

/* FAZENDO AS ANÁLISES DOS TRÊS ESTADOS COM MAIS PEDIDOS SP,RJ E MG FICA A PERGUNTA.
 * POR QUÊ ESSES ESTADOS ATRASAM MAIS ?*/

/* POSSÍVEIS CAUSAS E CONSIDERANDO A LIMITAÇÃO DOS DADOS MAS MESMO ASSIM
 * TENDO A LINHA DO TEMPO DE CADA PEDIDO NOS PODEMOS SUPOR VÁRIAS CAUSAS*/

/* Atraso na aprovação do pagamento
 * Possíveis causas:
	problemas no pagamento
	boletos demorando
	análise antifraude */

/* Atraso no envio pelo vendedor 
 * Possíveis causas:
	estoque
	atraso na coleta*/

/* Atraso no transporte 
 * Possíveis causas:
	logística urbana
	alto volume de entregas
	congestionamento
	múltiplas tentativas*/

/* Prazo mal estimado
 * Possível causa:
	SLA irreal
	subestimação do prazo para regiões específicas */

/* FAZENDO A CONSULTA PELO ESTADO DE SÃO PAULO*/
SELECT
    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_approved_at - o.order_purchase_timestamp)) / 3600),
        2
    ) AS tempo_aprovacao_horas,

    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_carrier_date - o.order_approved_at)) / 86400)
    ) AS tempo_preparacao_envio_dias,

    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_delivered_carrier_date)) / 86400)
    ) AS tempo_transporte_dias,

    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400)
    ) AS atraso_medio_dias
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_state = 'SP'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date;
    
/* COMPARANDO COM OUTROS ESTADOS MENOS CASOS DE ATRASOS*/    
SELECT
    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_approved_at - o.order_purchase_timestamp)) / 3600),
        2
    ) AS tempo_aprovacao_horas,

    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_carrier_date - o.order_approved_at)) / 86400)
    ) AS tempo_preparacao_envio_dias,

    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_delivered_carrier_date)) / 86400)
    ) AS tempo_transporte_dias,

    ROUND(
        AVG(EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_estimated_delivery_date)) / 86400)
    ) AS atraso_medio_dias
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_state = 'BA'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date;

    
/* Insight */
    
/* “ Embora São Paulo concentre o maior número de pedidos atrasados, o principal gargalo não é a aprovação do pagamento, 
 * mas sim o despacho pelo vendedor e a entrega final, que juntos representam a maior parte do atraso.
 * Quando comparados com outros estados com menos casos de pedidos atrasados, a média de tempo_preparacao_envio_dias de
 *  São Paulo é a mais alta, Influenciando total na entrega de pedidos. ” */
