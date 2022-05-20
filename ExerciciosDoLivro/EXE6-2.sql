-- Exercício 6-2 Escreva uma consulta composta que encontre o nome e o sobrenome de todos Atores e Clientes cujo sobrenome começa com L.

	select 
		"Cliente: " AS classe,
		CONCAT(UPPER(LEFT(c.primeiro_nome, 1)),LOWER(SUBSTRING(c.primeiro_nome, 2))) AS Nome,
		CONCAT(UPPER(LEFT(c.ultimo_nome, 1)),LOWER(SUBSTRING(c.ultimo_nome, 2))) AS SegundoNome
	from cliente c
		where c.ultimo_nome LIKE "L%"
UNION
	select 
		"Ator: " AS classe,
		CONCAT(UPPER(LEFT(a.primeiro_nome, 1)),LOWER(SUBSTRING(a.primeiro_nome, 2))) AS Nome,
        --SUBSTRING pega uma parte da string começando por um indice
        --LEFT pega da esquerda para a direita em um indice
        --UPPER coloca a string em caixa alta
        --LOWER coloca a string em caixa baixa
		CONCAT(UPPER(LEFT(a.ultimo_nome, 1)),LOWER(SUBSTRING(a.ultimo_nome, 2))) AS SegundoNome

	from ator a
		where a.ultimo_nome LIKE "%L%";



