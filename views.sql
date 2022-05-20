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