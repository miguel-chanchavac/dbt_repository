{{ config(materialized='table') }}

with cliente as (
    select * from {{ref("stg_cliente")}}
), caja_bancos as (
    select * from {{ref("stg_caja_bancos")}}
), proveedor as (
    select * from {{ref("stg_proveedor")}}
)
select *,
case 
	when fecha_operacion = date_trunc('YEAR', fecha_operacion+5 - interval '5 day')::date then lag(saldo_inicial, 1) over (order by fecha_operacion)+debe-haber 
	else saldo_inicial+debe-haber
end as saldo_final
from cliente
union all
select *
,case 
	when fecha_operacion = date_trunc('YEAR', fecha_operacion+5 - interval '5 day')::date then lag(saldo_inicial, 1) over (order by cuenta_resumen, fecha_operacion)+debe-haber 
	else saldo_inicial+debe-haber
end as saldo_final
from caja_bancos
union all
select *
,case 
	when fecha_operacion = date_trunc('YEAR', fecha_operacion+5 - interval '5 day')::date then lag(saldo_inicial, 1) over (order by cuenta_resumen, fecha_operacion)+debe-haber 
	else saldo_inicial+debe-haber
end as saldo_final
from proveedor