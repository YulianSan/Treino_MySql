--Mostra o id Aluguel, id do cliente, quando alugou, quando deve devolver e quanto tempo falta para devolver

SELECT 
    al.aluguel_id AS "IdAluguel"       ,
    c.cliente_id AS "IdCliente"        , 
    al.data_de_aluguel AS "DataAlugou" , 
    al.data_de_devolucao AS "Devolução", 
    DATEDIFF(al.data_de_devolucao,al.data_de_aluguel) AS "DiasRestantes" 
    
FROM aluguel al
	INNER JOIN cliente c ON c.cliente_id = al.cliente_id
    WHERE DATEDIFF(al.data_de_devolucao,al.data_de_aluguel) IS NOT NULL
    ORDER BY al.data_de_devolucao ASC
    LIMIT 5;

--mostra quantos pagamentos já forma feitos por cada cliente

SELECT 
	p.cliente_id,
    COUNT(p.cliente_id) AS "Quantos pagamentos já foram feitos"
FROM pagamento p
	GROUP BY p.cliente_id
    ORDER BY COUNT(p.cliente_id) DESC;

--Pega a maior venda e ve quantas vendas ja tiveram cada funcionario
SELECT 
	CONCAT(f.primeiro_nome," ", f.ultimo_nome) AS Nome,
    f.loja_id,
    COUNT(p.valor)
FROM 
	funcionario f
	LEFT JOIN pagamento p ON p.funcionario_id = f.funcionario_id
    WHERE p.valor = (SELECT MAX(valor) FROM pagamento)
    GROUP BY f.funcionario_id;

--igual o de cima, so fiz algumas alterações
SELECT 
	CONCAT(f.primeiro_nome," ", f.ultimo_nome) AS Nome,
    f.loja_id,
    COUNT(p.valor)
FROM 
	funcionario f
	LEFT JOIN pagamento p ON p.funcionario_id = f.funcionario_id
    WHERE p.valor IN((SELECT MAX(valor) FROM pagamento),11.99)
    GROUP BY f.funcionario_id;


--ver se o funcionario está ativo ou inativo

SELECT
	CONCAT(f.primeiro_nome," ",f.ultimo_nome) AS "Nome",
	CASE
    	WHEN f.ativo = 1 THEN "Ativo"
        ELSE "Inativo"
    END AS "Status"
FROM 
	funcionario f;

--insert legalzinho que eu fiz no pagamento

INSERT INTO
    pagamento
    (
        pagamento_id      , 
        cliente_id        ,
        funcionario_id    , 
        aluguel_id        ,
        valor             , 
        data_de_pagamento ,
        ultima_atualizacao
    ) 
VALUES (
    (SELECT 
        MAX(p.pagamento_id)+1 
        FROM pagamento p
    ),
    1 ,1 ,1 ,20.99 ,
    '2005-03-13 12:00:00',
    CURRENT_TIMESTAMP 
);

--brincando com selects 

SELECT concat(cust.last_name, ', ', cust.first_name) AS full_name
 FROM
 (SELECT f.primeiro_nome AS last_name,
    f.ultimo_nome AS first_name,
    f.email
 FROM funcionario f
    WHERE UPPER(f.primeiro_nome) LIKE 'J%' OR f.primeiro_nome LIKE '%E'
) cust;


--tabelas temporarias e insersão de table em tabela

CREATE TEMPORARY TABLE teste --cria uma tabela temporaria com os campos
  (actor_id smallint(5) ,
  first_name varchar(45),
  last_name varchar(45)
 );

INSERT INTO teste --insere na tabela temporaria
    SELECT a.ator_id, a.primeiro_nome, a.ultimo_nome --paga os dados de outra tabela e insere nessa
FROM ator a
    WHERE a.ultimo_nome LIKE '%'; --where nada a ver, pois seleciona tudo

SELECT * FROM teste;--seleciona a tabela temporaria

--criação de views
CREATE VIEW Funcionarios_Status AS --cria uma view e faz um select, é tipo criar uma tabela de determinado select
SELECT
	...
FROM 
	...;

