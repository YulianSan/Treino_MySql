-- Elabore uma consulta que irá gerar o conjunto {1, 2, 3,…, 99, 100}. (Dica:
-- use uma junção cruzada com pelo menos duas subconsultas de cláusula.)


-- os outros exercícios do 10 ñ tem como eu fazer pq ñ tenho a tabela account e nem os dados dentro dela
SELECT ( unidades.num + decimais.num + 1)
FROM 
(
	SELECT 0 num union all
	SELECT 1 num union all
    SELECT 2 num union all
    SELECT 3 num union all
    SELECT 4 num union all
    SELECT 5 num union all
    SELECT 6 num union all
    SELECT 7 num union all
    SELECT 8 num union all
    SELECT 9 num
) unidades
CROSS JOIN
(
	SELECT 0 num union all
	SELECT 10 num union all
    SELECT 20 num union all
    SELECT 30 num union all
    SELECT 40 num union all
    SELECT 50 num union all
    SELECT 60 num union all
    SELECT 70 num union all
    SELECT 80 num union all
    SELECT 90 num

) decimais
ORDER BY 1;

-- mostrar se o usuário está ativo ou inativo

select 
	primeiro_nome, 
    ultimo_nome, 
    CASE
		WHEN ativo = 1 
			THEN 'ATIVO'
            ELSE 'INATIVO'
	END status_cliente
FROM cliente    

-- os dois têm o msm retorno
select 
	primeiro_nome, 
    ultimo_nome, 
    IF(ativo=1,"ATIVO","INATIVO") status_cliente
FROM cliente   

-- posso tbm usar como switch

select 
	primeiro_nome, 
    ultimo_nome, 
    CASE ativo
		WHEN 1
			THEN 'ATIVO 1'
        WHEN 2
			THEN 'ATIVO 2'
        WHEN 3
			THEN 'ATIVO 3'
		ELSE 'INATIVO'
	END status_cliente
FROM cliente    

--invés de dar um retorno em linha, podemos ter um retorno em coluna com o CASE

-- LINHA
-- | col1| col2     |
-- | Mês | Aluguéis |

-- COLUNA
--| Mês      |
--| Aluguéis |

select 
	SUM( CASE monthname(data_de_aluguel) WHEN 'May' THEN 1 ELSE 0 END),
    SUM( CASE monthname(data_de_aluguel) WHEN 'June' THEN 1 ELSE 0 END),
    SUM( CASE monthname(data_de_aluguel) WHEN 'July' THEN 1 ELSE 0 END)
from aluguel a
WHERE a.data_de_aluguel BETWEEN '2005-05-01' AND '2005-08-01'

