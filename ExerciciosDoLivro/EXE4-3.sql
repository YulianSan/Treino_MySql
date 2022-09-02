-- Construir uma consulta que recupera todas as linhas da tabela Pagamento onde o valor é 1,98, 7,98 ou 9,98.

use treino;
select
	* 
from pagamento p
    where p.valor IN(1.98,7.98,9.98)
    limit 20;