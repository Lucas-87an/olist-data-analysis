/* QUANTOS CLIENTES ÚNICOS */

select
	count(distinct c.customer_unique_id) as total_clientes_unicos
from customers c
join orders o
	on c.customer_id = o.customer_id;