--um exemplo de VIEW
CREATE VIEW Funcionarios_Status AS 
SELECT
	CONCAT(f.primeiro_nome," ",f.ultimo_nome) AS "Nome",
	CASE
    	WHEN f.ativo = 1 THEN "Ativo"
        ELSE "Inativo"
    END AS "Status"
FROM 
	funcionario f;
SELECT * FROM Funcionarios_Status;

--Outro Exemplo
CREATE VIEW Cliente_Status AS 
SELECT
	CONCAT(c.primeiro_nome," ",c.ultimo_nome) AS "Nome",
	CASE
    	WHEN c.ativo = 1 THEN "Ativo"
        ELSE "Inativo"
    END AS "Status"
FROM 
	cliente c;
SELECT * FROM Cliente_Status;

-- brincando com time() pega a hora de uma data EX: 2000-12-10 22:00:00 retorna 22:00:00, date pega a data
 SELECT 
 	c.primeiro_nome, c.ultimo_nome,
 	time(a.data_de_aluguel) AS rental_time
 FROM cliente c
 	INNER JOIN aluguel a ON a.cliente_id = c.cliente_id
 	WHERE time(a.data_de_aluguel) BETWEEN '22:00:00' AND '23:00:00';--procura clientes que alugaram dentro de 22h a 23h

--where e Order By, where com AND para so passar se as duas serem true e OR para pelo menos uma ser true
SELECT 
	f.titulo,
    f.duracao_da_locacao,
    f.classificacao
  FROM filme f
  WHERE f.classificacao = 'G' AND f.duracao_da_locacao >= 5
  ORDER BY 1;--Order por números funciona para falar qual campo de select vai ser usado para ordernar, olhando o de em cima da para ver que o campo 1 é o f.titulo

  -- OR dentro de () com AND fora, o OR retornaria true ou false, independente que dentro do parenteses tenha um false, o AND so ve o retorno fora do parenteses

 SELECT 
 	c.primeiro_nome,
    c.ultimo_nome,
    c.data_criacao
 FROM cliente c
 	WHERE (c.primeiro_nome = 'STEVEN' OR c.ultimo_nome = 'YOUNG') AND c.data_criacao > '2006-01-01';

-- NOT é para negar, se eu procuro por primeiro_nome = 'steven' ou 'young' e eu colocar not, ele vai me dar todos que não tem esse primeiro nome, apenas para os nomes, nao a data
 SELECT 
 	c.primeiro_nome,
    c.ultimo_nome,
    c.data_criacao
 FROM cliente c
 	WHERE NOT(c.primeiro_nome = 'STEVEN' OR c.ultimo_nome = 'YOUNG') AND c.data_criacao > '2006-01-01';--NOT e como se fosse um ! na programação


-- = igual, <> diferente, maior > menor, menor < maior, <= maior ou igual, BETWEEN entre EX: BETWEEN id= 1 AND id=10 -> pega de 1 a 10; o IN e entre os valores mencionados 
-- EX: IN(1,2,6) retorna apenas linhas que tenham pelo menos um desses dados
-- left() pega da esquerda um indice por exemplo: left( "Andrey", 1 ) retorna "A", já o right pega da direita EX: right( "Andrey", 1 ) retorna "y";

--IS NULL é para ver se um campo é vazio
 SELECT 
 	a.aluguel_id, 
    a.cliente_id,
    a.data_de_devolucao
 FROM aluguel a
 WHERE a.data_de_devolucao IS NULL;--onde a data_de_devolucao é igual a NULL, ou seja, vazio;

 -- EXIST é para ver se tem um ou mais row(s), se utilizar not, ele nega, ou seja, ele procura quem n retorna nem uma row

 SELECT 
	* 
FROM funcionario f
	WHERE NOT EXISTS (
		SELECT 
			1 
		FROM aluguel a
        WHERE a.funcionario_id = f.funcionario_id
	);

-- Pega os pagamentos com o maior valor, usando o MAX

SELECT 
	* 
FROM pagamento p
	WHERE p.valor = (SELECT max(p1.valor) FROM pagamento p1 );

--Pega os valor acima da media, usando AVG

SELECT 
	* 
FROM pagamento p
	WHERE p.valor >= (SELECT avg(p1.valor) FROM pagamento p1 )
    ORDER BY p.valor DESC;

-- Pega a diferença da data atual para a data de aluguel

