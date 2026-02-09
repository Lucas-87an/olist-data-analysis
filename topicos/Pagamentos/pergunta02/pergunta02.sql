/* PARCELAMENTO MÉDIO */

select
	round(AVG(p.payment_installments)) as media_parcelamento
from payments p
where p.payment_type = 'credit_card' and p.payment_installments > 0;