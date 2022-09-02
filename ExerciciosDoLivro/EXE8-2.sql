-- Modifique sua consulta do Exercício 8-1 para contar o número de
-- pagamentos efetuados por cada cliente. Mostre o ID do cliente e o
-- valor total pago por cada cliente.

SELECT 
	p.cliente_id,
    count(*)
FROM pagamento p
	GROUP BY p.cliente_id;