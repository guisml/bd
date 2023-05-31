-----------------------------------------------------------------------------------------------------------------------------------------------
-- Preparação --

DROP DATABASE IF EXISTS uvv;

DROP ROLE IF EXISTS guilherme;

DROP USER IF EXISTS guilherme;

-----------------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------
-- Criação do usuário --
CREATE USER guilherme WITH
CREATEDB
CREATEROLE
ENCRYPTED PASSWORD '202306723';

-----------------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------
-- Criação do Banco de Dados --

SET ROLE guilherme;
CREATE DATABASE uvv
    WITH
    OWNER = guilherme
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = true;

----------------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------
-- Conexão com o usuário --

\setenv PGPASSWORD '202306723'
\c uvv guilherme

-----------------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------
-- Criação do schema 'loja' --
    
    DROP SCHEMA IF EXISTS lojas ;
    CREATE SCHEMA IF NOT EXISTS lojas
    AUTHORIZATION guilherme;
    ALTER DATABASE uvv SET search_path TO "lojas", public;
    SET search_path TO lojas;

-----------------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------
-- Criação da tabela produtos--

    CREATE TABLE lojas.produtos (
                produto_id                  NUMERIC(38) NOT NULL,
                nome                        VARCHAR(255) NOT NULL,
                preco_unitario              NUMERIC(10,2) NOT NULL,
                detalhe                     BYTEA NOT NULL,
                imagem                      BYTEA NOT NULL,
                imagem_mime_type            VARCHAR(512) NOT NULL,
                imagem_arquivo              VARCHAR(512) NOT NULL,
                imagem_charset              VARCHAR(512) NOT NULL,
                imagem_ultima_atualizacao   DATE NOT NULL,
                CONSTRAINT produto_id       PRIMARY KEY (produto_id)
);
     
   
  
  
-- Comentários da tabela produtos --
    COMMENT ON TABLE  lojas.produtos IS                                    'tabela para os produtos da loja';
    COMMENT ON COLUMN lojas.produtos.produto_id IS                         'coluna para o id dos produtos';
    COMMENT ON COLUMN lojas.produtos.nome IS                               'coluna para o nome dos produtos';
    COMMENT ON COLUMN lojas.produtos.preco_unitario IS                     'coluna para o preço unitário dos produtos';
    COMMENT ON COLUMN lojas.produtos.detalhe IS                            'coluna para os detalhes dos produtos';
    COMMENT ON COLUMN lojas.produtos.imagem IS                             'coluna para as imagens dos produtos';
    COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS                   'coluna para o mime type das imagens dos produtos';
    COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS                     'coluna para o arquivo das imagens dos produtos';
    COMMENT ON COLUMN lojas.produtos.imagem_charset IS                     'coluna para o charset das imagens';
    COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS          'coluna para a última atualização das imagens dos produtos';

-----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação da tabela clientes--

CREATE TABLE lojas.clientes (
                cliente_id1                 NUMERIC(38) NOT NULL,
                email                       VARCHAR(255) NOT NULL,
                nome                        VARCHAR(255) NOT NULL,
                telefone1                   VARCHAR(20) NOT NULL,
                telefone2                   VARCHAR(20) NOT NULL,
                telefone3                   VARCHAR(20) NOT NULL,
                CONSTRAINT cliente_id       PRIMARY KEY (cliente_id1)
);
 
 
 
 
-- Comentários da tabela clientes -- 
    COMMENT ON TABLE  lojas.clientes IS                    'tabela para os clientes da loja';
    COMMENT ON COLUMN lojas.clientes.cliente_id1 IS        'coluna para o id do cliente';
    COMMENT ON COLUMN lojas.clientes.email IS              'coluna para o email do cliente';
    COMMENT ON COLUMN lojas.clientes.nome IS               'coluna para o nome do cliente';
    COMMENT ON COLUMN lojas.clientes.telefone1 IS          'coluna para um número de telefone primário do cliente';
    COMMENT ON COLUMN lojas.clientes.telefone2 IS          'coluna para um número de telefone secundário do cliente';
    COMMENT ON COLUMN lojas.clientes.telefone3 IS          'coluna para um número de telefonde terciário do cliente';

