#  criando banco

create database Ecommerce;

use Ecommerce;

create table Cliente(
	idCliente int not null auto_increment unique,
	Primeiro_nome VARCHAR(10) not null,
    Sobrenome VARCHAR(10) not null,
    Data_Nascimento DATE not null,
    constraint pk_cliente primary key (idCliente)
    );
      
create table CPF_CNPJ(
	numero varchar(14) not null unique,
    idCliente int not null,
    tipo ENUM('CPF','CNPJ') not null,
    constraint cadastro_unico primary key (numero, IdCliente),
    foreign key (idCliente) references Cliente(idCliente) on update cascade
    );

create table cartoes(
	numero_cartao char(16) not null unique,
    nome_titular varchar(45) not null,
    Data_validade DATE not null,
    idCliente int not null,
    primary key (numero_cartao),
    foreign key (idCliente) references Cliente(idCliente) on update cascade
    );
    
create table enderecos(
	idCliente int not null,
    cep char(8) not null,
    rua varchar(50) not null,
    bairro varchar(20) not null,
    cidade varchar(20) not null,
    numero varchar(5) not null,
    complemento varchar(100),
    primary key (idCliente, cep),
    foreign key (idCliente) references Cliente(idCliente) on update cascade
	);
    
create table entrega(
	idEntrega int not null unique,
    status_entrega ENUM('em separação','entregue a transportadora','enviado','rota de entrega','entregue') default ('entregue') not null,
    codigo_rastreio varchar(25) not null,
    previsao_entrega date not null,
    primary key (idEntrega)
    );

#a coluna relacionada a valor_total na tabela Pedido foi removida posteriormente, achei melhor torná-la um atributo derivado.

Create table Pedido(
	idPedido int not null unique,
    status_pedido enum('pendente','em andamento','realizado') not null default ('pendente'),
    descricao varchar(50),
    valor_total float not null,
    idCliente int not null,
    idEntrega int,
    Data_pedido date not null,
    primary key (idPedido),
    foreign key (idCliente) references Cliente(idCliente),
    foreign key (idEntrega) references Entrega(idEntrega)
);

#a tabela produtos_por_pedido tabela foi adicionada posteriormente, quando pensei em realizar uma query relacionando produtos e pedidos, notei que havia esquecido sua criação.

create table produtos_do_pedido(
	idpedido int not null,
    idProduto int not null,
    qtd int not null default 1,
    primary key (idpedido, idProduto),
    foreign key (idpedido) references pedido(idpedido) on update cascade,
    foreign key (idProduto) references produto(idProduto) on update cascade
);

create table produto(
	idProduto int not null unique,
    Pnome varchar(50) not null,
    Categoria varchar(20) not null,
    descricao varchar(100),
    valor float,
    primary key (idProduto)
);

create table fornecedor(
	idFornecedor int not null unique,
    RS varchar(50) not null,
    CNPJ char(13) not null unique,
    primary key (idFornecedor)
);

create table produtos_fornecidos(
	idProduto int not null,
    idFornecedor int not null,
    primary key (idProduto, idFornecedor),
    unique (idProduto, idFornecedor),
    foreign key (idProduto) references Produto(idProduto) on update cascade,
    foreign key (idFornecedor) references Fornecedor(idFornecedor)on update cascade
);

create table terceirizado(
	idTerceirizado int not null unique,
    RS varchar(50) not null,
    localidade varchar(50) not null,
    primary key (idTerceirizado)
);

create table produto_terceirizado(
	idTerceirizado int not null,
    idProduto int not null,
    primary key (idTerceirizado, idProduto),
    unique (idTerceirizado, idProduto),
    foreign key (idTerceirizado) references Terceirizado(idTerceirizado) on update cascade,
    foreign key (idProduto) references Produto(idProduto) on update cascade
);

create table estoque(
	idEstoque int not null unique,
    cep char(8) not null,
    primary key (idEstoque)
);

create table localidade_produto(
	idEstoque int not null,
    idProduto int not null,
    qtd_disponivel int not null default 0,
    primary key (idEstoque, IdProduto),
    foreign key (idEstoque) references Estoque(idEstoque) on update cascade,
    foreign key (idProduto) references Produto(idProduto) on update cascade,
    unique (idEstoque, IdProduto)
);

#inserção de valores nas tabelas, utilizei do CHATGPT para ajudar a gerar as inserções

INSERT INTO Cliente (Primeiro_nome, Sobrenome, Data_Nascimento) VALUES
('João', 'Silva', '1990-05-10'),
('Maria', 'Oliveira', '1985-11-22'),
('Pedro', 'Santos', '1978-03-15'),
('Empresa', 'InovaTech', '2001-09-30'),
('Carlos', 'Lima', '1992-07-08');

select * from Cliente;

INSERT INTO CPF_CNPJ (numero, tipo, idCliente) VALUES
('12345678901', 'CPF', 1),
('98765432100', 'CPF', 2),
('11122233344', 'CPF', 3),
('12345678000199', 'CNPJ', 4),
('55566677788', 'CPF', 5);

