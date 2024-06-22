-- PRATICA 05 - JHONY SANTOS DE SOUZA E VITÓRIA BRANCATTI LOPES RAMOS BATISTA

USE CATALOGO;

-- EXERCICIO 01 
SELECT 
	grav_nome 
FROM 
	GRAVADORA 
WHERE grav_codigo IN (
	SELECT 
		grav_codigo 
	FROM cd 
    WHERE cd_preco_venda > 80.0
);

-- EXERCICIO 02
SELECT 
    CD.cd_codigo, 
    CD.cd_nome, 
    CD.cd_preco_venda, 
    Gravadora.grav_nome
FROM 
    CD
JOIN 
    (
        SELECT 
            grav_codigo,
            MAX(cd_preco_venda) AS max_preco
        FROM 
            CD
        GROUP BY 
            grav_codigo
    ) AS MaxPrecoGravadora ON CD.grav_codigo = MaxPrecoGravadora.grav_codigo
JOIN 
    Gravadora ON CD.grav_codigo = Gravadora.grav_codigo
WHERE 
    CD.cd_preco_venda = MaxPrecoGravadora.max_preco;



-- EXERCICIO 03
SELECT 
	cd_nome 
FROM cd 
WHERE cd_preco_venda < ANY (
	SELECT 
		cd_preco_venda 
	FROM cd 
    WHERE grav_codigo = 10
);

-- EXERCICIO 04
SELECT * 
FROM 
	CD 
WHERE cd_preco_venda < (
	SELECT 
		AVG(cd_preco_venda) 
	FROM 
		CD
);

-- EXERCICIO 05
SELECT  
	UPPER(cd_nome) 
FROM 
	CD 
WHERE 
	cd_preco_venda > 10.00
OR
	grav_codigo = 3 
ORDER BY
	cd_nome DESC;

-- EXERCICO 06 
SELECT 
    cd.cd_nome, 
    cd.cd_data_lancamento, 
    grav.grav_nome 
FROM 
    cd cd 
INNER JOIN 
    gravadora grav 
ON 
    cd.grav_codigo = grav.grav_codigo 
WHERE 
    cd.cd_data_lancamento BETWEEN '2020-02-01' AND '2024-06-20';

-- EXERCICIO 07
SELECT 
    cd.cd_nome, 
    grav.grav_nome 
FROM 
    CD cd 
LEFT JOIN 
    gravadora grav 
ON 
    cd.grav_codigo = grav.grav_codigo;

-- EXERCICIO 08
SELECT 
	cd.cd_codigo, COUNT(mus.cd_codigo) AS QUANT_MUSICAS
FROM 
	CD cd 
INNER JOIN 
	faixa mus 
ON mus.cd_codigo = cd.cd_codigo 
GROUP BY cd_codigo;

-- EXERCICIO 09
SELECT 
	cd.cd_codigo, cd.cd_nome, 
    CASE 
		WHEN cd.cd_preco_venda BETWEEN cat.menor_preco AND cat.maior_preco THEN cat.cat_codigo
        ELSE NULL
	END AS categoria_cd
FROM 
	CD cd 
INNER JOIN 
	CD_CATEGORIA cat
ON 
	cd.cd_preco_venda BETWEEN cat.menor_preco AND cat.maior_preco;

-- EXERCICIO 10
SELECT c1.cd_nome AS cd_gravado, c2.cd_nome AS cd_indicado
FROM CD c1
LEFT JOIN CD c2 ON c1.cd_indicado = c2.cd_codigo;


-- EXERCICIO 11
-- cat_codigo | menor_preco | maior_preco
--     1      |    10.00    |	15.00
--     2	  |    16.00	|   20.00
--     3	  |    21.00	|   30.00
--     7	  |    52.00	|   60.00

-- EXERCICIO 12 
SELECT 
    CD.cd_codigo,
    CD.cd_nome,
    CD.cd_preco_venda,
    GRAVADORA.grav_nome,
    SUM(MUSICA.mus_duracao) AS tempo_duracao_total
FROM 
    CD
INNER JOIN 
    GRAVADORA ON CD.grav_codigo = GRAVADORA.grav_codigo
INNER JOIN 
    FAIXA ON CD.cd_codigo = FAIXA.cd_codigo
INNER JOIN 
    MUSICA ON FAIXA.mus_codigo = MUSICA.mus_codigo
WHERE 
    CD.cd_codigo = 101
GROUP BY 
    CD.cd_codigo, CD.cd_nome, CD.cd_preco_venda, GRAVADORA.grav_nome;
 
 
-- EXERCICO 13
SELECT 
    grav.grav_nome 
FROM 
    GRAVADORA grav 
WHERE 
    grav.grav_codigo IN (
        SELECT 
            cd.grav_codigo 
        FROM 
            CD cd 
        GROUP BY 
            cd.grav_codigo 
        HAVING 
            COUNT(cd.cd_codigo) > 2
);

-- EXERCICIO 14
SELECT 
    mus_nome 
FROM 
    musica 
WHERE 
    mus_duracao = (
        SELECT 
            MAX(mus_duracao) 
        FROM 
            musica
);

-- EXERCICIO 15
SELECT 
    mus.mus_nome, 
    fa.faixa_numero, 
    cd.cd_nome 
FROM 
    musica mus 
INNER JOIN 
    faixa fa 
ON 
    mus.mus_codigo = fa.mus_codigo 
INNER JOIN 
    CD cd 
ON 
    fa.cd_codigo = cd.cd_codigo 
WHERE 
    cd.cd_codigo IN (102, 103);

-- EXERCICIO 16 
SELECT 
    aut_codigo AS codigo,
    aut_nome AS nome
FROM 
    AUTOR
WHERE 
    aut_codigo < 10

UNION

SELECT 
    mus_codigo AS codigo,
    mus_nome AS nome
FROM 
    MUSICA
WHERE 
    mus_codigo < 15;

