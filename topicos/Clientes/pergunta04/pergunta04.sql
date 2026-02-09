/* CLIENTES POR ESTADO */
select c.customer_state as estado, count( distinct c.customer_unique_id) as quantidade_clientes
from customers c
group by c.customer_state
ORDER BY quantidade_clientes;
