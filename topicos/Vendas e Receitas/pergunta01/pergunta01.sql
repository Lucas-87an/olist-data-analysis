/* QUAL É O FATURAMENTO TOTAL */

SELECT ROUND(SUM(p.payment_value)::numeric, 2) AS faturamento_total
FROM payments p;

