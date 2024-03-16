CREATE DATABASE bdpratica01;
USE bdpratica01;

CREATE TABLE departamento(
	COD_DEPART INT(4),
    NOME VARCHAR(30) NOT NULL,
    DATA_INICIAL DATE,
    CONSTRAINT pk_cod_depart 
    PRIMARY KEY (COD_DEPART)
);
CREATE TABLE funcionario (
	COD_FUNC INT (4),
    NOME VARCHAR (30)
    
);
describe departamento;