select * from CPF_CNPJ;

INSERT INTO enderecos (idCliente, cep, rua, bairro, cidade, numero, complemento) VALUES
(1, '12345678', 'Rua A', 'Centro', 'São Paulo', '100', 'Apto 101'),
(2, '87654321', 'Av. Brasil', 'Jardim', 'Rio de Janeiro', '200', NULL),
(3, '13579135', 'Rua das Flores', 'Vila Nova', 'Belo Horizonte', '33', ''),
(4, '11223344', 'Av. Empresarial', 'Industrial', 'Curitiba', '500', 'Bloco C'),
(5, '99887766', 'Rua Verde', 'Residencial', 'Porto Alegre', '55', 'Casa 2');

INSERT INTO enderecos (idCliente, cep, rua, bairro, cidade, numero, complemento) VALUES
(2, '22000000', 'Av. Copacabana', 'Zona Sul', 'Rio de Janeiro', '300', 'Cobertura');

INSERT INTO enderecos (idCliente, cep, rua, bairro, cidade, numero, complemento) VALUES
(5, '90200000', 'Rua do Leste', 'Sulamérica', 'Porto Alegre', '85', 'Fundos');

INSERT INTO cartoes (numero_cartao, nome_titular, Data_validade, idCliente) VALUES
('1111222233334444', 'João Silva', '2028-12-01', 1),
('5555666677778888', 'Maria Oliveira', '2027-06-15', 2),
('9999888877776666', 'Pedro Santos', '2029-03-10', 3),
('2222333344445555', 'InovaTech LTDA', '2030-01-01', 4),
('4444555566667777', 'Carlos Lima', '2026-11-25', 5);

INSERT INTO cartoes (numero_cartao, nome_titular, Data_validade, idCliente) VALUES
('5678567856785678', 'Maria Oliveira', '2029-10-30', 2);

INSERT INTO cartoes (numero_cartao, nome_titular, Data_validade, idCliente) VALUES
('2345234523452345', 'Pedro Santos', '2026-08-15', 3);

INSERT INTO entrega (idEntrega, status_entrega, codigo_rastreio, previsao_entrega) VALUES
(1, 'em separação', 'BR123456789', '2025-08-10'),
(2, 'enviado', 'BR987654321', '2025-08-08'),
(3, 'entregue', 'BR000111222', '2025-08-05'),
(4, 'rota de entrega', 'BR333444555', '2025-08-07'),
(5, 'entregue a transportadora', 'BR999888777', '2025-08-09');

INSERT INTO Pedido (idPedido, status_pedido, descricao, valor_total, idCliente, idEntrega, Data_pedido) VALUES
(1, 'pendente', 'Compra de periféricos', 249.90, 1, 1, '2025-08-06'),
(2, 'realizado', 'Acessórios variados', 89.90, 2, 2, '2025-08-05'),
(3, 'realizado', 'Servidor empresarial', 1249.50, 4, 3, '2025-08-04'),
(4, 'em andamento', 'Mouse e teclado', 349.80, 3, 4, '2025-08-06'),
(5, 'pendente', 'Pedido gamer completo', 879.70, 5, 5, '2025-08-06'),
(6, 'em andamento', 'Teclado mecânico extra', 199.90, 1, 2, '2025-08-06'),
(7, 'realizado', 'Atualização de setup', 1099.00, 1, 3, '2025-08-05');

INSERT INTO produto (idProduto, Pnome, Categoria, descricao, valor) VALUES
(1, 'Mouse Gamer', 'Periféricos', 'Mouse com RGB e botões extras', 149.90),
(2, 'Teclado Mecânico', 'Periféricos', 'Switches azuis, layout ABNT2', 199.90),
(3, 'Mousepad XXL', 'Acessórios', 'Grande, com LED RGB', 79.90),
(4, 'Servidor Dell', 'Hardware', 'Servidor rack com 64GB RAM', 1249.50),
(5, 'Headset Gamer', 'Áudio', 'Som surround 7.1 com microfone', 229.90),
(6, 'Webcam HD', 'Imagem', '1080p com foco automático', 199.90);

INSERT INTO fornecedor (idFornecedor, RS, CNPJ) VALUES
(1, 'Fornecedor XYZ', '1122233344455'),
(2, 'Global Supplies', '2233445566778');

INSERT INTO produtos_fornecidos (idProduto, idFornecedor) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 1),
(6, 2);

INSERT INTO terceirizado (idTerceirizado, RS, localidade) VALUES
(1, 'Logística Rápida', 'Campinas-SP'),
(2, 'Entregas Express', 'Belo Horizonte-MG');

INSERT INTO produto_terceirizado (idTerceirizado, idProduto) VALUES
(1, 1),
(1, 2),
(2, 3),
(2, 4),
(2, 5),
(1, 6);

