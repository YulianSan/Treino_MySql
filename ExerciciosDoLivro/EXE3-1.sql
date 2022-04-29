-- Recupere o ID do ator, o nome e o sobrenome de todos os atores. Ordenar por
-- sobrenome e depois pelo primeiro nome.

SELECT 
	a.ator_id AS ID,
    a.primeiro_nome AS PrimeiroNome,
    a.ultimo_nome AS UltimoNome
FROM ator a
	ORDER BY a.ultimo_nome, a.primeiro_nome;
    