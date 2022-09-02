-- Reescreva a consulta a seguir, que usa uma expressão case simples, para
-- que os mesmos resultados sejam alcançados usando uma expressão de caso pesquisada.
-- Tente usar o mínimo possível de cláusulas when

-- SELECT name,
--     CASE name
--         WHEN 'English' THEN 'latin1'
--         WHEN 'Italian' THEN 'latin1'
--         WHEN 'French' THEN 'latin1'
--         WHEN 'German' THEN 'latin1'
--         WHEN 'Japanese' THEN 'utf8'
--         WHEN 'Mandarin' THEN 'utf8'
--         ELSE 'Unknown'
--     END character_set
-- FROM language;

use treino;
select
	case
		when nome IN('English','Italian','French', 'German') then 'latin1'
        when nome IN('Japanese','Mandarin') then 'utf8'
        else 'Unknown'
	end character_set
from idioma;
