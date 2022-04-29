-- Preencha os espaços em branco (indicados por <#>) para esta consulta de várias tabelas para
-- alcançar os resultados mostrados abaixo 
 
SELECT 
 	c.email,
    r.data_de_devolucao
 FROM cliente c
 	INNER JOIN aluguel r ON c.cliente_id = r.cliente_id
    WHERE date(r.data_de_devolucao) = '2005-06-14'
    ORDER BY r.data_de_devolucao DESC, c.email ASC;