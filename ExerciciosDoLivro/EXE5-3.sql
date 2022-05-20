--Construir uma consulta que encontre retorna todos os endereços que estão no
--Mesma cidade. Você precisará unir a tabela de endereços a ela mesma, e cada
--linha deve incluir 2 endereços diferentes

--__________________AVISO: Não sei se está certo
select e1.endereco,e2.endereco, e1.cidade_id, e2.cidade_id from endereco e1
	inner join endereco e2
    where e1.cidade_id = e2.cidade_id AND e1.endereco != e2.endereco;