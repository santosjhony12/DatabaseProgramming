CREATE DATABASE bdpratica01;
USE bdpratica01;
CREATE TABLE DEPARTAMENTO(
	COD_DEPART INT(4),
    NOME VARCHAR(30) NOT NULL,
    DATA_INICIAL DATE,
    CONSTRAINT pk_cod_depart 
    PRIMARY KEY (COD_DEPART)
);
CREATE TABLE LOCALIZACAO (
	COD_DEPART INT(4),
    LOC_LOCAL VARCHAR(252),
    CONSTRAINT pk_localizacao
    PRIMARY KEY (COD_DEPART, LOC_LOCAL),
    CONSTRAINT fk_cod_depart
    FOREIGN KEY (COD_DEPART)
    REFERENCES DEPARTAMENTO (COD_DEPART)
);
CREATE TABLE FUNCIONARIO (
    COD_FUNC INT (4),
    NOME VARCHAR (30) NOT NULL,
    CPF VARCHAR(15) UNIQUE,
    SALARIO DECIMAL(6,2) CHECK (SALARIO >= 1000.00),
    ENDERECO VARCHAR(252),
    SEXO CHAR(1) CHECK (SEXO IN ('M', 'F')),
    COD_SUPER INT(4),
    COD_DEPART INT(4),
    CONSTRAINT pk_funcionario 
    PRIMARY KEY (COD_FUNC), 
    CONSTRAINT fk_supervisor_funcionario 
    FOREIGN KEY (COD_SUPER) 
    REFERENCES FUNCIONARIO (COD_FUNC),
    CONSTRAINT fk_departamento 
    FOREIGN KEY (COD_DEPART) 
    REFERENCES DEPARTAMENTO (COD_DEPART)
);

CREATE TABLE DEPENDENTE(
	COD_FUNC INT(4),
    SEQ INT (4),
    NOME VARCHAR(100) NOT NULL,
    PARENTESCO VARCHAR(30) NOT NULL,
    DATA_NASC DATE,
    CONSTRAINT pk_dependente
    PRIMARY KEY (COD_FUNC, SEQ),
    CONSTRAINT fk_cod_func 
    FOREIGN KEY (COD_FUNC)
    REFERENCES FUNCIONARIO (COD_FUNC), 
    CONSTRAINT verificar_parentesco
    CHECK(PARENTESCO = 'PAI' OR PARENTESCO = 'MÃE' OR PARENTESCO = 'IRMÃOS' OR PARENTESCO = 'FILHO')
);
CREATE TABLE PROJETO (
	COD_PROJ INT (4),
    COD_DEPART INT (4),
    TITULO VARCHAR(150) NOT NULL,
    DESCRICAO VARCHAR(252),
    DATA_CAD TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_projeto
    PRIMARY KEY (COD_PROJ),
    CONSTRAINT fk_departamento_projeto
    FOREIGN KEY (COD_DEPART)
    REFERENCES DEPARTAMENTO (COD_DEPART)
);

CREATE TABLE PARTICIPA(
	COD_FUNC INT(4),
    COD_PROJ INT (4),
    HORAS VARCHAR(50),
    CONSTRAINT pk_participa
    PRIMARY KEY (COD_FUNC, COD_PROJ),
    CONSTRAINT fk_funcionario
    FOREIGN KEY (COD_FUNC)
    REFERENCES FUNCIONARIO(COD_FUNC),
    CONSTRAINT fk_projeto
    FOREIGN KEY (COD_PROJ)
    REFERENCES PROJETO(COD_PROJ)
);