-----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação da tabela lojas--
CREATE TABLE lojas.lojas (
                loja_id1                                          NUMERIC(38) NOT NULL,
                nome                                              VARCHAR(255) NOT NULL,
                endereco_web                                      VARCHAR(100) NOT NULL,
                endereco_fisico                                   VARCHAR(512) NOT NULL,
                latitude                                          NUMERIC,
                longitude                                         NUMERIC,
                logo                                              BYTEA NOT NULL,
                logo_mime_type                                    VARCHAR(512) NOT NULL,
                logo_arquivo                                      VARCHAR(512) NOT NULL,
                logo_charset                                      VARCHAR(512) NOT NULL,
                logo_ultima_atualizacao                           DATE NOT NULL,
                CONSTRAINT loja_id                                PRIMARY KEY (loja_id1)
);




-- Comentários da tabela lojas --
    COMMENT ON TABLE lojas.lojas IS                                'tabela para as lojas';
    COMMENT ON COLUMN lojas.lojas.loja_id1 IS                      'coluna para o id da loja';
    COMMENT ON COLUMN lojas.lojas.nome IS                          'coluna para o nome da loja';
    COMMENT ON COLUMN lojas.lojas.endereco_web IS                  'coluna para o endereço web da loja';
    COMMENT ON COLUMN lojas.lojas.endereco_fisico IS               'coluna para o endereço físico da loja';
    COMMENT ON COLUMN lojas.lojas.latitude IS                      'coluna para a latitude da loja';
    COMMENT ON COLUMN lojas.lojas.longitude IS                     'coluna para a longitude da loja';
    COMMENT ON COLUMN lojas.lojas.logo IS                          'coluna para o logo da loja';
    COMMENT ON COLUMN lojas.lojas.logo_mime_type IS                'coluna para o mime type do logo da loja';
    COMMENT ON COLUMN lojas.lojas.logo_arquivo IS                  'coluna para o arquivo do logo da loja';
    COMMENT ON COLUMN lojas.lojas.logo_charset IS                  'coluna para o charset do logo';
    COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS       'coluna para a última atualização da loja';

-----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação da tabela pedidos --

CREATE TABLE lojas.pedidos (
                pedido_id                              NUMERIC(38) NOT NULL,
                cliente_id                             NUMERIC(38) NOT NULL,
                data_hora                              TIMESTAMP NOT NULL,
                status                                 VARCHAR(15) NOT NULL,
                loja_id                                NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id                   PRIMARY KEY (pedido_id)
);
 
 
 
 
-- Comentários da tabela pedidos --
    COMMENT ON TABLE  lojas.pedidos IS                 'tabela para os pedidos da loja';
    COMMENT ON COLUMN lojas.pedidos.pedido_id IS       'coluna para o id do pedido';
    COMMENT ON COLUMN lojas.pedidos.cliente_id IS      'coluna para o id do cliente que fez o pedido';
    COMMENT ON COLUMN lojas.pedidos.data_hora IS       'coluna para a data e a hora que foi feito o pedido';
    COMMENT ON COLUMN lojas.pedidos.status IS          'coluna para o status do pedido';
    COMMENT ON COLUMN lojas.pedidos.loja_id IS         'coluna para o id da loja';

    -----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação da tabela estoques--

CREATE TABLE lojas.estoques (
                estoque_id                                 NUMERIC(38) NOT NULL,
                loja_id                                    NUMERIC(38) NOT NULL,
                produto_id                                 NUMERIC(38) NOT NULL,
                quantidade                                 NUMERIC(38) NOT NULL,
                CONSTRAINT estoque_id                      PRIMARY KEY (estoque_id)
);




-- Comentários da tabela estoques --
    COMMENT ON TABLE  lojas.estoques IS                    'tabela para o estoque da loja';
    COMMENT ON COLUMN lojas.estoques.estoque_id IS         'coluna para o id do estoque';
    COMMENT ON COLUMN lojas.estoques.loja_id IS            'coluna para o id da loja';
    COMMENT ON COLUMN lojas.estoques.produto_id IS         'coluna para o id do produto';
    COMMENT ON COLUMN lojas.estoques.quantidade IS         'coluna para a quantidade no estoque';

