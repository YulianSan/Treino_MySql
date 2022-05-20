--Exercício 6-3 Classifique os resultados do Exercício 6-2 pela coluna last_name

	(select 
		"Cliente: " AS classe,
		CONCAT(UPPER(LEFT(c.primeiro_nome, 1)),LOWER(SUBSTRING(c.primeiro_nome, 2))) AS Nome,
		CONCAT(UPPER(LEFT(c.ultimo_nome, 1)),LOWER(SUBSTRING(c.ultimo_nome, 2))) AS SegundoNome
	from cliente c
		where c.ultimo_nome like "L%"
        order by c.ultimo_nome)
UNION
	(select 
		"Ator: " AS classe,
		CONCAT(UPPER(LEFT(a.primeiro_nome, 1)),LOWER(SUBSTRING(a.primeiro_nome, 2))) AS Nome,
		CONCAT(UPPER(LEFT(a.ultimo_nome, 1)),LOWER(SUBSTRING(a.ultimo_nome, 2))) AS SegundoNome
	from ator a
		where a.ultimo_nome like "L%"
        order by a.ultimo_nome)