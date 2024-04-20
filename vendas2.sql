create database venda2;

use venda2;
CREATE TABLE cliente (
       cli_codigo           INT auto_increment,
       cli_nome             VARCHAR(30) NOT NULL,
       cli_endereco         VARCHAR(30),
       cli_cidade           VARCHAR(30),
       cli_cep              VARCHAR(10),
       cli_estado           VARCHAR(2),
       cli_cpf              VARCHAR(11),
       PRIMARY KEY (cli_codigo)
);


CREATE TABLE vendedor (
       ven_codigo           INT auto_increment,
       ven_nome             VARCHAR(30) NOT null,
       ven_salario_fixo     DECIMAL(10,2),
       PRIMARY KEY (ven_codigo)
);


CREATE TABLE pedido (
       ped_numero           INT auto_increment,
       ven_codigo           INT,
       cli_codigo           INT,
       ped_prazo_entrega    INT,
       ped_data             DATE,
       ped_valor_total      DECIMAL(10,2),
       PRIMARY KEY (ped_numero), 
       FOREIGN KEY (ven_codigo)
                             REFERENCES vendedor (ven_codigo), 
       FOREIGN KEY (cli_codigo)
                             REFERENCES cliente(cli_codigo)
);


CREATE TABLE telefone (
       tel_codigo           INT auto_increment,
       cli_codigo           INT,
       tel_numero           VARCHAR(18),
       PRIMARY KEY (tel_codigo), 
       FOREIGN KEY (cli_codigo)
                             REFERENCES cliente (cli_codigo)
);


CREATE TABLE produto (
       pro_codigo           INT auto_increment,
       prod_descricao       VARCHAR(10),
       pro_quantidade       INT,
       pro_valor_unidade    DECIMAL(10,2),
       PRIMARY KEY (pro_codigo)
);


CREATE TABLE item_pedido (
       pro_codigo           INT ,
       item_quantidade      INT,
       ped_numero           INT,
       PRIMARY KEY (pro_codigo, ped_numero), 
       FOREIGN KEY (pro_codigo) REFERENCES produto (pro_codigo), 
       FOREIGN KEY (ped_numero) REFERENCES pedido (ped_numero)
);
use venda2;
create table departamento
(dep_id int primary key,
 dep_descricao varchar(30));
drop table departamento;

create table departamento(
	dep_id int primary key,
	dep_descricao varchar(30));

create table funcionario
(fun_cod int primary key,
 fun_nome varchar(20),
 fun_sal decimal(10,2),
 dep_id int references departamento (dep_id));

create table telefone2
(tel_codigo int primary key,
 func_cod int references funcionario(func_cod),
 tel_numero int );

insert into departamento values (1,'RH');
insert into departamento values (2,'Vendas');
insert into departamento values (3,'Informática');
insert into departamento values (4,'Compras');

insert into funcionario values (1,'Paulo',4000.00,1);
insert into funcionario values (2,'Maria',1500.00,2);
insert into funcionario values (3,'João',4000.00,1);
insert into funcionario values (4,'Laura',5000.00,2);
insert into funcionario values (5,'Ana',6000.00,3);
insert into funcionario values (6,'Maria',null,null);


insert into telefone2 values (1,1,39231546);
insert into telefone2 values (2,2,97858999);


insert into vendedor (ven_nome,ven_salario_fixo)
values ('José',1800.00), ('Carlos',2490.00), ('João',2780.00), ('Antônio',9500.00),
		('Felipe',4600.00), ('Jonas',2300.00), ('João',870.00), ('Josias',870.00),
        ('Maurício',2930.00);

insert into produto (prod_descricao,pro_quantidade,pro_valor_unidade)
values ('CANETA',1.00,100), ('APONTADOR',4.00,400), ('REGUA',5.00,600);


insert into cliente (cli_nome,cli_endereco,cli_cidade,cli_cep,cli_estado,cli_cpf)
values('Ana','Rua 17 n.19','Niterói', '24358310','RJ','11111111111'),
('Flávio','Áv. Pres. Vargas 10','São Paulo','22763931','SP','2253412693'),
('Jorge','Rua Caiapo 13','Curitiba','30078500','PR','14512798349'),
('Lúcia','Rua Itabira 123 Loja 9','Belo Horizonte','22124391','MG','2831521393'), 
('Maurício','Av. Paulista 1236 sl/2345','São Paulo','3012683','SP','3281698574'),
('Rodolfo','Largo da Lapa 27 sobrado','Rio de Janeiro','30078900','RJ','1283512823'),
('Beth','Av.Climério n. 45','São Paulo','25679300','SP','3248512673'),
('Paulo','TV. Moraes c/3','Londrina','0','PR','3284822332'),
('Lívio','Av. Beira Mar n. 1256','Florianópolis','300077500','SC','12736571'),
('Susana','Rua Lopes Mendes 12','Niterói','30046500','RJ','2176357123'),
('Renato','Rua Meireles n.123 sl.345','São Paulo','30225900','SP','1327657112'),
('Sebastião','Rua da Igreja n.10','Uberaba','30438700','MG','3217654721'),
('José','Quadra 3 bl. 3 sl. 1003','Brasília','22841650','DF','21763576123');  