INSERT INTO estoque (idEstoque, cep) VALUES
(1, '12345678'),
(2, '87654321');

INSERT INTO localidade_produto (idEstoque, idProduto, qtd_disponivel) VALUES
(1, 1, 30),
(1, 2, 15),
(1, 3, 20),
(2, 4, 10),
(2, 5, 25),
(2, 6, 12);

INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(1, 1, 1),
(1, 2, 1); 
INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(2, 3, 1);
INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(3, 4, 1);
INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(4, 1, 1),
(4, 2, 1);
INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(5, 1, 1),
(5, 2, 1),
(5, 3, 1),
(5, 5, 1);
INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(6, 2, 1);
INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(7, 2, 1),
(7, 5, 1),
(7, 6, 1);

select * from Cliente;

#query para retornar os clientes que tinham mais de um cartão cadastrado

Select concat(c.Primeiro_nome,' ', c.Sobrenome) as nome, count(*) as numero_de_cartoes from cliente c
	inner join cartoes ca on c.idCliente = ca.idCliente
	group by ca.idCliente
    having numero_de_cartoes > 1;
 
 #querys apenas para ter ideias de outras querys mais complexas
 
select * from produtos_fornecidos;
select * from produto;
select * from pedido;

#query para uso da cláusula LIKE

select concat(rua, ' ', bairro, ' - ', cidade) as endereco from enderecos
	where rua like 'av%';
    
#esta query retorna a data, valor total e o status dos pedidos que tem valor total superior a R$350.00     

select p.Data_pedido, round(sum(prod.valor * pp.qtd),2) as total,p.status_pedido from pedido p
	inner join produtos_do_pedido pp on p.idpedido = pp.idPedido
    inner join produto prod on pp.idProduto = prod.idProduto
    group by p.idpedido
    having total > 350.00
    order by p.Data_pedido desc;

#aqui foi o momento que percebi a inutilidade do atributo valor total como persistido, tornando-o derivado
  
alter table pedido drop valor_total;

#query que mostra o valor total de todos os pedidos, ordenando-os pelo valor do pedido

select p.*, round(sum(prod.valor * pp.qtd),2) as valor_total from pedido p
	inner join produtos_do_pedido pp on p.idpedido = pp.idPedido
    inner join produto prod on pp.idProduto = prod.idProduto
    group by p.idpedido
    order by valor_total;
 
 #adicionei alguns pedidos, inicialmente com o id de entrega nulo, para serem adicionados posteriormente
 
INSERT INTO Pedido (idPedido, status_pedido, descricao, idCliente, idEntrega, Data_pedido) VALUES
(8, 'pendente', 'Compra rápida de webcam', 2, NULL, '2025-08-07'),
(9, 'em andamento', 'Kit de áudio completo', 3, NULL, '2025-08-07'),
(10, 'pendente', 'Pedido institucional', 4, NULL, '2025-08-07');

#adicionei também as entregas que seriam adicionadas aos pedidos, e os produtos relacionados

INSERT INTO entrega (idEntrega, status_entrega, codigo_rastreio, previsao_entrega) VALUES
(6, 'em separação', 'BR666777888', '2025-08-11'),
(7, 'rota de entrega', 'BR777888999', '2025-08-12'),
(8, 'entregue a transportadora', 'BR888999000', '2025-08-13');

INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(8, 6, 1);

INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(9, 5, 1),
(9, 6, 1);

INSERT INTO produtos_do_pedido (idPedido, idProduto, qtd) VALUES
(10, 4, 2);

select idPedido, status_pedido, idEntrega from Pedido
	where idEntrega is null;
 
 #neste momento, havia cometido um erro de update, esquecendo do else, logo,
 #os ids de entrega ja cadastrados foram anulados, ja que desativei o safe
 #update para fazer um teste utilizando 'case when then'
 #abaixo ja esta corrigido, mas tive uma pequena dor de cabeça
 
update pedido set idEntrega = case  idPedido when 8 then  6
								when 9 then 7
								when 10 then 8
                                else idEntrega
                    end;
                    
select * from Pedido;

update pedido set idEntrega = case  idPedido when 1 then  1
								when 2 then 2
								when 3 then 3
                                when 4 then 4
                                when 5 then 5
                                when 6 then 2
                                when 7 then 3
                                else idEntrega
                    end;
                    
select * from Pedido;

#agora uma query mais simples da quantidade de pedidos de cada cliente

select concat(c.Primeiro_nome, ' ', c.Sobrenome) as nome_cliente, count(*) from cliente c
		inner join pedido p on c.idCliente = p.idCliente
        group by p.idCliente
        order by nome_cliente;

#alem de uma query do fornecedor e seus produtos fornecidos, simples também
        
select RS, Pnome from fornecedor f, produto p, produtos_fornecidos pf
	where f.idfornecedor = pf.idfornecedor and pf.idProduto = p.idProduto


#planejo pensar em mais queries posteriormente