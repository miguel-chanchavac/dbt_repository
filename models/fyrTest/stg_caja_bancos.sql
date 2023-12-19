with stg_caja_bancos as (
select 
	posicion ,
	cuenta_resumen  ,
	to_date(to_char(fecha_operacion, 'yyyy-MM-')||'01', 'yyyy-MM-dd') as fecha_operacion,
	sum(saldo_inicial) as saldo_inicial,
	sum(debe_2) as debe,
	sum(haber_2) as haber
from stage.stage_ingreso_historia sih
where 1=1 
and posicion in ('1.8') --CAJA Y BANCOS
group by posicion ,
cuenta_resumen,
to_date(to_char(fecha_operacion, 'yyyy-MM-')||'01', 'yyyy-MM-dd')
order by fecha_operacion, cuenta_resumen
)
select * from stg_caja_bancos