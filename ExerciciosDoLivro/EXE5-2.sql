-- Escreva uma consulta que retorne o título de cada filme em que um ator
-- com o primeiro nome JOHN apareceu.

select 
	f.filme_id
    from 
    filme f
	inner join filme_ator ft 
		on ft.filme_id = f.filme_id
	inner join ator a
		on ft.ator_id = a.ator_id
	WHERE a.primeiro_nome = "JOHN";

