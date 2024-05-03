with comissoes_vendedor AS (
    select
        vendedor,
        sum(valor) AS total_recebido,
        row_number() over (partition by vendedor order by "data") AS ordem_transferencia
    from
        comissoes
    group by
        vendedor, "data"
)
select distinct
    vendedor
from
    comissoes_vendedor
where
    ordem_transferencia <= 3
group by
    vendedor
having
    sum(total_recebido) >= 1024
order by
    vendedor ASC;
