/* QUAL O TICKET MÉDIO POR PERÍODO */
select 
	EXTRACT(year from o.order_purchase_timestamp) as ano,
	EXTRACT(month from o.order_purchase_timestamp) as mes,
	round(sum(p.payment_value)::numeric / count(o.order_id), 2) as ticket_medio
from payments p
join orders o on p.order_id = o.order_id
group by ano, mes
order by ano, mes;