SELECT 
	now(),
    a.data_de_aluguel,
	datediff(now(), a.data_de_aluguel) AS direfenca
FROM aluguel a;

-- Criando tabelas temporarias com referencia de outras tabelas

WITH actors_s_pg_revenue AS--WITH nomeDaTabela AS (select que vc quer)
	(SELECT 
        f.funcionario_id,
        COUNT(*)
	FROM aluguel a
        INNER JOIN funcionario f
        ON f.funcionario_id = a.funcionario_id
        GROUP BY f.funcionario_id
)
select * from actors_s_pg_revenue;

-- Pegar o tamanho de uma string

SELECT LENGTH('Yulian');

-- Da a posiçao de uma palavra que você procura

SELECT LOCATE('am', 'I am Singed');

-- A função STRCMP() compara duas strings.
-- Se string1 = string2 , esta função retorna 0
-- Se string1 < string2 , esta função retorna -1
-- Se string1 > string2 , esta função retorna 1

SELECT STRCMP("SQL Tutorial", "HTML Tutorial"); -- return 1

-- INSERT() string, a posição na qual começar, o número de caracteres a serem substituídos e o
-- cadeia de substituição.

SELECT INSERT('goodbye world', 8, 0, ' cruel ') OI;

-- REPLACE() substitui uma string por outra, parâmetros: string original, oq vai ser substituido, oq vai substituir

SELECT REPLACE('goodbye world', 'goodbye', 'hello');

-- Separa um string, parâmetros: string original, aonde começa, quantos caracteres pegar

SELECT SUBSTRING('goodbye cruel world', 9, 5);
--ou 
SELECT SUBSTR('goodbye cruel world', 9, 5);

-- Arredondando valores
-- CEIL() para cima
-- FLOOR() para baixo
-- ROUND() para o mais próximo
SELECT CEIL(72.000000001), FLOOR(72.999999999); -- return 73 | 72
SELECT ROUND(72.49999), ROUND(72.5), ROUND(72.50001); -- return 72 | 73 | 73

-- Fala quantos decimais vai ter, mais n obriga ele ter esse decimais

SELECT TRUNCATE(72.0909, 1), TRUNCATE(72.0909, 2), TRUNCATE(72.0909, 3); -- 72 | 72.09 | 72.090

-- cast() Converte um dado para outro
-- parametros: dado original, tipo de dado que vc quer colocar
SELECT CAST('2019-09-17' AS DATE) date_field;


--pega a data em uma string, parametros: string com a data, metadados;
SELECT STR_TO_DATE('September 17, 2019', '%M %d, %Y');

--pega a data atual
SELECT CURRENT_TIMESTAMP();

-- adicionando em uma data
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 YEAR);  -- adiciona 5 anos
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 MONTH); -- adiciona 5 meses
SELECT DATE_ADD(CURRENT_DATE(), INTERVAL 5 HOUR);  -- adiciona 5 horas

-- pegando o último dia de um mês
SELECT LAST_DAY('2019-01-00'); -- retorna 2019-01-31

-- pega o nome do dia da semana
SELECT DAYNAME('2022-06-10'); -- retorna friday - sexta feira

-- pega um dado de uma determinada data
SELECT EXTRACT(SECOND FROM '2019-09-18 22:19:05');-- retorna os segundos dessa data -> 5

-- pega a diferença entre duas datas
SELECT DATEDIFF('2019-09-03', '2019-06-21'); -- retorno

-- pega a diferença entre datas, parametros: uma data, uma data; 
-- retorno = 1 data - 2 data, retorno em dias
-- pode retornar valores 
SELECT DATEDIFF('2019-09-03', '2018-06-21'); -- retorno 439

-- CONVERTER VALORES
SELECT CAST('-1456328' AS SIGNED INTEGER); -- SIGNED aceita número negativos, UNSIGNED não aceita números negativos
-- retorno -1456328
SELECT CAST('999ABC111' AS UNSIGNED INTEGER); -- vai pegar os primeiros valores considerados números
-- retorno 999, o resto é ignorado

-- DISTINCT é usado para encontrar campos n repetidos
SELECT count(DISTINCT a.cliente_id) FROM aluguel a; -- conta cada vez que o id cliente for diferente

