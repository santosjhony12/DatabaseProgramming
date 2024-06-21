-- PRATICA 05 - JHONY SANTOS DE SOUZA 

USE CATALOGO;

-- EXERCICIO 01 
SELECT grav_nome FROM GRAVADORA WHERE grav_codigo IN (
SELECT grav_codigo FROM cd where cd_preco_venda > 80.0
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
SELECT cd_nome FROM cd WHERE cd_preco_venda < any (
	SELECT cd_preco_venda FROM cd WHERE grav_codigo = 10
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
SELECT cd.cd_nome, cd.cd_data_lancamento, grav.grav_nome FROM cd cd INNER JOIN gravadora grav ON cd.grav_codigo = grav.grav_codigo WHERE cd.cd_data_lancamento BETWEEN '2020-02-01' AND '2024-06-20';

-- EXERCICIO 07
SELECT cd.cd_nome, grav.grav_nome FROM CD cd LEFT JOIN gravadora grav ON cd.grav_codigo = grav.grav_codigo;

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


INSERT INTO CD_CATEGORIA 
VALUES
	(4, 31.00, 40.00),
    (5, 31.00, 40.00);
ROLLBACK;
INSERT INTO CD_CATEGORIA 
VALUES
	(6, 41.00, 50.00);
    
ROLLBACK;
INSERT INTO CD_CATEGORIA 
VALUES
	(7, 51.00, 60.00);
UPDATE CD_CATEGORIA SET MENOR_PRECO = 52.00 WHERE CAT_CODIGO = 7;
COMMIT;
INSERT INTO CD_CATEGORIA VALUES(8,61.00, 70.00);
ROLLBACK;
COMMIT;
SELECT * FROM CD_CATEGORIA;
