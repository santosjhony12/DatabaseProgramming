-- PRATICA 3 - JHONY SANTOS DE SOUZA e VITORIA BRANCATTI RAMOS LOPES BATISTA - PROGRAMAÇÃO DE BANCO DE DADOS


-- EXERCICIO 1
SELECT p.pes_nome FROM pessoa p INNER JOIN emprestimo e ON p.pes_cod = e.pes_cod AND e.emp_cod = 1;

-- EXERCICIO 2
SELECT * FROM editora ORDER BY edi_descricao ASC;

-- EXERCICIO 3
SELECT liv_titulo FROM livro WHERE liv_titulo LIKE 'a%';

-- EXERCICIO 4
SELECT liv_titulo FROM livro WHERE liv_titulo LIKE 'a%' AND anopublicacao > 2013;

-- EXERCICIO 5 
SELECT COUNT(*) FROM telefone WHERE tel_ddd = 12;

-- EXERCICIO 6
SELECT a.pes_nro_matricula, COUNT(e.pes_cod) AS quantidade FROM aluno a LEFT JOIN emprestimo e ON a.pes_cod = e.pes_cod GROUP BY a.pes_nro_matricula;

-- EXERCICO 7
SELECT e.edi_cod, e.edi_descricao, l.liv_cod FROM editora e LEFT JOIN livro l ON e.edi_cod = l.edi_cod; 

-- EXERCICIO 8
SELECT ie.exe_cod, ex.exe_descricao
FROM emprestimo e
JOIN item_emprestimo ie ON e.emp_cod = ie.emp_cod
JOIN exemplar ex ON ie.exe_cod = ex.exe_cod
WHERE e.emp_data_emprestimo = '2015-11-03';

-- EXERCICIO 9
SELECT l.* FROM livro l INNER JOIN exemplar e ON e.liv_cod = l.liv_cod GROUP BY l.liv_cod HAVING COUNT(e.liv_cod) > 3;

-- EXERCICIO 10
SELECT p.pes_nome, prof.titulacao, t.tel_numero 
FROM pessoa p 
RIGHT JOIN professor prof ON p.pes_cod = prof.pes_cod 
LEFT JOIN telefone t ON prof.pes_cod = t.pes_cod;

-- EXERCICIO 11
SELECT * FROM livro 
WHERE anopublicacao = (SELECT MIN(anopublicacao) FROM livro);

-- EXERCICIO 12
SELECT p.pes_nome, COUNT(e.emp_cod) AS total_emprestimos 
FROM pessoa p 
INNER JOIN emprestimo e ON p.pes_cod = e.pes_cod 
GROUP BY p.pes_cod 
ORDER BY total_emprestimos DESC 
LIMIT 1;

-- EXERCICIO 13
SELECT l.liv_titulo, COUNT(l.liv_cod) FROM exemplar e 
INNER JOIN livro l ON e.liv_cod = l.liv_cod GROUP BY e.liv_cod;  

-- EXERCICIO 14 
SELECT liv_titulo FROM livro WHERE liv_titulo LIKE 'a%' AND anopublicacao > 2011;

-- EXERCICIO 15
SELECT l.liv_titulo
FROM Emprestimo e
JOIN ITEM_EMPRESTIMO ie ON e.emp_cod = ie.emp_cod
JOIN Exemplar ex ON ie.exe_cod = ex.exe_cod
JOIN Livro l ON ex.liv_cod = l.liv_cod
WHERE e.pes_cod = 1;

-- EXERCICIO 16 

-- Pergunta 1: INNER JOIN
-- Quais são os títulos dos livros emprestados, juntamente com os códigos de exemplares?
SELECT l.liv_titulo, ex.exe_cod
FROM Livro l
INNER JOIN Exemplar ex ON l.liv_cod = ex.liv_cod
INNER JOIN ITEM_EMPRESTIMO ie ON ex.exe_cod = ie.exe_cod;

-- Pergunta 2: LEFT JOIN
-- Liste todos os títulos de livros e seus respectivos códigos de exemplares, mesmo que não tenham sido emprestados.
SELECT l.liv_titulo, ex.exe_cod
FROM Livro l
LEFT JOIN Exemplar ex ON l.liv_cod = ex.liv_cod;

-- Pergunta 3: RIGHT JOIN
-- Liste todos os códigos de exemplares e os títulos dos livros correspondentes, mesmo que não tenham livros associados.
SELECT ex.exe_cod, l.liv_titulo
FROM Exemplar ex
RIGHT JOIN Livro l ON ex.liv_cod = l.liv_cod;

-- Pergunta 4: FULL OUTER JOIN (usando UNION)
-- Liste todos os títulos de livros e seus respectivos códigos de exemplares, incluindo aqueles que não têm correspondência em nenhuma das tabelas.
SELECT l.liv_titulo, ex.exe_cod
FROM Livro l
LEFT JOIN Exemplar ex ON l.liv_cod = ex.liv_cod
UNION
SELECT l.liv_titulo, ex.exe_cod
FROM Exemplar ex
RIGHT JOIN Livro l ON ex.liv_cod = l.liv_cod;

-- Pergunta 5: LEFT JOIN com filtro de NULL
-- Liste os títulos de livros que não têm exemplares associados.
SELECT l.liv_titulo
FROM Livro l
LEFT JOIN Exemplar ex ON l.liv_cod = ex.liv_cod
WHERE ex.exe_cod IS NULL;

-- Pergunta 6: RIGHT JOIN com filtro de NULL
-- Liste os códigos de exemplares que não têm livros associados.
SELECT ex.exe_cod
FROM Exemplar ex
RIGHT JOIN Livro l ON ex.liv_cod = l.liv_cod
WHERE l.liv_cod IS NULL;

-- Pergunta 7: FULL OUTER JOIN com filtros de NULL (usando UNION)
-- Liste todos os títulos de livros e os códigos de exemplares que não têm correspondência em nenhuma das tabelas.
SELECT l.liv_titulo, ex.exe_cod
FROM Livro l
LEFT JOIN Exemplar ex ON l.liv_cod = ex.liv_cod
WHERE ex.exe_cod IS NULL
UNION
SELECT l.liv_titulo, ex.exe_cod
FROM Exemplar ex
RIGHT JOIN Livro l ON ex.liv_cod = l.liv_cod
WHERE l.liv_cod IS NULL;
