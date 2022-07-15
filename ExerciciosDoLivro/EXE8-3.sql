-- Modifique sua consulta do Exercício 8-2 para incluir apenas esses clientes
-- ter feito pelo menos cinco pagamentos.

SELECT 
	p.cliente_id,
    count(*)
FROM pagamento p
	GROUP BY p.cliente_id
    HAVING count(*) >= 5;