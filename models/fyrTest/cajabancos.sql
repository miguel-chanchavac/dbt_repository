with caja_bancos as (select * from {{ ref("rel_caja_bancos") }})
select
    case
        when
            fecha_operacion
            = date_trunc('YEAR', fecha_operacion + 5 - interval '5 day')::date
        then
            lag(saldo_inicial, 1) over (order by cuenta_resumen, fecha_operacion)
            + debe
            - haber
        else saldo_inicial + debe - haber
    end as saldo_final
from caja_bancos
