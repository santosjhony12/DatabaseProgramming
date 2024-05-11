-- ALUNO: JHONY SANTOS DE SOUZA - 3º SEMESTRE BD - 1ª AVALIAÇÃO PROGRAMAÇÃO DE BANCO DE DADOS - PROFESSORA JULIANA

-- EXERCICIO 1 
SELECT ed.edi_descricao FROM editora ed, livro l WHERE l.edi_cod = ed.edi_cod AND l.liv_cod =1;

-- EXERCICIO 2 
SELECT COUNT(pes_cod) AS quant_pessoas FROM telefone WHERE tel_ddd = 12;

-- EXERCICIO 3
SELECT p.pes_nome FROM pessoa p, emprestimo e WHERE e.pes_cod = p.pes_cod AND e.emp_cod = 1;

-- 	EXERCICIO 4
SELECT p.pes_nome, a.pes_nro_matricula, t.tel_ddd, t.tel_numero FROM pessoa p 
RIGHT OUTER JOIN aluno a ON a.pes_cod = p.pes_cod 
LEFT OUTER JOIN telefone t ON t.pes_cod =  a.pes_cod;

-- EXERCICIO 5
CREATE TABLE sessao(
	idSessao INT(4),
    dataSessao DATE,
    horaSessao VARCHAR(4),
    decisao VARCHAR(4),
    CONSTRAINT pk_sessao
    PRIMARY KEY (idSessao)
);

CREATE TABLE partido(
	idPartido INT(4),
    siglaPartido INT(4),
    descricaoPartido VARCHAR(30),
    CONSTRAINT pk_partido
    PRIMARY KEY (idPartido)
);

CREATE TABLE deputado(
	idDeputado INT(4),
    idPartido INT(4),
    nomeDeputado VARCHAR(30),
    CONSTRAINT pk_deputado
    PRIMARY KEY (idDeputado),
    CONSTRAINT fk_partido
    FOREIGN KEY (idPartido)
    REFERENCES partido(idPartido)
);

CREATE TABLE participacao(
	idSessao INT(4),
    idDeputado INT(4),
    CONSTRAINT pk_participacao
    PRIMARY KEY (idSessao, idDeputado),
    CONSTRAINT fk_sessao
    FOREIGN KEY (idSessao)
    REFERENCES sessao(idSessao),
    CONSTRAINT fk_deputado
    FOREIGN KEY (idDeputado)
    REFERENCES deputado(idDeputado)
);

-- EXERCICIO 6
ALTER TABLE partido
ADD CONSTRAINT uk_siglapartido
UNIQUE (siglaPartido);

-- EXERCICO 7
SELECT d.nomeDeputado, p.siglaPartido FROM deputado d, partido p;