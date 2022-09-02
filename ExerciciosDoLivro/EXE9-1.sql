-- Construir uma consulta na tabela de filmes que usa uma condição de filtro
-- com uma subconsulta não correlacionada com a tabela de categorias para encontrar
-- todos os filmes de ação

select 
	count(*) 
from filme f 
	where exists (
		select 
			* 
        from filme_categoria fc 
            where f.filme_id = fc.filme_id AND fc.categoria_id = 1 -- esse é o id da categoria Action
    );
    
select * from categoria