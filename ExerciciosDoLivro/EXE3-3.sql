-- Escreva uma consulta na tabela de aluguel que retorna os IDs do
-- clientes que alugaram um filme em 5 de julho de 2005 (use o
-- rental.rental_date coluna, e você pode usar o date()
-- função para ignorar o componente de tempo). Incluir uma única linha para cada
-- ID de cliente distinto.

SELECT 
	al.cliente_id AS ID,
    DATE(al.data_de_aluguel) AS DataAluguel
FROM aluguel al
	WHERE DATE(al.data_de_aluguel) = '2005-07-05';