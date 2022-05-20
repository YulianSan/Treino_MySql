
-- Exercício 6-1 Se o conjunto A = {L M N O P} e o conjunto B = {P Q R S T}, quais conjuntos são gerado pelas seguintes operações?

-- A union B
-- A union all B
-- A intersect B
-- A except B;

-- Na union ele vai juntar todos os dados, removendo os repetidos
-- EX:
select * from A
union
select * from B;
-- retorna todos os dados, pq tem a msm quantidade de campos

-- Na union all ele vai juntar todos os dados, mesmo sendo campos duplicados
-- EX:
select * from A
union
select * from B;
-- retorna todos os dados, pq tem a msm quantidade de campos

-- Na union all ele vai juntar todos os dados, mesmo sendo campos duplicados
-- EX:
select * from A
intersect
select * from B;
-- retorna todos os dados, pq tem a msm quantidade de campos