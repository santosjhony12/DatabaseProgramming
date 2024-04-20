CREATE DATABASE vendas;
USE vendas;
CREATE TABLE cliente(
	cli_cod INT primary KEY,
    cli_nome VARCHAR(30),
    cli_ativo INT DEFAULT 1,
    cli_data_nasc DATE,
    cli_cpf VARCHAR(11) unique
);

DESC CLIENTE; /**or describe*/
DROP table cliente; /*DELETE TABLE*/

SELECT * FROM information_schema.table_constraints where constraint_schema = 'vendas'; /*It checks the databases's constraints.*/

SELECT * FROM cliente;
INSERT INTO cliente VALUES(1, 'João', 0, '1979-10-30', 4315998802);
INSERT INTO cliente VALUES(2, 'Maria', 0, '2014-2-2',4315998801);
INSERT INTO cliente(cli_cod, cli_nome, cli_data_nasc) VALUES(3, 'José', '2014-2-2');

CREATE TABLE produto (
	pro_id int primary key auto_increment,
    pro_descricao varchar(50) not null,
    pro_quant int not null,
    pro_preco decimal(7,2)
);
CREATE TABLE pedido (
	ped_id int auto_increment primary key,
    ped_data date not null, 
    ped_valor decimal(7,2) not null
);

CREATE TABLE itempedido(
	ped_cod int, 
    pro_cod int, 
    ite_quantidade int, 
    ite_valor decimal(7,2),
    constraint fk_ped_cod foreign key(ped_cod) references pedido(ped_id),
    constraint fk_pro_cod foreign key(pro_cod) references produto(pro_id),
    primary key(pro_cod, ped_cod)
);



USE VENDAS;
SELECT * FROM produto;
SELECT * FROM information_schema.table_constraints where table_schema = 'vendas';

insert into produto values
	(1, 'caneta', 100, 1.0),
	(2, 'caderno', 200, 2.0)
;
SELECT * FROM pedido;
SELECT * FROM itempedido;
INSERT INTO pedido(ped_id, ped_valor, ped_data) values (2, 0, '2024-02-13');
INSERT INTO itempedido VALUES (1, 1, 3, 3.0);
    
ALTER TABLE pedido 
ADD cli_cod int;

ALTER TABLE pedido
ADD CONSTRAINT fk_cli_cod 
FOREIGN KEY (cli_cod) 
REFERENCES cliente(cli_cod);

UPDATE pedido set 
cli_cod = 2 WHERE ped_id = 2;


SELECT p.ped_id, p.ped_data, c.cli_nome from cliente c, pedido p WHERE p.cli_cod = c.cli_cod;