--Construa uma consulta que encontre todos os clientes cujo sobrenome contenha um A na segunda posição e um W em qualquer lugar após o A. use treino;

select
	* from cliente c
    where c.ultimo_nome  LIKE '_a%w%';