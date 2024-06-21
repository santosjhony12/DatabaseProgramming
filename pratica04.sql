-- PRATICA 4 - JHONY SANTOS DE SOUZA E VITÓRIA BRANCATTI RAMOS BATISTA
-- Professora, como conversamos, eu realizei a atividade na sexta feira dia 07, como mostra no print, porém esqueci de enviar.
-- Conversei com a senhora em sala e me deixou enviar. Obrigado <3 

-- EXERCICIO 1
CREATE SCHEMA EMPRESA;
USE EMPRESA;
CREATE TABLE ESTADO(
	est_cod int(4) primary key,
    est_estado varchar(20)
);
CREATE TABLE CIDADE(
	cid_cod int(4),
    est_cod int(4), 
    cid_nome varchar(30),
    CONSTRAINT fk_estado_cidade
    FOREIGN KEY (est_cod) REFERENCES estado(est_cod),
    CONSTRAINT pk_cidade
    PRIMARY KEY (cid_cod, est_cod)
);

CREATE TABLE DEPARTAMENTO(
	dep_cod int(4) primary key,
    dep_descricao varchar(20)
);

CREATE TABLE CARGO(
	car_cod int(4) primary key,
    car_descricao varchar(20)
);

CREATE TABLE FUNCIONARIO (
	fun_cod int(4) primary key,
    fun_logradouro varchar(30),
    fun_nome varchar(30),
    fun_salario decimal(8,2),
    car_cod int(4),
    fun_cep int(4),
    fun_nro int(4),
    cid_cod int(4),
    est_cod int(4),
    dep_cod int(4),
    CONSTRAINT fk_cargo_funcionario
    FOREIGN KEY (car_cod) REFERENCES cargo(car_cod),
    CONSTRAINT fk_cidade_funcionario
    FOREIGN KEY (cid_cod, est_cod) REFERENCES cidade (cid_cod, est_cod),
    CONSTRAINT fk_departamento_funcionario
    FOREIGN KEY (dep_cod) REFERENCES departamento(dep_cod)
);

-- EXERCICIO 2
CREATE VIEW FUNCIONARIO_VIEW AS SELECT f.fun_cod, f.fun_nome, f.fun_logradouro, c.cid_nome, e.est_estado, car.car_descricao, d.dep_descricao
FROM funcionario f 
LEFT OUTER JOIN cargo car ON car.car_cod = f.car_cod
LEFT OUTER JOIN departamento d ON d.dep_cod = f.dep_cod
LEFT OUTER JOIN cidade c ON c.cid_cod = f.cid_cod 
LEFT OUTER JOIN estado e ON e.est_cod = c.est_cod; 

-- EXERCICIO 3 
SELECT * FROM FUNCIONARIO_VIEW;

-- EXERCICIO 4
SELECT f.fun_cod, f.fun_nome, f.fun_logradouro, c.cid_nome, e.est_estado, car.car_descricao, d.dep_descricao
FROM funcionario f 
LEFT OUTER JOIN cargo car ON car.car_cod = f.car_cod
LEFT OUTER JOIN departamento d ON d.dep_cod = f.dep_cod
LEFT OUTER JOIN cidade c ON c.cid_cod = f.cid_cod 
LEFT OUTER JOIN estado e ON e.est_cod = c.est_cod; 

-- EXERCICIO 5
INSERT INTO FUNCIONARIO(fun_cod, fun_nome, fun_logradouro) VALUES (4, 'Jhony', 'Rua Alberto');
SELECT * FROM FUNCIONARIO_VIEW;

-- EXERCICIO 6
ALTER TABLE FUNCIONARIO 
ADD COLUMN fun_obs VARCHAR(255);

CREATE OR REPLACE VIEW FUNCIONARIO_VIEW AS SELECT f.fun_cod, f.fun_nome, f.fun_logradouro, c.cid_nome, e.est_estado, car.car_descricao, d.dep_descricao, f.fun_obs
FROM funcionario f 
LEFT OUTER JOIN cargo car ON car.car_cod = f.car_cod
LEFT OUTER JOIN departamento d ON d.dep_cod = f.dep_cod
LEFT OUTER JOIN cidade c ON c.cid_cod = f.cid_cod 
LEFT OUTER JOIN estado e ON e.est_cod = c.est_cod;


-- EXERCICIO 7
SELECT * FROM information_schema.views WHERE table_schema = 'EMPRESA' and table_name='FUNCIONARIO_VIEW';
show FULL TABLES IN EMPRESA WHERE TABLE_TYPE LIKE 'VIEW';

-- EXERCICIO 8 

-- ( ) A. Por meio de uma view os dados apenas podem ser vistos. 
-- ( ) B.Tabela virtual na qual os dados estão fisicamente armazenados.
-- (x) C.Utilizada para evitar que usuários não autorizados tenham acesso a todos os dados de uma tabela.
-- ( ) D. Para remover uma view utilizamos o seguinte comando delete view <nome da view>.