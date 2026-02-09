/* QUAL O TICKET MÉDIO POR CLIENTE */
with gasto_por_cliente as (
	select 
		c.customer_unique_id,
		sum(p.payment_value ) as total_gasto_cliente
	from customers c 
	join orders o
		on c.customer_id = o.customer_id
	join payments p 
		on o.order_id = p.order_id
	group by c.customer_unique_id 
)

select 
	round(AVG(total_gasto_cliente)::numeric, 2) as ticket_medio_por_cliente
from gasto_por_cliente;







