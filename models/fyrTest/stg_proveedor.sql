with proveedor as (
select 
	posicion ,
	cuenta_resumen  ,
	to_date(to_char(fecha_operacion, 'yyyy-MM-')||'01', 'yyyy-MM-dd') as fecha_operacion,
	--lag(fecha_operacion, 1) over (order by to_date(to_char(fecha_operacion, 'yyyy-MM-')||'01', 'yyyy-MM-dd')) as fecha_anterior
	sum(saldo_inicial) as saldo_inicial,
	sum(debe_2) as debe,
	sum(haber_2) as haber
from stage.stage_ingreso_historia sih
where 1=1 
and posicion in ('4.3') --PROVEEDORES
group by posicion ,
cuenta_resumen,
to_date(to_char(fecha_operacion, 'yyyy-MM-')||'01', 'yyyy-MM-dd')
order by fecha_operacion, cuenta_resumen 
)
select * from proveedor