-----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação da tabela envios--

CREATE TABLE lojas.envios (
                envio_id                                      VARCHAR(38) NOT NULL,
                loja_id                                       NUMERIC(38) NOT NULL,
                cliente_id                                    NUMERIC(38) NOT NULL,
                endereco_entrega                              VARCHAR(512) NOT NULL,
                stuatus                                       VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id                           PRIMARY KEY (envio_id)
);




-- Comentários da tabela envios --

    COMMENT ON TABLE  lojas.envios IS                         'tabela para os envios da loja';
    COMMENT ON COLUMN lojas.envios.envio_id IS                'coluna para o id do envio';
    COMMENT ON COLUMN lojas.envios.loja_id IS                 'coluna para o id da loja';
    COMMENT ON COLUMN lojas.envios.cliente_id IS              'coluna para o id do cliente';
    COMMENT ON COLUMN lojas.envios.endereco_entrega IS        'coluna para o endereço da entrega';
    COMMENT ON COLUMN lojas.envios.stuatus IS                 'coluna para o status dos envios';

-----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação da tabela pedidos_itens --

CREATE TABLE lojas.pedidos_itens (
                produto_id                                      NUMERIC(38) NOT NULL,
                pedido_id                                       NUMERIC(38) NOT NULL,
                numero_da_linha                                 NUMERIC(38) NOT NULL,
                preco_unitario                                  NUMERIC(10,2) NOT NULL,
                quantidade                                      NUMERIC(38) NOT NULL,
                envio_id                                        VARCHAR(38) NOT NULL,
                CONSTRAINT pedido_id1                           PRIMARY KEY (produto_id, pedido_id)
);




-- Comentários da tabela pedidos_itens --

    COMMENT ON TABLE  lojas.pedidos_itens IS                       'tabela para os pedidos em relação aos itens da loja';
    COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS            'coluna para o id dos produtos';
    COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS             'coluna para o id do pedido';
    COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS       'coluna para o numero da linha dos pedidos';
    COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS        'coluna para o preço unitário dos pedidos';
    COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS            'coluna para a quantidade de pedidos';
    COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS              'coluna para o id dos envios';

-----------------------------------------------------------------------------------------------------------------------------------------------




-- Criação das Chaves Estrangeiras --

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id1)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id1)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id1)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id1)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id1)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
-----------------------------------------------------------------------------------------------------------------------------------------------




-- Restrições das colunas --

-- Restrição de valor mínimo para o preço unitário --
ALTER TABLE lojas.produtos
ADD CONSTRAINT check_preco_unitario_min CHECK (preco_unitario >= 0);


-- Restrição de formato de email válido --
ALTER TABLE lojas.clientes
ADD CONSTRAINT check_email_format CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');


-- Restrição de telefone --
ALTER TABLE lojas.clientes
ADD CONSTRAINT check_telefone1_clientes CHECK (LENGTH(telefone1) >= 5 AND LENGTH(telefone1) <= 20);


-- Restrição de valores não nulos para as colunas latitude e longitude --
ALTER TABLE lojas.lojas
ADD CONSTRAINT check_latitude_lojas CHECK (latitude >= -90 AND latitude <= 90);

ALTER TABLE lojas.lojas
ADD CONSTRAINT check_longitude_lojas CHECK (longitude >= -180 AND longitude <= 180);


-- Restrição de status válido --
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status_valido CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));


-- Restrição de quantidade mínima no estoque --
ALTER TABLE lojas.estoques
ADD CONSTRAINT check_quantidade_min CHECK (quantidade >= 0);


-- Restrição de status válido --
ALTER TABLE lojas.envios
ADD CONSTRAINT check_status_valido CHECK (status IN ('enviado', 'pendente'));


-- Restrição da quantidade de pedidos --
ALTER TABLE lojas.pedidos_itens
ADD CONSTRAINT check_quantidade_pedidos_itens CHECK (quantidade >= 0);


-- restrição de nome --
ALTER TABLE lojas.lojas
ADD CONSTRAINT unico_nome_lojas 
UNIQUE (nome);















