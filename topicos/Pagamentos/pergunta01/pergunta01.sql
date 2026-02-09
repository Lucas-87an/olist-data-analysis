/* FORMAS DE PAGAMENTO MAIS USADAS */

select
	p.payment_type as tipo_pagamento,
	count(*) as total
from payments p
WHERE p.payment_type != 'not_defined'
group by p.payment_type;