-- OPERAÇÕES COM NÚMEROS
COUNT(val) num_vals,-- conta quantos resultados foram encontrados
SUM(val) total,     -- soma os valores
MAX(val) max_val,   -- pega o maior valor 
AVG(val) avg_val;   -- pega a média de vários 

-- WITH ROLLOUP funciona mais ou menos para aceitar valores nulos enquando agrupa,
-- no select ele pega a classificação null e mostra todos os filmes de um determinado atores 
SELECT fa.ator_id, f.classificacao, count(*)
	FROM filme_ator fa
	INNER JOIN filme f ON fa.filme_id = f.filme_id
    GROUP BY fa.ator_id, f.classificacao WITH ROLLUP;



------------------------------- Subquery ----------------------------
-- Pegar o menor valor, se faz assim
SELECT 
	p.valor
FROM pagamento p
	WHERE p.valor = (SELECT MIN(valor) FROM pagamento);

-- invés disso
SELECT 
	p.valor
FROM pagamento p
	WHERE p.valor = MIN(p.valor);

-- Pegando todas as cidades de um determinado país
SELECT
	*
FROM 
	cidade
    WHERE pais_id IN(-- se usa IN para procurar entre os valores que a query passar
        SELECT pais_id FROM  pais WHERE pais IN('Mexico','Colombia') -- essa query retorna 2 valores
    );

-- Pegando todos os cliente que pagaram mais que clientes da Norte America

SELECT
	COUNT(*)
FROM 
	aluguel a
    
GROUP BY a.cliente_id

HAVING COUNT(*) > ALL ( -- se mudarmos o ALL por ANY ele vai ver se pelo menos é maior que 1, já o ALL 
                        --tem que ser de todos, como seu próprio nome explica
		SELECT 
    		COUNT(*)
    	FROM
    		aluguel a
    	INNER JOIN cliente c ON c.cliente_id = a.cliente_id
    	INNER JOIN endereco e ON e.endereco_id = c.endereco_id
    	INNER JOIN cidade cd ON cd.cidade_id = e.cidade_id
        INNER JOIN pais p ON p.pais_id = cd.pais_id
    	
    	WHERE p.pais IN ('Estados Unidos','Mexico','Canada')
    	GROUP BY a.cliente_id
    	
	)

ORDER BY COUNT(*) DESC ;

-- Pega os filmes que tem a classificação = 'PG' e que tenha um ator que termina com o nome = 'MONROE'

SELECT 
	ator_id, filme_id
FROM 
	filme_ator
	WHERE (ator_id, filme_id) IN -- (c1,c2) pq a subquery retorna duas colunas
		(SELECT a.ator_id, f.filme_id
			FROM ator a
			CROSS JOIN filme f -- faz varias combinações com cada 
			WHERE a.ultimo_nome = 'MONROE'
			AND f.classificacao = 'PG'
        );

-- Criando tabelas com subquery e fazendo inner join

SELECT
	c.primeiro_nome,
    pagamento_cliente.n_pagamento,
    pagamento_cliente.ValorTotal
FROM cliente c
    INNER JOIN (
        SELECT 
        	p.pagamento_id,
            COUNT(*) AS n_pagamento,
        	SUM(p.valor) AS ValorTotal
        FROM pagamento p
        	GROUP BY p.cliente_id
    ) pagamento_cliente --pelo que parece n da para usar alias nessas tabelas
        on c.cliente_id = pagamento_cliente.pagamento_id
    ORDER BY 2 DESC, 3 DESC;

-- CUIDADE COM COLOCAR SEMPRE * EM COUNT

select 
    -- se eu colocar * no count ele me retorna
    -- valores indesejados, pois se ele vai contar o número
    -- de linhas agrupadas, ñ o número de copias com o valor ñ nulo

	f.titulo, count(i.inventario_id) num_copias
from filme f
	LEFT OUTER JOIN inventario i
    using(filme_id)
    
group by f.filme_id;

-- CROSS JOIN é usado para fazer uma linha combinar com todas as linhas de outra tabela

select 
	c.nome categoria_nome, i.nome idioma_nome
from categoria c
	cross join idioma i;

-- RESULTADO

