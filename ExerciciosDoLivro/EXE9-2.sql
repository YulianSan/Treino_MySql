-- Refaça a consulta do Exercício 9-1 usando uma subconsulta correlacionada
-- contra as tabelas category e film_category para alcançar o
-- mesmos resultados.

select 
	count(*) 
from filme f 
	where exists (
		select 
			* 
        from filme_categoria fc 
            inner join categoria c using( categoria_id )
		    where f.filme_id = fc.filme_id AND c.nome = "Action"
    );