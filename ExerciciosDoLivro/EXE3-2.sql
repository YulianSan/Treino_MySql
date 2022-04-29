-- Recupere o ID do ator, nome e sobrenome de todos os atores cujos
-- sobrenome é igual a 'WILLIAMS' ou .'DAVIS'
SELECT 
	a.ator_id AS ID,
    a.primeiro_nome AS PrimeiroNome,
    a.ultimo_nome AS UltimoNome
FROM ator a
	WHERE UPPER(a.ultimo_nome) IN('WILLIAMS','DAVIS')
	ORDER BY a.ultimo_nome, a.primeiro_nome;