-- Travel	German
-- Travel	French
-- Travel	Mandarin
-- Travel	Japanese
-- Travel	Italian
-- Travel	English
-- Sports	German
-- Sports	French
-- Sports	Mandarin
-- Sports	Japanese
-- Sports	Italian
-- Sports	English
    	
-- Coisa que dá para fazer com cross join
-- essa query retorna a contagem de 1 a 400, mas como eu limito ela
-- retornar 366, ela vai retornar ate esse valor máximo como se estivesse contando os dias do ano

SELECT 
    ones.num + tens.num + hundreds.num + 1 contagem_1_400
    -- essa linha de código mostra os 366 dias do ano,
    -- esse comando soma em dias os números retornados a uma data
    DATE_ADD('2020-01-01', INTERVAL (ones.num + tens.num + hundreds.num) DAY) 
 FROM
 (
    SELECT 0 num UNION ALL
    SELECT 1 num UNION ALL
    SELECT 2 num UNION ALL
    SELECT 3 num UNION ALL
    SELECT 4 num UNION ALL
    SELECT 5 num UNION ALL
    SELECT 6 num UNION ALL
    SELECT 7 num UNION ALL
    SELECT 8 num UNION ALL
    SELECT 9 num
 ) ones
 
 CROSS JOIN
 (
    SELECT 0 num UNION ALL
    SELECT 10 num UNION ALL
    SELECT 20 num UNION ALL
    SELECT 30 num UNION ALL
    SELECT 40 num UNION ALL
    SELECT 50 num UNION ALL
    SELECT 60 num UNION ALL
    SELECT 70 num UNION ALL
    SELECT 80 num UNION ALL
    SELECT 90 num
 ) tens

 CROSS JOIN
 (
    SELECT 0 num UNION ALL
    SELECT 100 num UNION ALL
    SELECT 200 num UNION ALL
    SELECT 300 num
 ) hundreds
 
 order by ones.num + tens.num + hundreds.num
 -- tá errado fazer desta forma pois um ano pode ter 365 ou 366;
 limit 366 
 -- a melhor forma é comparar a data com o primeiro dia do próximo ano
 -- desta forma:
 where DATE_ADD('2020-01-01', INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2021-01-01';




 -- vendo quantos aluguéis foram efetuados cada dia do ano de 2005

 use treino;
SELECT datas.dias ,COUNT(a.aluguel_id) numero_alugueis from aluguel a
RIGHT JOIN(
	SELECT 
    ones.num + tens.num + hundreds.num + 1 contagem_1_400,
    -- essa linha de código mostra os 366 dias do ano,
    -- esse comando soma em dias os números retornados a uma data
    DATE_ADD('2005-01-01', INTERVAL (ones.num + tens.num + hundreds.num) DAY) dias
 FROM
 (
    SELECT 0 num UNION ALL
    SELECT 1 num UNION ALL
    SELECT 2 num UNION ALL
    SELECT 3 num UNION ALL
    SELECT 4 num UNION ALL
    SELECT 5 num UNION ALL
    SELECT 6 num UNION ALL
    SELECT 7 num UNION ALL
    SELECT 8 num UNION ALL
    SELECT 9 num
 ) ones
 
 CROSS JOIN
 (
    SELECT 0 num UNION ALL
    SELECT 10 num UNION ALL
    SELECT 20 num UNION ALL
    SELECT 30 num UNION ALL
    SELECT 40 num UNION ALL
    SELECT 50 num UNION ALL
    SELECT 60 num UNION ALL
    SELECT 70 num UNION ALL
    SELECT 80 num UNION ALL
    SELECT 90 num
 ) tens

 CROSS JOIN
 (
    SELECT 0 num UNION ALL
    SELECT 100 num UNION ALL
    SELECT 200 num UNION ALL
    SELECT 300 num
 ) hundreds
 
 where DATE_ADD('2005-01-01', INTERVAL (ones.num + tens.num + hundreds.num) DAY) < '2006-01-01'
 order by 1
) datas on datas.dias = date(a.data_de_aluguel)
GROUP BY 1
ORDER BY 1;

--pegando apenas a data, não as hora, min e sec
SELECT 
	date(data_de_aluguel)
from aluguel


