-- Criar esquema
CREATE SCHEMA IF NOT EXISTS dgt_ren;

-- ===============================
-- TABELAS BASE (sem dependências)
-- ===============================

/*
Descrição dos campos das tabelas:
- Nome do campo – Nome do campo da tabela que é visualizado pelo utilizador;
- Descrição – descrição do conteúdo do campo da tabela;
- alias – Nome do campo da tabela na base de dados;
- Tipo de data – tipo de dados do campo da tabela.
*/

-- ===============================
-- Tabela CATALOGO
-- Contém os temas, subtemas e objetos catalogados,
-- serve como referência para outras tabelas.
-- ===============================

-- Table: dgt_ren.catalogo
-- DROP TABLE IF EXISTS dgt_ren.catalogo;

CREATE TABLE IF NOT EXISTS dgt_ren.catalogo
(
    id SERIAL PRIMARY KEY,
	tema character varying(255),
    subtema character varying(255),
    nomeobje character varying(255),
    codobje integer UNIQUE,
    legenda character varying(255),
    acronobje character varying(255)
);

COMMENT ON TABLE dgt_ren.catalogo
    IS 'Tipo de tabela: Base. Descrição: Contém todos os objetos e organização previstos no catálogo de objetos da carta da REN.';

COMMENT ON COLUMN dgt_ren.catalogo.id
    IS 'Descrição: identificador único; Alias: Código Int; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.catalogo.tema
    IS 'Descrição: Agregação de tipologias de áreas a incluir na REN ou áreas a excluir da REN.; Alias: Tema; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.catalogo.subtema
    IS 'Descrição: Nome da tipologia de área a incluir na REN ou do tipo de exclusão da REN.; Alias: Subtema; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.catalogo.nomeobje
    IS 'Descrição: Designação do objeto.; Alias: Nome do Objeto; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.catalogo.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos. Campo que identifica univocamente cada linha da tabela. É a chave primária da tabela auxiliar que funciona como chave estrangeira para as tabelas gráficas.; Alias: Código do Objeto; Tipo de data: Inteiro (Nota: O PDF indica "Texto", mas implementado como Inteiro para compatibilidade com PK/FK)';

COMMENT ON COLUMN dgt_ren.catalogo.legenda
    IS 'Descrição: Texto que identifica o objeto na “Legenda da simbologia” da carta da REN; Alias: Legenda; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.catalogo.acronobje
    IS 'Descrição: Acrónimo do nome do objeto; Alias: Acrónimo Objeto; Tipo de data: Texto';


-- ===============================
-- Tabela CODIGOINE
-- Lista dos códigos da divisão administrativa do INE para os municípios.
-- (Esta tabela não está explicitamente no ANEXO II A, mas foi incluída em iterações anteriores.)
-- ===============================

-- Table: dgt_ren.codigoine
-- DROP TABLE IF EXISTS dgt_ren.codigoine;

CREATE TABLE IF NOT EXISTS dgt_ren.codigoine
(
    id SERIAL PRIMARY KEY,
	municipio character varying(255),
    dtcc character varying(4) UNIQUE
);

COMMENT ON TABLE dgt_ren.codigoine
    IS 'Tipo de tabela: Base. Descrição: Lista de municípios portugueses com seus respectivos códigos DTCC (Divisão Territorial de Classificação Cartográfica).';

COMMENT ON COLUMN dgt_ren.codigoine.id
    IS 'Descrição: identificador único; Alias: Código Int; Tipo de data: Inteiro';
	
COMMENT ON COLUMN dgt_ren.codigoine.municipio
    IS 'Descrição: Nome do município; Alias: Município; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.codigoine.dtcc
    IS 'Descrição: Código DTCC do município; Alias: DTCC; Tipo de data: Texto';


-- ===============================
-- TABELAS QUE DEPENDEM SOMENTE DO CATALOGO
-- ===============================

-- ===============================
-- Tabela DTCC_TIP_L
-- Tipologias lineares (comprimentos em metros),
-- vinculadas a objetos do catálogo.
-- ===============================

