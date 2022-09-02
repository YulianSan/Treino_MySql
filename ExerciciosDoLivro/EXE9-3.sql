
-- Junte a seguinte consulta a uma subconsulta no film_actor
-- tabela para mostrar o nível de cada ator:

-- SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
-- UNION ALL
-- SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
-- UNION ALL
-- SELECT 'Newcomer' level, 1 min_roles, 19 max_roles

-- A subconsulta na tabela film_actor deve contar o
-- número de linhas para cada ator usando group by actor_id e
-- a contagem deve ser comparada às colunas min_roles/max_roles para
-- determinar a qual nível cada ator pertence


select 
	ator_level.level, count(*)
from filme_ator fa
	inner join (
		SELECT 'Hollywood Star' level, 30 min_roles, 99999 max_roles
		UNION ALL
		SELECT 'Prolific Actor' level, 20 min_roles, 29 max_roles
		UNION ALL
		SELECT 'Newcomer' level, 1 min_roles, 19 max_roles
    ) ator_level on 
        -- tive que faz uma subquery pq quando eu colocava apenas o count(*) dava errado
		( select count(ator_id) from filme_ator where ator_id = fa.ator_id group by ator_id ) 
        between ator_level.min_roles and ator_level.max_roles
    
group by fa.ator_id
order by count(*);