-- Reescreva a consulta a seguir para que o conjunto de resultados contenha um único
-- linha com cinco colunas (uma para cada classificação). Nomeie as cinco colunas
-- G, PG, PG_13, R e NC_17.

-- +--------+----------+
-- | rating | count(*) |
-- +--------+----------+
-- | PG     | 194      |
-- | G      | 178      |
-- | NC-17  | 210      |
-- | PG-13  | 223      |
-- | R      | 195      |
-- +--------+----------+

select
	SUM(case f.classificacao
		when 'PG' then 1
		else 0
    end) PG,
    SUM(case f.classificacao
		when 'G' then 1
		else 0
    end) G,
    SUM(case f.classificacao
		when 'NC-17' then 1
		else 0
    end) `NC-17`,
    SUM(case f.classificacao
		when 'PG-13' then 1
		else 0
    end) `PG-13`,
    SUM(case f.classificacao
		when 'R' then 1
		else 0
    end) `R`
    
from filme f;