-- Table: dgt_ren.dtcc_tip_l
-- DROP TABLE IF EXISTS dgt_ren.dtcc_tip_l;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_tip_l
(
    id_tip_l SERIAL PRIMARY KEY,
    codobje integer REFERENCES dgt_ren.catalogo(codobje),
    comp_m numeric(15,2),
    geom geometry(MultiLineString,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_tip_l_geom_idx
ON dgt_ren.dtcc_tip_l
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_tip_l
    IS 'Tipo de tabela: Tipologia Linear. Descrição: Contém os objetos com geometria linear - leitos dos cursos de água, canalizados ou não. Exemplo: O objeto Cursos de água-Leito (código 21) composto por várias linhas, tantas quantos os Rios, Ribeiros e afluentes ou outros considerados como REN, sendo que cada uma dessas linhas corresponde a um registo da tabela.';

COMMENT ON COLUMN dgt_ren.dtcc_tip_l.id_tip_l
    IS 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_Tip_L; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_tip_l.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_tip_l.comp_m
    IS 'Descrição: Distância entre o ponto inicial e o final medida em metros.; Alias: Comp_m; Tipo de data: Número Real';

-- ===============================
-- Tabela DTCC_DET_TIP_L
-- Detalhes de tipologias lineares com comprimento (metros),
-- vinculadas a objetos do catálogo.
-- ===============================


-- Table: dgt_ren.dtcc_det_tip_l
-- DROP TABLE IF EXISTS dgt_ren.dtcc_det_tip_l;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_det_tip_l
(
    id_d_tip_l SERIAL PRIMARY KEY,
    codobje integer REFERENCES dgt_ren.catalogo(codobje),
    comp_m numeric(15,2),
    geom geometry(MultiLineString,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_det_tip_l_geom_idx
ON dgt_ren.dtcc_det_tip_l
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_det_tip_l
    IS 'Tipo de tabela: Detalhe de Tipologia Linear. Descrição: Contém os objetos com geometria linear - leitos dos cursos de água, canalizados ou não. Exemplo: O objeto Cursos de água-Leito (código 21) composto por várias linhas, tantas quantos os Rios, Ribeiros e afluentes ou outros considerados como REN, sendo que cada uma dessas linhas corresponde a um registo da tabela.';

COMMENT ON COLUMN dgt_ren.dtcc_det_tip_l.id_d_tip_l
    IS 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_D_Tip_L; Tipo de data: Número Real';

COMMENT ON COLUMN dgt_ren.dtcc_det_tip_l.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_tip_l.comp_m
    IS 'Descrição: Distância entre o ponto inicial e o final medida em metros.; Alias: Comp_m; Tipo de data: Número Real';


-- ===============================
-- Tabela DTCC_TIP_P
-- Tipologias poligonais (áreas em m²),
-- vinculadas a objetos do catálogo.
-- ===============================

-- Table: dgt_ren.dtcc_tip_p
-- DROP TABLE IF EXISTS dgt_ren.dtcc_tip_p;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_tip_p
(
    id_tip_p SERIAL PRIMARY KEY,
    codobje integer REFERENCES dgt_ren.catalogo(codobje),
    area_m2 numeric(15,2),
    geom geometry(MultiPolygon,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_tip_p_geom_idx
ON dgt_ren.dtcc_tip_p
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_tip_p
    IS 'Tipo de tabela: Tipologia Poligonal. Descrição: Contém os objetos com geometria poligonal que correpondem às tipologias delimitadas na carta da REN antes de serem ponderadas as exclusões (“REN Bruta”).Cada linha da tabela corresponde a um objeto do catálogo sendo que esse objeto é formado por um ou mais polígonos. Exemplo: Na tabela "dtcc_tip_p", o objeto Cursos de água Leitos (código 21) é um único registo na tabela, não obstante ser composta por vários polígonos, tantos quantos os Rios, Ribeiros e afluentes ou outros considerados como REN.';

COMMENT ON COLUMN dgt_ren.dtcc_tip_p.id_tip_p
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_Tip_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_tip_p.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_tip_p.area_m2
    IS 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real';


-- ===============================
-- Tabela DTCC_DET_TIP_P
-- Detalhes de tipologias poligonais (áreas em m²),
-- vinculadas a objetos do catálogo.
-- ===============================

-- Table: dgt_ren.dtcc_det_tip_p
-- DROP TABLE IF EXISTS dgt_ren.dtcc_det_tip_p;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_det_tip_p
(
    id_d_tip_p SERIAL PRIMARY KEY,
    codobje integer REFERENCES dgt_ren.catalogo(codobje),
    area_m2 numeric(15,2),
    geom geometry(MultiPolygon,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_det_tip_p_geom_idx
ON dgt_ren.dtcc_det_tip_p
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_det_tip_p
    IS 'Tipo de tabela: Detalhe de Tipologia Poligonal. Descrição: Contém os objetos com geometria poligonal que correpondem às tipologias delimitadas na carta da REN antes de serem ponderadas as exclusões (“REN Bruta”).Cada linha da tabela corresponde a um objeto do catálogo sendo que esse objeto é formado por um ou mais polígonos. Exemplo: Na tabela DTCC_DET_TIP_P, o objeto Cursos de água Leitos (código 21) é um único registo na tabela, não obstante ser composta por vários polígonos, tantos quantos os Rios, Ribeiros e afluentes ou outros considerados como REN.';

COMMENT ON COLUMN dgt_ren.dtcc_det_tip_p.id_d_tip_p
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_D_Tip_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_tip_p.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_tip_p.area_m2
    IS 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real';

-- ===============================
-- Tabela DTCC_EXCL_P
-- Exclusões poligonais com fundamento e destino,
-- vinculadas a objetos do catálogo.
-- ===============================


-- Table: dgt_ren.dtcc_excl_p
-- DROP TABLE IF EXISTS dgt_ren.dtcc_excl_p;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_excl_p
(
    id_excl_p SERIAL PRIMARY KEY,
    exclusao character varying(20) UNIQUE,
    codobje integer REFERENCES dgt_ren.catalogo(codobje),
    area_m2 numeric(15,2),
    fundamento character varying(255),
    fimdest character varying(255),
    geom geometry(MultiPolygon,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_excl_p_geom_idx
ON dgt_ren.dtcc_excl_p
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_excl_p
    IS 'Tipo de tabela: Exclusão Poligonal. Descrição: Contém os objetos com geometria poligonal que correspondem às exclusões. Cada linha da tabela corresponde a uma exclusão identificada pelo tipo (C ou E) e n.º ordem (de 1 a n).';

COMMENT ON COLUMN dgt_ren.dtcc_excl_p.id_excl_p
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_Excl_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_p.exclusao
    IS 'Descrição: Tipo e número de ordem da exclusão (de C1 a Cn e E1 a En); Alias: Exclusao; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.dtcc_excl_p.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 37 e 38). É a chave primária da tabela secundária.; Alias: CodObje; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_p.area_m2
    IS 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real';

COMMENT ON COLUMN dgt_ren.dtcc_excl_p.fundamento
    IS 'Descrição: Fundamentação da necessidade de exclusão.; Alias: Fundamento; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.dtcc_excl_p.fimdest
    IS 'Descrição: Fim a que se destina a area a excluir.; Alias: FimDest; Tipo de data: Texto';

-- ===============================
-- Tabela DTCC_DET_EXCL_P
-- Detalhes de exclusões poligonais 
-- vinculadas a objetos do catálogo.
-- ===============================

-- Table: dgt_ren.dtcc_det_excl_p
-- DROP TABLE IF EXISTS dgt_ren.dtcc_det_excl_p;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_det_excl_p
(
    id_d_excl_p SERIAL PRIMARY KEY,
    exclusao character varying(255),
    codobje integer REFERENCES dgt_ren.catalogo(codobje),
    area_m2 numeric(15,2),
    geom geometry(MultiPolygon,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_det_excl_p_geom_idx
ON dgt_ren.dtcc_det_excl_p
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_det_excl_p
    IS 'Tipo de tabela: Detalhe de Exclusão Poligonal. Descrição: Contém os objetos com geometria poligonal que correspondem às exclusões. Cada linha da tabela corresponde a uma exclusão identificada pelo tipo (C ou E) e n.º ordem (de 1 a n).';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_p.id_d_excl_p
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_D_Excl_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_p.exclusao
    IS 'Descrição: Tipo e número de ordem da exclusão (de C1 a Cn e E1 a En); Alias: Exclusao; Tipo de data: Texto';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_p.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 37 e 38). É a chave primária da tabela secundária.; Alias: CodObje; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_p.area_m2
    IS 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real';

-- ===============================
-- VISTAS PARA "RELACIONAMENTO":
-- Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.
-- ===============================

-- ===============================
-- Tabela DTCC_EXCL_TIP
-- Relaciona exclusões poligonais (DTCC_EXCL_P)
-- com tipologias poligonais (DTCC_TIP_P).
-- ===============================
CREATE MATERIALIZED VIEW dgt_ren.dtcc_excl_tip AS
-- CREATE VIEW dgt_ren.dtcc_excl_tip AS
SELECT ROW_NUMBER() OVER()::int AS id_tip_excl,
    t.id_tip_p,
    e.id_excl_p,
	t.codobje,
    ST_Intersection(e.geom, t.geom)::geometry(MultiPolygon,3763) AS geom
FROM dgt_ren.dtcc_tip_p t
JOIN dgt_ren.dtcc_excl_p e ON ST_Intersects(e.geom, t.geom)
WITH DATA;

CREATE INDEX IF NOT EXISTS dtcc_excl_tip_geom_idx
ON dgt_ren.dtcc_excl_tip
USING gist (geom);

COMMENT ON MATERIALIZED VIEW dgt_ren.dtcc_excl_tip
-- COMMENT ON VIEW dgt_ren.dtcc_excl_tip
    IS 'Tipo de vista: Relação Exclusão-Tipologia. Descrição: Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.id_tip_excl
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_Tip_Excl; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.id_tip_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC_TIPOLOGIAS_POLIGONOS; Alias: ID_Tip_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.id_excl_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC_EXCLUSOES_POLIGONOS; Alias: ID_Excl_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';

-- ===============================
-- Tabela DTCC_DET_EXCL_TIP
-- Relaciona exclusões detalhadas poligonais (DTCC_DET_EXCL_P)
-- com tipologias detalhadas (DTCC_DET_TIP_P).
-- ===============================
CREATE MATERIALIZED VIEW dgt_ren.dtcc_det_excl_tip AS
-- CREATE VIEW dgt_ren.dtcc_det_excl_tip AS
SELECT ROW_NUMBER() OVER()::int AS id_d_tip_excl,
    t.id_d_tip_p,
    e.id_d_excl_p,
	t.codobje,
    ST_Intersection(e.geom, t.geom)::geometry(MultiPolygon,3763) AS geom
FROM dgt_ren.dtcc_det_tip_p t
JOIN dgt_ren.dtcc_det_excl_p e ON ST_Intersects(e.geom, t.geom)
WITH DATA;

CREATE INDEX IF NOT EXISTS dtcc_det_excl_tip_geom_idx
ON dgt_ren.dtcc_det_excl_tip
USING gist (geom);

COMMENT ON MATERIALIZED VIEW dgt_ren.dtcc_det_excl_tip
-- COMMENT ON VIEW dgt_ren.dtcc_det_excl_tip
    IS 'Tipo de vista: Relação Detalhe Exclusão-Tipologia. Descrição: Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.id_d_tip_excl
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_D_Tip_Excl; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.id_d_tip_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC_DETALHE_TIPOLOGIAS_POLIGONOS; Alias: ID_D_Tip_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.id_d_excl_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC__DETALHE_EXCLUSOES_POLIGONOS; Alias: ID_D_Excl_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';

-- ===============================
-- [APENAS GPKG] TABELAS QUE DEPENDEM DE OUTRAS TABELAS INTERMEDIÁRIAS
-- ===============================

-- ===============================
-- Tabela DTCC_DET_EXCL_TIP
-- Relaciona exclusões detalhadas poligonais (DTCC_DET_EXCL_P)
-- com tipologias detalhadas (DTCC_DET_TIP_P).
-- ===============================

-- Table: dgt_ren.dtcc_det_excl_tip
-- DROP TABLE IF EXISTS dgt_ren.dtcc_det_excl_tip;

CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_det_excl_tip
(
    id_d_tip_excl SERIAL PRIMARY KEY,
    id_d_tip_p integer REFERENCES dgt_ren.dtcc_det_tip_p(id_d_tip_p) ON DELETE CASCADE ON UPDATE CASCADE,
    id_d_excl_p integer REFERENCES dgt_ren.dtcc_det_excl_p(id_d_excl_p) ON DELETE CASCADE ON UPDATE CASCADE,
	codobje integer REFERENCES dgt_ren.catalogo(codobje),
	geom geometry(MultiPolygon,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_det_excl_tip_geom_idx
ON dgt_ren.dtcc_det_excl_tip
USING gist (geom);

COMMENT ON TABLE dgt_ren.dtcc_det_excl_tip
    IS 'Tipo de tabela: Relação Detalhe Exclusão-Tipologia. Descrição: Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.id_d_tip_excl
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_D_Tip_Excl; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.id_d_tip_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC_DETALHE_TIPOLOGIAS_POLIGONOS; Alias: ID_D_Tip_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.id_d_excl_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC__DETALHE_EXCLUSOES_POLIGONOS; Alias: ID_D_Excl_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_det_excl_tip.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';


-- ===============================
-- Tabela DTCC_EXCL_TIP
-- Relaciona exclusões poligonais (DTCC_EXCL_P)
-- com tipologias poligonais (DTCC_TIP_P).
-- ===============================

-- Table: dgt_ren.dtcc_excl_tip
-- DROP TABLE IF EXISTS dgt_ren.dtcc_excl_tip;
CREATE TABLE IF NOT EXISTS dgt_ren.dtcc_excl_tip
(
    id_tip_excl SERIAL PRIMARY KEY,
    id_tip_p integer REFERENCES dgt_ren.dtcc_tip_p(id_tip_p) ON DELETE CASCADE ON UPDATE CASCADE,
    id_excl_p integer REFERENCES dgt_ren.dtcc_excl_p(id_excl_p) ON DELETE CASCADE ON UPDATE CASCADE,
	codobje integer REFERENCES dgt_ren.catalogo(codobje),
	geom geometry(MultiPolygon,3763)
);

CREATE INDEX IF NOT EXISTS dtcc_excl_tip_geom_idx
ON dgt_ren.dtcc_excl_tip
USING gist (geom);


COMMENT ON TABLE dgt_ren.dtcc_excl_tip
    IS 'Tipo de tabela: Relação Exclusão-Tipologia. Descrição: Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.id_tip_excl
    IS 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: ID_Tip_Excl; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.id_tip_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC_TIPOLOGIAS_POLIGONOS; Alias: ID_Tip_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.id_excl_p
    IS 'Descrição: Campo de numeração automatica da tabela DTCC_EXCLUSOES_POLIGONOS; Alias: ID_Excl_P; Tipo de data: Inteiro';

COMMENT ON COLUMN dgt_ren.dtcc_excl_tip.codobje
    IS 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: CodObje; Tipo de data: Inteiro';


-- ===============================
-- Tabela CATALOGO
-- DADOS
-- ===============================

INSERT INTO dgt_ren.catalogo (id,tema,subtema,nomeobje,codobje,legenda,acronobje) VALUES
	 (1,'Áreas de proteção do litoral','Faixa marítima de proteção costeira','Faixa marítima de proteção costeira',1,'Faixa marítima de proteção costeira','FMPC'),
	 (2,'Áreas de proteção do litoral','Praias','Praias',2,'Praias','PRA'),
	 (3,'Áreas de proteção do litoral','Barreiras detríticas','Restingas',3,'Barreiras detríticas','REST'),
	 (4,'Áreas de proteção do litoral','Ilhéus e rochedos emersos no mar','Ilhéus',8,'Ilhéus e rochedos emersos no mar','ILHEUS'),
	 (5,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Áreas estratégicas de infiltração, proteção e recarga de aquíferos','Áreas estratégicas de infiltração, proteção e recarga de aquíferos',30,'Áreas estratégicas de infiltração, proteção e recarga de aquíferos','AEIPRA'),
	 (6,'Áreas de proteção do litoral','Barreiras detríticas','Barreiras soldadas',4,'Barreiras detríticas','BARR_SOLD'),
	 (7,'Áreas de proteção do litoral','Barreiras detríticas','Ilhas-Barreira',5,'Barreiras detríticas','ILH-BARR'),
	 (8,'Áreas de proteção do litoral','Tômbolos','Tômbolos',6,'Tômbolos','TOMB'),
	 (9,'Áreas de proteção do litoral','Sapais','Sapais',7,'Sapais','SAP'),
	 (10,'Áreas de proteção do litoral','Ilhéus e rochedos emersos no mar','Rochedos emersos no mar',9,'Ilhéus e rochedos emersos no mar','ROCHEDOS'),
	 (11,'Áreas de proteção do litoral','Dunas costeiras e dunas fósseis','Dunas costeiras litorais',10,'Dunas costeiras litorais','DUN_LIT'),
	 (12,'Áreas de proteção do litoral','Dunas costeiras e dunas fósseis','Dunas costeiras interiores',11,'Dunas costeiras interiores','DUN_INT'),
	 (13,'Áreas de proteção do litoral','Dunas costeiras e dunas fósseis','Dunas fósseis',12,'Dunas fósseis','DUN_FOSS'),
	 (14,'Áreas de proteção do litoral','Arribas e respetivas faixas de proteção','Arribas',13,'Arribas','ARRIB'),
	 (15,'Áreas de proteção do litoral','Arribas e respetivas faixas de proteção','Faixa de proteção de arribas a partir do rebordo superior',14,'Faixas de proteção das arribas','FPA_SUP'),
	 (16,'Áreas de proteção do litoral','Arribas e respetivas faixas de proteção','Faixa de proteção de arribas a partir da base da arriba',15,'Faixas de proteção das arribas','FPA_BASE'),
	 (17,'Áreas de proteção do litoral','Faixa terrestre de proteção costeira','Faixa terrestre de proteção costeira',16,'Faixa terrestre de proteção costeira','FTPC'),
	 (18,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Águas de transição e respetivos leitos, margens e faixas de proteção','Águas de transição - Leito',18,'Águas de transição - Leito','AT_LEITO'),
	 (19,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Águas de transição e respetivos leitos, margens e faixas de proteção','Águas de transição - Margem',19,'Águas de transição - Margem','AT_MARGEM'),
	 (20,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Águas de transição e respetivos leitos, margens e faixas de proteção','Águas de transição - Faixa de proteção',20,'Águas de transição - Faixa de proteção','AT_FP'),
	 (21,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Cursos de água e respetivos leitos e margens','Cursos de água - Leito',21,'Cursos de água - Leito','CA_LEITO'),
	 (22,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Cursos de água e respetivos leitos e margens','Cursos de água - Leito canalizado',22,'Cursos de água - Leito canalizado','CA_LCANAL'),
	 (23,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Cursos de água e respetivos leitos e margens','Cursos de água - Margem',23,'Cursos de água - Margem','CA_MARGEM'),
	 (24,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Lagoas e lagos e respetivos leitos, margens e faixas de proteção','Lagoas e lagos - Leito',24,'Lagoas e lagos - Leito','LL_LEITO'),
	 (25,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Lagoas e lagos e respetivos leitos, margens e faixas de proteção','Lagoas e lagos - Margem',25,'Lagoas e lagos - Margem','LL_MARGEM'),
	 (26,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Lagoas e lagos e respetivos leitos, margens e faixas de proteção','Lagoas e lagos - Faixa de proteção',26,'Lagoas e lagos - Faixa de proteção','LL_FP'),
	 (27,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção','Albufeiras - Leito',27,'Albufeiras - Leito','ALB_LEITO'),
	 (28,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção','Albufeiras - Faixa de proteção',29,'Albufeiras - Faixa de proteção','ALB_FP'),
	 (29,'Áreas de exclusão','Exclusão para a satisfação de carências - E','Exclusão para a satisfação de carências - E',38,'Exclusão para a satisfação de carências - E','EXCL_E'),
	 (30,'Áreas de prevenção de riscos naturais','Zonas adjacentes','Zonas adjacentes',31,'Zonas adjacentes','ZA'),
	 (31,'Áreas de prevenção de riscos naturais','Zonas ameaçadas pelo mar','Zonas ameaçadas pelo mar',32,'Zonas ameaçadas pelo mar','ZAM'),
	 (32,'Áreas de prevenção de riscos naturais','Zonas ameaçadas pelas cheias','Zonas ameaçadas pelas cheias',33,'Zonas ameaçadas pelas cheias','ZAC'),
	 (33,'Áreas de prevenção de riscos naturais','Áreas de elevado risco de erosão hídrica do solo','Áreas de elevado risco de erosão hídrica do solo',34,'Áreas de elevado risco de erosão hídrica do solo','AEREHS'),
	 (34,'Áreas de prevenção de riscos naturais','Áreas de instabilidade de vertentes','Áreas de instabilidade de vertentes',35,'Áreas de instabilidade de vertentes','AIV'),
	 (35,'Áreas de prevenção de riscos naturais','Áreas de instabilidade de vertentes','Escarpas',36,'Escarpas','ESCARP'),
	 (36,'Áreas de exclusão','Exclusão por compromisso - C','Exclusão por compromisso - C',37,'Exclusão por compromisso - C','EXCL_C'),
	 (37,'Áreas de proteção do litoral','Águas do mar','Águas do mar - Margem',17,'Águas do mar - Margem','AG_MAR'),
	 (38,'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre','Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção','Albufeiras - Margem',28,'Albufeiras - Margem','ALB_MARGEM');

-- ===============================
-- Tabela CODIGOINE
-- DADOS
-- ===============================

INSERT INTO dgt_ren.codigoine (municipio, dtcc) VALUES
('Abrantes', '1401'),
('Águeda', '0101'),
('Aguiar da Beira', '0901'),
('Alandroal', '0701'),
('Albergaria-a-Velha', '0102'),
('Albufeira', '0801'),
('Alcácer do Sal', '1501'),
('Alcanena', '1402'),
('Alcobaça', '1001'),
('Alcochete', '1502'),
('Alcoutim', '0802'),
('Alenquer', '1101'),
('Alfândega da Fé', '0401'),
('Alijó', '1701'),
('Aljezur', '0803'),
('Aljustrel', '0201'),
('Almada', '1503'),
('Almeida', '0902'),
('Almeirim', '1403'),
('Almodôvar', '0202'),
('Alpiarça', '1404'),
('Alter do Chão', '1201'),
('Alvaiázere', '1002'),
('Alvito', '0203'),
('Amadora', '1115'),
('Amarante', '1301'),
('Amares', '0301'),
('Anadia', '0103'),
('Ansião', '1003'),
('Arcos de Valdevez', '1601'),
('Arganil', '0601'),
('Armamar', '1801'),
('Arouca', '0104'),
('Arraiolos', '0702'),
('Arronches', '1202'),
('Arruda dos Vinhos', '1102'),
('Aveiro', '0105'),
('Avis', '1203'),
('Azambuja', '1103'),
('Baião', '1302'),
('Barcelos', '0302'),
('Barrancos', '0204'),
('Barreiro', '1504'),
('Batalha', '1004'),
('Beja', '0205'),
('Belmonte', '0501'),
('Benavente', '1405'),
('Bombarral', '1005'),
('Borba', '0703'),
('Boticas', '1702'),
('Braga', '0303'),
('Bragança', '0402'),
('Cabeceiras de Basto', '0304'),
('Cadaval', '1104'),
('Caldas da Rainha', '1006'),
('Caminha', '1602'),
('Campo Maior', '1204'),
('Cantanhede', '0602'),
('Carrazeda de Ansiães', '0403'),
('Carregal do Sal', '1802'),
('Cartaxo', '1406'),
('Cascais', '1105'),
('Castanheira de Pêra', '1007'),
('Castelo Branco', '0502'),
('Castelo de Paiva', '0106'),
('Castelo de Vide', '1205'),
('Castro Daire', '1803'),
('Castro Marim', '0804'),
('Castro Verde', '0206'),
('Celorico da Beira', '0903'),
('Celorico de Basto', '0305'),
('Chamusca', '1407'),
('Chaves', '1703'),
('Cinfães', '1804'),
('Coimbra', '0603'),
('Condeixa-a-Nova', '0604'),
('Constância', '1408'),
('Coruche', '1409'),
('Covilhã', '0503'),
('Crato', '1206'),
('Cuba', '0207'),
('Elvas', '1207'),
('Entroncamento', '1410'),
('Espinho', '0107'),
('Esposende', '0306'),
('Estarreja', '0108'),
('Estremoz', '0704'),
('Évora', '0705'),
('Fafe', '0307'),
('Faro', '0805'),
('Felgueiras', '1303'),
('Ferreira do Alentejo', '0208'),
('Ferreira do Zêzere', '1411'),
('Figueira da Foz', '0605'),
('Figueira de Castelo Rodrigo', '0904'),
('Figueiró dos Vinhos', '1008'),
('Fornos de Algodres', '0905'),
('Freixo de Espada à Cinta', '0404'),
('Fronteira', '1208'),
('Fundão', '0504'),
('Gavião', '1209'),
('Góis', '0606'),
('Golegã', '1412'),
('Gondomar', '1304'),
('Gouveia', '0906'),
('Grândola', '1505'),
('Guarda', '0907'),
('Guimarães', '0308'),
('Idanha-a-Nova', '0505'),
('Ílhavo', '0110'),
('Lagoa', '0806'),
('Lagos', '0807'),
('Lamego', '1805'),
('Leiria', '1009'),
('Lisboa', '1106'),
('Loulé', '0808'),
('Loures', '1107'),
('Lourinhã', '1108'),
('Lousã', '0607'),
('Lousada', '1305'),
('Mação', '1413'),
('Macedo de Cavaleiros', '0405'),
('Mafra', '1109'),
('Maia', '1306'),
('Mangualde', '1806'),
('Manteigas', '0908'),
('Marco de Canaveses', '1307'),
('Marinha Grande', '1010'),
('Marvão', '1210'),
('Matosinhos', '1308'),
('Mealhada', '0111'),
('Meda', '0909'),
('Melgaço', '1603'),
('Mértola', '0209'),
('Mesão Frio', '1704'),
('Mira', '0608'),
('Miranda do Corvo', '0609'),
('Miranda do Douro', '0406'),
('Mirandela', '0407'),
('Mogadouro', '0408'),
('Moimenta da Beira', '1807'),
('Moita', '1506'),
('Monção', '1604'),
('Monchique', '0809'),
('Mondim de Basto', '1705'),
('Monforte', '1211'),
('Montalegre', '1706'),
('Montemor-o-Novo', '0706'),
('Montemor-o-Velho', '0610'),
('Montijo', '1507'),
('Mora', '0707'),
('Mortágua', '1808'),
('Moura', '0210'),
('Mourão', '0708'),
('Murça', '1707'),
('Murtosa', '0112'),
('Nazaré', '1011'),
('Nelas', '1809'),
('Nisa', '1212'),
('Óbidos', '1012'),
('Odemira', '0211'),
('Odivelas', '1116'),
('Oeiras', '1110'),
('Oleiros', '0506'),
('Olhão', '0810'),
('Oliveira de Azeméis', '0113'),
('Oliveira de Frades', '1810'),
('Oliveira do Bairro', '0114'),
('Oliveira do Hospital', '0611'),
('Ourém', '1421'),
('Ourique', '0212'),
('Ovar', '0115'),
('Paços de Ferreira', '1309'),
('Palmela', '1508'),
('Pampilhosa da Serra', '0612'),
('Paredes', '1310'),
('Paredes de Coura', '1605'),
('Pedrógão Grande', '1013'),
('Penacova', '0613'),
('Penafiel', '1311'),
('Penalva do Castelo', '1811'),
('Penamacor', '0507'),
('Penedono', '1812'),
('Penela', '0614'),
('Peniche', '1014'),
('Peso da Régua', '1708'),
('Pinhel', '0910'),
('Pombal', '1015'),
('Ponte da Barca', '1606'),
('Ponte de Lima', '1607'),
('Ponte de sor', '1213'),
('Portalegre', '1214'),
('Portel', '0709'),
('Portimão', '0811'),
('Porto', '1312'),
('Porto de Mós', '1016'),
('Póvoa de Lanhoso', '0309'),
('Póvoa de Varzim', '1313'),
('Proença-a-Nova', '0508'),
('Redondo', '0710'),
('Reguengos de Monsaraz', '0711'),
('Resende', '1813'),
('Ribeira de Pena', '1709'),
('Rio Maior', '1414'),
('Sabrosa', '1710'),
('Sabugal', '0911'),
('Salvaterra de Magos', '1415'),
('Santa Comba Dão', '1814'),
('Santa Maria da Feira', '0109'),
('Santa Marta de Penaguião', '1711'),
('Santarém', '1416'),
('Santiago do Cacém', '1509'),
('Santo Tirso', '1314'),
('São Brás de Alportel', '0812'),
('São João da Madeira', '0116'),
('São João da Pesqueira', '1815'),
('São Pedro do Sul', '1816'),
('Sardoal', '1417'),
('Sátão', '1817'),
('Seia', '0912'),
('Seixal', '1510'),
('Sernancelhe', '1818'),
('Serpa', '0213'),
('Sertã', '0509'),
('Sesimbra', '1511'),
('Setúbal', '1512'),
('Sever do Vouga', '0117'),
('Silves', '0813'),
('Sines', '1513'),
('Sintra', '1111'),
('Sobral de Monte Agraço', '1112'),
('Soure', '0615'),
('Sousel', '1215'),
('Tábua', '0616'),
('Tabuaço', '1819'),
('Tarouca', '1820'),
('Tavira', '0814'),
('Terras de Bouro', '0310'),
('Tomar', '1418'),
('Tondela', '1821'),
('Torre de Moncorvo', '0409'),
('Torres Novas', '1419'),
('Torres Vedras', '1113'),
('Trancoso', '0913'),
('Trofa', '1318'),
('Vagos', '0118'),
('Vale de Cambra', '0119'),
('Valença', '1608'),
('Valongo', '1315'),
('Valpaços', '1712'),
('Vendas Novas', '0712'),
('Viana do Alentejo', '0713'),
('Viana do Castelo', '1609'),
('Vidigueira', '0214'),
('Vieira do Minho', '0311'),
('Vila de Rei', '0510'),
('Vila do Bispo', '0815'),
('Vila do Conde', '1316'),
('Vila Flor', '0410'),
('Vila Franca de Xira', '1114'),
('Vila Nova da Barquinha', '1420'),
('Vila Nova de Cerveira', '1610'),
('Vila nova de Famalicão', '0312'),
('Vila Nova de Foz Côa', '0914'),
('Vila Nova de Gaia', '1317'),
('Vila Nova de Paiva', '1822'),
('Vila Nova de Poiares', '0617'),
('Vila Pouca de Aguiar', '1713'),
('Vila real', '1714'),
('Vila Real de Santo António', '0816'),
('Vila velha de Ródão', '0511'),
('Vila verde', '0313'),
('Vila viçosa', '0714'),
('Vimioso', '0411'),
('Vinhais', '0412'),
('Viseu', '1823'),
('Vizela', '0314'),
('Vouzela', '1824');