insert into pedido(ven_codigo,cli_codigo,ped_prazo_entrega,ped_data)
values (7,1,20,str_to_date('07-10-2000','%d-%m-%Y')),
       (1,7,20,str_to_date('31-07-2012','%d-%m-%Y')),
       (1,7,15,str_to_date('01-06-2013','%d-%m-%Y')),
       (1,5,20,str_to_date('01-07-2013','%d-%m-%Y')),
       (1,7,20,str_to_date('01-08-2013','%d-%m-%Y')),
       (2,7,15,str_to_date('30-09-2013','%d-%m-%Y')),
       (3,7,30,str_to_date('30-06-2014','%d-%m-%Y')),
       (5,9,30,str_to_date('01-08-2015','%d-%m-%Y')),
       (7,1,20,str_to_date('12-04-2019','%d-%m-%Y')),
       (8,2,30,str_to_date('12-04-2021','%d-%m-%Y'));
       
      
insert into item_pedido(pro_codigo,item_quantidade,ped_numero) 
values (1,9,10), (2,8,10),(3,6,1),(3,7,9);


insert into telefone(cli_codigo,tel_numero)
values (1,'3923-1546'), (2,'97858999'), (2,'81267270'), (3,'82567896'), (8,'87589658');
update produto 
set pro_valor_unidade = 4 where pro_codigo =1;

SELECT * FROM produto where pro_codigo = 1;
rollback; /*VOLTA O ULTIMO COMMIT (DML)*/
SELECT * FROM produto;
SELECT p.prod_descricao, p.pro_valor_unidade, p.pro_valor_unidade*1.1 as valor_acrescido FROM produto p;
commit; /*CONFIRMA A TRANSAÇÃO*/

SELECT * FROM pedido where ped_data = '2000-10-07';
SELECT count(*) as quant_cliente FROM cliente;
SELECT c.cli_nome, p.ped_data FROM cliente c, pedido p WHERE c.cli_codigo = p.cli_codigo;

use venda2;
/*COM INNER JOIN*/
SELECT c.cli_nome, p.ped_data from cliente c inner join pedido p on c.cli_codigo = p.cli_codigo;

/*COM WHERE*/
SELECT c.cli_codigo, c.cli_nome, t.tel_numero
from cliente c, telefone t where c.cli_codigo = t.cli_codigo;

/*COM INNER JOIN*/
SELECT c.cli_codigo, c.cli_nome, t.tel_numero
from cliente c inner join telefone t on c.cli_codigo = t.cli_codigo;

/*COM LEFT JOIN - > LEFT JOIN A PRINCIPAL COLUNA QUE EU ME IMPORTO É A DA ESQUERDA, NESSE CASO, CLIENTE. 
ENTÃO, MESMO QUE O TELEFONE SEJA NULO, RETORNO TODOS OS CLIENTES*/
SELECT c.cli_codigo, c.cli_nome, t.tel_numero
from cliente c left outer join telefone t on c.cli_codigo = t.cli_codigo;

/*COM RIGHT JOIN*/
SELECT c.cli_codigo, c.cli_nome, t.tel_numero
from cliente c right outer join telefone t on c.cli_codigo = t.cli_codigo;

/*COM RIGHT JOIN*/
SELECT c.cli_codigo, c.cli_nome, t.tel_numero
from telefone t right outer join cliente c on c.cli_codigo = t.cli_codigo;

SELECT f.fun_cod, f.fun_nome, d.dep_descricao from funcionario f right outer join departamento d
on f.dep_id = d.dep_id;

/*VERIFICANDO COM OS ID'S NULL*/
SELECT f.fun_cod, f.fun_nome, d.dep_descricao from departamento d left outer join funcionario f
on f.dep_id = d.dep_id where f.dep_id is null;

SELECT f.fun_cod, f.fun_nome, d.dep_descricao from departamento d right outer join funcionario f
on f.dep_id = d.dep_id where f.dep_id is null;


/*UNIR SELECTS COM ESTRUTURAS IGUAIS*/
SELECT f.fun_cod, f.fun_nome, d.dep_descricao from departamento d left outer join funcionario f
on f.dep_id = d.dep_id where f.dep_id is null
union
SELECT f.fun_cod, f.fun_nome, d.dep_descricao from departamento d right outer join funcionario f
on f.dep_id = d.dep_id where f.dep_id is null;

/*JUNÇÃO COM MAIS DE 2 TABELAS*/
SELECT f.fun_cod, f.fun_nome, d.dep_descricao, t.tel_numero from departamento d right outer join funcionario f
on f.dep_id = d.dep_id left outer join telefone2 t on t.func_cod = f.fun_cod order by f.fun_cod;

SELECT f.fun_cod, f.fun_nome, d.dep_descricao, t.tel_numero from departamento d left outer join funcionario f
on f.dep_id = d.dep_id inner join telefone2 t on t.func_cod = f.fun_cod order by f.fun_cod;

SELECT f.fun_cod, f.fun_nome, d.dep_descricao, t.tel_numero from departamento d left outer join funcionario f
on f.dep_id = d.dep_id left outer join telefone2 t on t.func_cod = f.fun_cod;