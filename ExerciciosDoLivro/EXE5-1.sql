-- SELECT c.first_name, c.last_name, a.address, ct.city
--     FROM customer c
    
--     INNER JOIN address <1>
--         ON c.address_id = a.address_id
--     INNER JOIN city ct
--         ON a.city_id = <2>
--     WHERE a.district = 'California';


SELECT c.primeiro_nome, c.ultimo_nome, e.endereco, cd.cidade
    FROM cliente c
INNER JOIN endereco e
	ON c.endereco_id = e.endereco_id
INNER JOIN cidade cd
	ON e.cidade_id = cd.cidade_id
WHERE e.bairro = 'California';

