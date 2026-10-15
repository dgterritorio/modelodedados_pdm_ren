-- ==========================================================
-- Preparação do GeoPackage
-- Versão 2.0
-- ==========================================================

--
-- Text encoding used: UTF-8
--

PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- ==========================================================
-- TABELAS
-- ==========================================================

-- ==========================================================
-- TABLE: gpkg_ogr_contents
-- ==========================================================
DROP TABLE IF EXISTS gpkg_ogr_contents;

CREATE TABLE IF NOT EXISTS gpkg_ogr_contents(
    table_name TEXT NOT NULL PRIMARY KEY,
    feature_count INTEGER DEFAULT NULL
);

-- ==========================================================
-- Table: metadata
-- ==========================================================
DROP TABLE IF EXISTS metadata;

CREATE TABLE IF NOT EXISTS metadata (
    key TEXT PRIMARY KEY,
    value TEXT
);


-- ==========================================================
-- Table: codigo_ine
-- ==========================================================
DROP TABLE IF EXISTS codigo_ine;

CREATE TABLE IF NOT EXISTS codigo_ine (
    fid       INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    municipio TEXT,
    dtcc      TEXT UNIQUE
);


-- ==========================================================
-- Table: atribuir_municipio
-- ==========================================================
DROP TABLE IF EXISTS atribuir_municipio;

CREATE TABLE IF NOT EXISTS atribuir_municipio (
    fid  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK (fid = 1),
    dtcc TEXT UNIQUE,
    FOREIGN KEY (dtcc) REFERENCES codigo_ine (dtcc)
);


-- ==========================================================
-- Table: catalogo
-- ==========================================================
DROP TABLE IF EXISTS catalogo;

CREATE TABLE IF NOT EXISTS catalogo (
    fid               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    tema              TEXT,
    subtema           TEXT,
    objeto_designacao TEXT,
    objeto_codigo     INTEGER UNIQUE,
    legenda           TEXT,
    objeto_acronimo   TEXT,
    geometria         TEXT
);


-- ==========================================================
-- Table: tip_l
-- ==========================================================
DROP TABLE IF EXISTS tip_l;

CREATE TABLE IF NOT EXISTS tip_l (
    fid           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom          MULTILINESTRING,
    uuid          TEXT UNIQUE,
    dtcc          TEXT NOT NULL,
    objeto_codigo INTEGER NOT NULL,
    comp_m        REAL,
    FOREIGN KEY (objeto_codigo) REFERENCES catalogo (objeto_codigo),
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


-- ==========================================================
-- Table: tip_p
-- ==========================================================
DROP TABLE IF EXISTS tip_p;

CREATE TABLE IF NOT EXISTS tip_p (
    fid           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom          MULTIPOLYGON,
    uuid          TEXT         UNIQUE,
    dtcc          TEXT         NOT NULL,
    objeto_codigo INTEGER      NOT NULL,
    area_m2       REAL,
    FOREIGN KEY (objeto_codigo) REFERENCES catalogo (objeto_codigo),
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


-- ==========================================================
-- Table: excl_p
-- ==========================================================
DROP TABLE IF EXISTS excl_p;

CREATE TABLE IF NOT EXISTS excl_p (
    fid           INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom          MULTIPOLYGON,
    uuid          TEXT         UNIQUE,
    dtcc          TEXT         NOT NULL,
    exclusao      TEXT         UNIQUE,
    objeto_codigo INTEGER      NOT NULL,
    escala        INTEGER,
    area_m2       REAL,
    fundamento    TEXT,
    fim_dest      TEXT,
    FOREIGN KEY (objeto_codigo) REFERENCES catalogo (objeto_codigo),
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);


-- ==========================================================
-- VISTAS
-- ==========================================================

-- ==========================================================
-- View: catalogo_tip_p
-- ==========================================================
DROP VIEW IF EXISTS catalogo_tip_p;

CREATE VIEW IF NOT EXISTS catalogo_tip_p AS
    SELECT t.fid,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.objeto_codigo,
           t.legenda,
           t.objeto_acronimo,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao || ' (' || t.objeto_acronimo || ')'  AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE lower(t.geometria) LIKE lower('%polígono%') COLLATE NOCASE AND
           t.objeto_codigo NOT IN (37, 38);


-- ==========================================================
-- View: catalogo_excl_p
-- ==========================================================
DROP VIEW IF EXISTS catalogo_excl_p;

CREATE VIEW IF NOT EXISTS catalogo_excl_p AS
    SELECT t.fid,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.objeto_codigo,
           t.legenda,
           t.objeto_acronimo,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao || ' (' || t.objeto_acronimo || ')'  AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.objeto_codigo IN (37, 38);


-- ==========================================================
-- View: catalogo_tip_l
-- ==========================================================
DROP VIEW IF EXISTS catalogo_tip_l;

CREATE VIEW IF NOT EXISTS catalogo_tip_l AS
    SELECT t.fid,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.objeto_codigo,
           t.legenda,
           t.objeto_acronimo,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao || ' (' || t.objeto_acronimo || ')'  AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE lower(t.geometria) LIKE lower('%linha%') COLLATE NOCASE;


-- ==========================================================
-- View: excl_tip
-- ==========================================================
DROP VIEW IF EXISTS excl_tip;
CREATE VIEW IF NOT EXISTS excl_tip AS
WITH inter_valid AS (
        SELECT
            t.fid AS fid_tip_p,
            e.fid AS fid_excl_p,
            t.dtcc,
            t.objeto_codigo,
            l.objeto_designacao,
            e.exclusao,
            CASE WHEN ST_IsValid(t.geom) THEN t.geom ELSE ST_MakeValid(t.geom) END AS geom_t,
            CASE WHEN ST_IsValid(e.geom) THEN e.geom ELSE ST_MakeValid(e.geom) END AS geom_e
        FROM tip_p t
            JOIN 
            excl_p e ON t.dtcc = e.dtcc
            LEFT JOIN 
            catalogo l ON t.objeto_codigo = l.objeto_codigo
        WHERE t.geom IS NOT NULL AND
            e.geom IS NOT NULL AND
            ST_Intersects(t.geom, e.geom)
    ),
    inter AS (
        SELECT *,
            ST_Multi(ST_CollectionExtract(ST_Intersection(geom_t, geom_e), 3)) AS geom
        FROM inter_valid
    )
    SELECT
        CAST(ROW_NUMBER() OVER (ORDER BY fid_tip_p, fid_excl_p) AS INTEGER) AS fid,
        fid_tip_p,
        fid_excl_p,
        geom,
        dtcc,
        objeto_codigo,
        objeto_designacao,
        exclusao,
        CAST (ROUND(ST_Area(geom), 2) AS REAL) AS area_excl_tip
    FROM inter
    WHERE ST_Area(geom) > 0.01 AND
          geom IS NOT NULL AND
          NOT ST_IsEmpty(geom);


-- ==========================================================
-- View: quadro_anexo
-- ==========================================================
DROP VIEW IF EXISTS quadro_anexo;

CREATE VIEW IF NOT EXISTS quadro_anexo AS
    SELECT CAST (t.fid AS INTEGER) AS fid_excl_tip,
           t.exclusao,
           CAST (t.area_excl_tip AS REAL) AS area_m2,
           l.subtema,
           e.fim_dest,
           e.fundamento
    FROM excl_tip t
           JOIN
           excl_p e ON t.fid_excl_p = e.fid
           LEFT JOIN catalogo l ON t.objeto_codigo = l.objeto_codigo;


-- ==========================================================
-- TRIGGERS
-- ==========================================================

-- ==========================================================
-- Trigger: tip_p_calc_uuid_p - Table: tip_p
-- ==========================================================
DROP TRIGGER IF EXISTS "tip_p_calc_uuid_p";
CREATE TRIGGER IF NOT EXISTS "tip_p_calc_uuid_p"
AFTER INSERT ON "tip_p"
WHEN NEW."geom" IS NOT NULL
BEGIN
    UPDATE "tip_p"
       SET uuid = CASE
                    -- NULL, comprimento errado, ou formato invalido (RFC 4122 v4) -> gera novo
                    WHEN NEW."uuid" IS NULL
                      OR length(NEW."uuid") <> 36
                      OR NEW."uuid" NOT GLOB
                         '[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-4[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[89abAB][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]'
                    THEN (
                        SELECT substr(h, 1, 8) || '-' ||
                               substr(h, 9, 4) || '-' ||
                               '4' || substr(h, 14, 3) || '-' ||
                               substr('89ab', abs(random()) % 4 + 1, 1) || substr(h, 18, 3) || '-' ||
                               substr(h, 21, 12)
                        FROM (SELECT lower(hex(randomblob(16))) AS h)
                    )
                    -- Já é um UUID v4 valido -> apenas normaliza para minusculas
                    -- (garante compatibilidade byte-a-byte com gen_random_uuid() do PostgreSQL)
                    ELSE lower(NEW."uuid")
                  END,
           area_m2 = (ROUND(ST_Area(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: tip_p_recalc_p - Table: tip_p
-- ==========================================================
DROP TRIGGER IF EXISTS "tip_p_recalc_p";
CREATE TRIGGER IF NOT EXISTS "tip_p_recalc_p"
AFTER UPDATE OF "geom" ON "tip_p"
WHEN NEW."geom" IS NOT NULL
 AND (OLD."geom" IS NULL OR NOT ST_Equals(OLD."geom", NEW."geom"))
BEGIN
    UPDATE "tip_p"
       SET area_m2 = (ROUND(ST_Area(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: tip_p_uuid_protect - Table: tip_p
-- ==========================================================
DROP TRIGGER IF EXISTS "tip_p_uuid_protect";
CREATE TRIGGER IF NOT EXISTS "tip_p_uuid_protect"
BEFORE UPDATE OF "geom" ON "tip_p"
WHEN OLD."geom" IS NOT NULL
 AND NEW."geom" IS NOT OLD."geom"
BEGIN
    SELECT RAISE(FAIL, 'O campo geom e apenas de leitura e nao pode ser alterado.
Reponha o valor original ou cancele a edicao para repor o valor e edite novamente os restantes campos.');
END;


-- ==========================================================
-- Trigger: tip_l_calc_uuid_l - Table: tip_l
-- ==========================================================
DROP TRIGGER IF EXISTS "tip_l_calc_uuid_l";
CREATE TRIGGER IF NOT EXISTS "tip_l_calc_uuid_l"
AFTER INSERT ON "tip_l"
WHEN NEW."geom" IS NOT NULL
BEGIN
    UPDATE "tip_l"
       SET uuid = CASE
                    -- NULL, comprimento errado, ou formato invalido (RFC 4122 v4) -> gera novo
                    WHEN NEW."uuid" IS NULL
                      OR length(NEW."uuid") <> 36
                      OR NEW."uuid" NOT GLOB
                         '[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-4[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[89abAB][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]'
                    THEN (
                        SELECT substr(h, 1, 8) || '-' ||
                               substr(h, 9, 4) || '-' ||
                               '4' || substr(h, 14, 3) || '-' ||
                               substr('89ab', abs(random()) % 4 + 1, 1) || substr(h, 18, 3) || '-' ||
                               substr(h, 21, 12)
                        FROM (SELECT lower(hex(randomblob(16))) AS h)
                    )
                    -- Já é um UUID v4 valido -> apenas normaliza para minusculas
                    -- (garante compatibilidade byte-a-byte com gen_random_uuid() do PostgreSQL)
                    ELSE lower(NEW."uuid")
                  END,
           comp_m = (ROUND(ST_Length(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;


-- ==========================================================
-- Trigger: tip_l_recalc_l - Table: tip_l
-- ==========================================================
DROP TRIGGER IF EXISTS "tip_l_recalc_l";
CREATE TRIGGER IF NOT EXISTS "tip_l_recalc_l"
AFTER UPDATE OF "geom" ON "tip_l"
WHEN NEW."geom" IS NOT NULL
 AND (OLD."geom" IS NULL OR NOT ST_Equals(OLD."geom", NEW."geom"))
BEGIN
    UPDATE "tip_l"
       SET comp_m = (ROUND(ST_Length(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: tip_l_uuid_protect - Table: tip_l
-- ==========================================================
DROP TRIGGER IF EXISTS "tip_l_uuid_protect";
CREATE TRIGGER IF NOT EXISTS "tip_l_uuid_protect"
BEFORE UPDATE OF "geom" ON "tip_l"
WHEN OLD."geom" IS NOT NULL
 AND NEW."geom" IS NOT OLD."geom"
BEGIN
    SELECT RAISE(FAIL, 'O campo geom e apenas de leitura e nao pode ser alterado.
Reponha o valor original ou cancele a edicao para repor o valor e edite novamente os restantes campos.');
END;


-- ==========================================================
-- Trigger: excl_p_calc_uuid_p - Table: excl_p
-- ==========================================================
DROP TRIGGER IF EXISTS "excl_p_calc_uuid_p";
CREATE TRIGGER IF NOT EXISTS "excl_p_calc_uuid_p"
AFTER INSERT ON "excl_p"
WHEN NEW."geom" IS NOT NULL
BEGIN
    UPDATE "excl_p"
       SET uuid = CASE
                    -- NULL, comprimento errado, ou formato invalido (RFC 4122 v4) -> gera novo
                    WHEN NEW."uuid" IS NULL
                      OR length(NEW."uuid") <> 36
                      OR NEW."uuid" NOT GLOB
                         '[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-4[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[89abAB][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]-[0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]'
                    THEN (
                        SELECT substr(h, 1, 8) || '-' ||
                               substr(h, 9, 4) || '-' ||
                               '4' || substr(h, 14, 3) || '-' ||
                               substr('89ab', abs(random()) % 4 + 1, 1) || substr(h, 18, 3) || '-' ||
                               substr(h, 21, 12)
                        FROM (SELECT lower(hex(randomblob(16))) AS h)
                    )
                    -- Já é um UUID v4 valido -> apenas normaliza para minusculas
                    -- (garante compatibilidade byte-a-byte com gen_random_uuid() do PostgreSQL)
                    ELSE lower(NEW."uuid")
                  END,
           area_m2 = (ROUND(ST_Area(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: excl_p_recalc_p - Table: excl_p
-- ==========================================================
DROP TRIGGER IF EXISTS "excl_p_recalc_p";
CREATE TRIGGER IF NOT EXISTS "excl_p_recalc_p"
AFTER UPDATE OF "geom" ON "excl_p"
WHEN NEW."geom" IS NOT NULL
 AND (OLD."geom" IS NULL OR NOT ST_Equals(OLD."geom", NEW."geom"))
BEGIN
    UPDATE "excl_p"
       SET area_m2 = (ROUND(ST_Area(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: excl_p_uuid_protect - Table: excl_p
-- ==========================================================
DROP TRIGGER IF EXISTS "excl_p_uuid_protect";
CREATE TRIGGER IF NOT EXISTS "excl_p_uuid_protect"
BEFORE UPDATE OF "geom" ON "excl_p"
WHEN OLD."geom" IS NOT NULL
 AND NEW."geom" IS NOT OLD."geom"
BEGIN
    SELECT RAISE(FAIL, 'O campo geom e apenas de leitura e nao pode ser alterado.
Reponha o valor original ou cancele a edicao para repor o valor e edite novamente os restantes campos.');
END;


-- ==========================================================
-- INSERT
-- ==========================================================
-- ==========================================================
-- Table: metadata
-- ==========================================================
INSERT OR IGNORE INTO metadata
    (key, value) 
VALUES
    ('version', '2.0.0'),
    ('changelog', 'Primeira versão de produção.');


-- ==========================================================
-- Table: gpkg_spatial_ref_sys 
-- ==========================================================
INSERT OR IGNORE INTO gpkg_spatial_ref_sys
    (srs_name, srs_id, organization, organization_coordsys_id, definition, description, definition_12_063)
VALUES
    ('ETRS89 / Portugal TM06', 3763, 'EPSG', 3763,
     'PROJCS["ETRS89 / Portugal TM06",
    GEOGCS["ETRS89",
        DATUM["European_Terrestrial_Reference_System_1989",
            SPHEROID["GRS 1980",6378137,298.257222101,
                AUTHORITY["EPSG","7019"]],
            AUTHORITY["EPSG","6258"]],
        PRIMEM["Greenwich",0,
            AUTHORITY["EPSG","8901"]],
        UNIT["degree",0.0174532925199433,
            AUTHORITY["EPSG","9122"]],
        AUTHORITY["EPSG","4258"]],
    PROJECTION["Transverse_Mercator"],
    PARAMETER["latitude_of_origin",39.6682583333333],
    PARAMETER["central_meridian",-8.13310833333333],
    PARAMETER["scale_factor",1],
    PARAMETER["false_easting",0],
    PARAMETER["false_northing",0],
    UNIT["metre",1,
        AUTHORITY["EPSG","9001"]],
    AXIS["Easting",EAST],
    AXIS["Northing",NORTH],
    AUTHORITY["EPSG","3763"]]',
     'European Terrestrial Reference System 1989 ensemble',
     'PROJCRS["ETRS89 / Portugal TM06",
    BASEGEOGCRS["ETRS89",
        ENSEMBLE["European Terrestrial Reference System 1989 ensemble",
            MEMBER["European Terrestrial Reference Frame 1989"],
            MEMBER["European Terrestrial Reference Frame 1990"],
            MEMBER["European Terrestrial Reference Frame 1991"],
            MEMBER["European Terrestrial Reference Frame 1992"],
            MEMBER["European Terrestrial Reference Frame 1993"],
            MEMBER["European Terrestrial Reference Frame 1994"],
            MEMBER["European Terrestrial Reference Frame 1996"],
            MEMBER["European Terrestrial Reference Frame 1997"],
            MEMBER["European Terrestrial Reference Frame 2000"],
            MEMBER["European Terrestrial Reference Frame 2005"],
            MEMBER["European Terrestrial Reference Frame 2014"],
            MEMBER["European Terrestrial Reference Frame 2020"],
            ELLIPSOID["GRS 1980",6378137,298.257222101,
                LENGTHUNIT["metre",1]],
            ENSEMBLEACCURACY[0.1]],
        PRIMEM["Greenwich",0,
            ANGLEUNIT["degree",0.0174532925199433]],
        ID["EPSG",4258]],
    CONVERSION["Portugual TM06",
        METHOD["Transverse Mercator",
            ID["EPSG",9807]],
        PARAMETER["Latitude of natural origin",39.6682583333333,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8801]],
        PARAMETER["Longitude of natural origin",-8.13310833333333,
            ANGLEUNIT["degree",0.0174532925199433],
            ID["EPSG",8802]],
        PARAMETER["Scale factor at natural origin",1,
            SCALEUNIT["unity",1],
            ID["EPSG",8805]],
        PARAMETER["False easting",0,
            LENGTHUNIT["metre",1],
            ID["EPSG",8806]],
        PARAMETER["False northing",0,
            LENGTHUNIT["metre",1],
            ID["EPSG",8807]]],
    CS[Cartesian,2],
        AXIS["easting (X)",east,
            ORDER[1],
            LENGTHUNIT["metre",1]],
        AXIS["northing (Y)",north,
            ORDER[2],
            LENGTHUNIT["metre",1]],
    USAGE[
        SCOPE["Topographic mapping (medium scale)."],
        AREA["Portugal - mainland - onshore."],
        BBOX[36.95,-9.56,42.16,-6.19]],
    ID["EPSG",3763]]');


-- ==========================================================
-- Table: gpkg_contents
-- ==========================================================
INSERT INTO gpkg_contents 
     (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id)
 VALUES 
     ('atribuir_municipio', 'attributes', 'atribuir_municipio', 'Tabela auxiliar, alfanumérica; Identifica o município de trabalho do utilizador. Esta tabela contém um único registo e funciona como elemento de configuração, centralizando a identificação do território a que os dados se referem através do código DTCC. O respetivo código atua como chave estrangeira nas tabelas gráficas, garantindo a integridade referencial. Qualquer alteração ao registo é automaticamente refletida nas tabelas dependentes, assegurando a associação de todos os dados ao mesmo município.', NULL, NULL, NULL, NULL, NULL, NULL),
     ('catalogo', 'attributes', 'catalogo', 'Tabela auxiliar, alfanumérica; Identifica os objetos que podem existir na base de dados, a natureza geométrica que cada objeto pode assumir e a sua organização na carta da REN.', NULL, NULL, NULL, NULL, NULL, NULL),
     ('codigo_ine', 'attributes', 'codigo_ine', 'Tabela auxiliar, alfanumérica; Lista os municípios e respetivos códigos da divisão administrativa do Instituto Nacional de Estatística (código DTCC).', NULL, NULL, NULL, NULL, NULL, NULL),
     ('excl_p', 'features', 'excl_p', 'Tebela principal, gráfica; Contém os objetos com geometria do tipo poligonal que correspondem às áreas de exclusão. Cada linha da tabela corresponde a uma exclusão identificada pelo tipo (C ou E) e n.º ordem (de 1 a n). Inclui o campo escala para indicar a escala de detalhe da exclusão.', NULL, NULL, NULL, NULL, NULL, 3763),
     ('tip_l', 'features', 'tip_l', 'Tebela principal, gráfica; Contém os objetos com geometria do tipo linear - leitos dos cursos de água, canalizados ou não. Exemplo: O objeto Cursos de água-Leito (código 21) composto por várias linhas, tantas quantos os Rios, Ribeiros e afluentes ou outros considerados como REN, sendo que cada uma dessas linhas corresponde a um registo da tabela.', NULL, NULL, NULL, NULL, NULL, 3763),
     ('tip_p', 'features', 'tip_p', 'Tebela principal, gráfica; Contém os objetos com geometria do tipo poligonal que correspondem às tipologias delimitadas na carta da REN antes de serem ponderadas as exclusões (“REN Bruta”).  Quando um objeto do catálogo é composto por múltiplos polígonos, a cada polígono corresponde um registo na tabela.', NULL, NULL, NULL, NULL, NULL, 3763),
     ('catalogo_excl_p', 'attributes', 'catalogo_excl_p', 'Vista auxiliar; Permite a visualização das  exclusões (excl_p) e informação complementar proveniente do catálogo (designação e acrónimo). Gerada automaticamente pela BD.', NULL, NULL, NULL, NULL, NULL, NULL),
     ('catalogo_tip_l', 'attributes', 'catalogo_tip_l', 'Vista auxiliar; Permite a visualização das tipologias lineares (tip_l) e informação complementar proveniente do catálogo (designação e acrónimo). Gerada automaticamente pela BD.', NULL, NULL, NULL, NULL, NULL, NULL),
     ('catalogo_tip_p', 'attributes', 'catalogo_tip_p', 'Vista auxiliar; Permite a visualização das tipologias poligonais (tip_p) e informação complementar proveniente do catálogo (designação e acrónimo). Gerada automaticamente pela BD.', NULL, NULL, NULL, NULL, NULL, NULL),
     ('excl_tip', 'features', 'excl_tip', 'Vista de apoio (view), Identifica as diferentes tipologias abrangidas por cada exclusão. Esta vista resulta de uma query SQL que calcula a interseção espacial entre as geometrias das tabelas tip_p e excl_p com o mesmo DTCC. Como resultado, são gerados os polígonos correspondentes às áreas de sobreposição, preservando os atributos das respetivas tabelas de origem e calculando a área de cada interseção.', NULL, NULL, NULL, NULL, NULL, 3763),
     ('quadro_anexo', 'attributes', 'quadro_anexo', 'Vista de apoio (view), Agrega a informação necessária à elaboração do Quadro Anexo publicado no Diário da República, identificando, para cada exclusão, as tipologias REN abrangidas, a superfície excluída, a fundamentação e o fim a que se destina. Esta vista resulta de uma query SQL que relaciona e agrega atributos da vista excl_tip e das tabelas excl_p e catalogo.', NULL, NULL, NULL, NULL, NULL, NULL);


-- ==========================================================
-- Table: gpkg_data_columns
-- ==========================================================
INSERT INTO gpkg_data_columns 
     (table_name, column_name, name, title, description, mime_type, constraint_name)
 VALUES
     ('catalogo', 'tema', 'Tema', NULL, 'Descrição: Agregação de tipologias de áreas a incluir na REN ou áreas a excluir da REN.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'subtema', 'SubTema', NULL, 'Descrição: Designação da tipologia de área a incluir na REN ou do tipo de exclusão da REN.; Alias: SubTema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'objeto_designacao', 'Designação do Objeto', NULL, 'Descrição: Denominação atribuída ao objeto.; Alias: Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos da REN. Campo que identifica univocamente cada linha da tabela. Este campo funciona como chave estrangeira para as tabelas gráficas.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo', 'legenda', 'Legenda', NULL, 'Descrição: Texto que identifica o objeto na “Legenda da simbologia” da carta da REN.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'objeto_acronimo', 'Acrónimo', NULL, 'Descrição: Acrónimo do objeto, utilizado para identificação abreviada nos sistemas de informação.; Alias: Acrónimo; Tipo de data: TEXT', NULL, NULL),
     ('codigo_ine', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município. Este campo funciona como chave estrangeira para a tabela atribuir_municipio.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('excl_p', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('excl_p', 'exclusao', 'Exclusão', NULL, 'Descrição: Tipo e número de ordem da exclusão (de C1 a Cn e E1 a En).; Alias: Exclusão; Tipo de data: TEXT', NULL, NULL),
     ('excl_p', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos da REN (códigos 37 e 38).; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('excl_p', 'area_m2', 'Área (m2)', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados, calculada automaticamente.; Alias: Área (m2), Tipo de data: REAL', NULL, NULL),
     ('excl_p', 'fundamento', 'Fundamentação', NULL, 'Descrição: Fundamentação da necessidade de exclusão.; Alias: Fundamentação; Tipo de data: TEXT', NULL, NULL),
     ('excl_tip', 'fid', 'fid', NULL, 'Descrição: Numeração automática.; Alias: fid; Tipo de data: INT', NULL, NULL),
     ('excl_tip', 'fid_tip_p', 'fid_tip_p', NULL, 'Descrição: FID da tabela tip_p.; Alias: fid_tip_p; Tipo de data: INTEGER', NULL, NULL),
     ('excl_tip', 'fid_excl_p', 'fid_excl_p', NULL, 'Descrição: FID da tabela excl_p.; Alias: fid_excl_p; Tipo de data: INTEGER', NULL, NULL),
     ('tip_l', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('tip_l', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos da REN (códigos 21 e 22).; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('tip_l', 'comp_m', 'Comprimento (m)', NULL, 'Descrição: Comprimento do elemento linear em metros, calculado automaticamente.; Alias: Comprimento (m), Tipo de data: REAL', NULL, NULL),
     ('tip_p', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('tip_p', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos da REN (códigos 1 a 36 e 39).; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('tip_p', 'area_m2', 'Área (m2)', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados, calculada automaticamente.; Alias: Área (m2), Tipo de data: REAL', NULL, NULL),
     ('excl_tip', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36 e 39).; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('tip_l', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('tip_p', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('excl_p', 'dtcc', 'Município', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: Município; Tipo de data: TEXT', NULL, NULL),
     ('excl_tip', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('codigo_ine', 'municipio', 'Município', NULL, 'Descrição: Designação do Município.; Alias: Município; Tipo de data: TEXT', NULL, NULL),
     ('atribuir_municipio', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município. Este campo funciona como chave estrangeira para as tabelas gráficas.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono ou linha).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('excl_p', 'geom', 'geom', NULL, 'Descrição: Geometria do objeto do tipo MULTIPOLYGON.; Alias: geom; Tipo de data: MULTIPOLYGON', NULL, NULL),
     ('excl_p', 'fim_dest', 'Fim a que se destina', NULL, 'Descrição: Fim a que se destina a área a excluir.; Alias: Fim a que se destina; Tipo de data: TEXT', NULL, NULL),
     ('tip_l', 'geom', 'geom', NULL, 'Descrição: Geometria do objeto do tipo MULTILINESTRING.; Alias: geom; Tipo de data: MULTILINESTRING', NULL, NULL),
     ('tip_p', 'geom', 'geom', NULL, 'Descrição: Geometria do objeto do tipo MULTIPOLYGON.; Alias: geom; Tipo de data: MULTIPOLYGON', NULL, NULL),
     ('atribuir_municipio', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('codigo_ine', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('excl_tip', 'exclusao', 'Exclusão', NULL, 'Descrição: Tipo e número de ordem da exclusão (de C1 a Cn e E1 a En).; Alias: Exclusão; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'tema', 'Tema', NULL, 'Descrição: Agregação de tipologias de áreas a incluir na REN ou áreas a excluir da REN.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'subtema', 'Subtema', NULL, 'Descrição: Designação da tipologia de área a incluir na REN ou do tipo de exclusão da REN.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'objeto_designacao', 'Designação do Objeto', NULL, 'Descrição: Denominação atribuída ao objeto.; Alias: Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos. Campo que identifica univocamente cada linha da tabela.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_tip_l', 'legenda', 'Legenda', NULL, 'Descrição: Texto que identifica o objeto na “Legenda da simbologia” da carta da REN.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'objeto_acronimo', 'Acrónimo', NULL, 'Descrição: Acrónimo do objeto, utilizado para identificação abreviada nos sistemas de informação.; Alias: Acrónimo; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_p', 'tema', 'Tema', NULL, 'Descrição: Agregação de tipologias de áreas a incluir na REN ou áreas a excluir da REN.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_p', 'subtema', 'Subtema', NULL, 'Descrição: Designação da tipologia de área a incluir na REN ou do tipo de exclusão da REN.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_p', 'objeto_designacao', 'Designação do Objeto', NULL, 'Descrição: Denominação atribuída ao objeto.; Alias: Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_p', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos. Campo que identifica univocamente cada linha da tabela.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_tip_p', 'legenda', 'Legenda', NULL, 'Descrição: Texto que identifica o objeto na “Legenda da simbologia” da carta da REN.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_p', 'objeto_acronimo', 'Acrónimo', NULL, 'Descrição: Acrónimo do objeto, utilizado para identificação abreviada nos sistemas de informação.; Alias: Acrónimo; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'tema', 'Tema', NULL, 'Descrição: Agregação de tipologias de áreas a incluir na REN ou áreas a excluir da REN.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'subtema', 'Subtema', NULL, 'Descrição: Designação da tipologia de área a incluir na REN ou do tipo de exclusão da REN.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'objeto_designacao', 'Designação do Objeto', NULL, 'Descrição: Denominação atribuída ao objeto.; Alias: Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos. Campo que identifica univocamente cada linha da tabela.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_excl_p', 'legenda', 'Legenda', NULL, 'Descrição: Texto que identifica o objeto na “Legenda da simbologia” da carta da REN.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'objeto_acronimo', 'Acrónimo', NULL, 'Descrição: Acrónimo do objeto, utilizado para identificação abreviada nos sistemas de informação.; Alias: Acrónimo; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela, chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_tip_p', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela, chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_excl_p', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela, chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_tip_l', 'geometria', 'Geometria', NULL, 'Descrição: Campo para identificar a que tipo de geometria se aplica o "Código do Objeto"; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_p', 'geometria', 'Geometria', NULL, 'Descrição: Campo para identificar a que tipo de geometria se aplica o "Código do Objeto"; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'geometria', 'Geometria', NULL, 'Descrição: Campo para identificar a que tipo de geometria se aplica o "Código do Objeto"; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('quadro_anexo', 'exclusao', 'Exclusão (tipo e número de ordem)', NULL, 'Descrição: Tipo e número de ordem da exclusão (ex: E1, E2, C1…).; Alias: Exclusão (tipo e número de ordem), Tipo de data: TEXT', NULL, NULL),
     ('quadro_anexo', 'area_m2', 'Superfície (m2)', NULL, 'Descrição: Área da exclusão em metros quadrados (corresponde ao campo area_excl de excl_tip).; Alias: Superfície (m2), Tipo de data: REAL', NULL, NULL),
     ('quadro_anexo', 'fim_dest', 'Fim a que se destina', NULL, 'Descrição: Fim a que se destina a área a excluir.; Alias: Fim a que se destina; Tipo de data: TEXT', NULL, NULL),
     ('quadro_anexo', 'fundamento', 'Síntese da fundamentação', NULL, 'Descrição: Síntese da fundamentação da exclusão.; Alias: Síntese da fundamentação; Tipo de data: TEXT', NULL, NULL),
     ('tip_l', 'uuid', 'UUID', NULL, 'Descrição: Identificador único universal (UUID) do registo, gerado automaticamente.; Alias: UUID; Tipo de data: TEXT', NULL, NULL),
     ('tip_p', 'uuid', 'UUID', NULL, 'Descrição: Identificador único universal (UUID) do registo, gerado automaticamente.; Alias: UUID; Tipo de data: TEXT', NULL, NULL),
     ('excl_p', 'uuid', 'UUID', NULL, 'Descrição: Identificador único universal (UUID) do registo, gerado automaticamente.; Alias: UUID; Tipo de data: TEXT', NULL, NULL),
     ('excl_p', 'escala', 'Escala de aquisição', NULL, 'Descrição: Escala da exclusão no momento da aquisição. Formato: Deve ser referido apenas o módulo da escala ("n" em vez de "1:n").; Alias: Escala de aquisição; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_tip_p', 'cod_designacao', 'Código - Designação do Objeto', NULL, 'Descrição: Código do objeto - Designação do objeto.; Alias: Código - Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_tip_l', 'cod_designacao', 'Código - Designação do Objeto', NULL, 'Descrição: Código do objeto - Designação do objeto.; Alias: Código - Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_excl_p', 'cod_designacao', 'Código - Designação do Objeto', NULL, 'Descrição: Código do objeto - Designação do objeto.; Alias: Código - Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('excl_tip', 'geom', 'geom', NULL, 'Descrição: Geometria do tipo MULTIPOLYGON.; Alias: geom; Tipo de data: MULTIPOLYGON', NULL, NULL),
     ('excl_tip', 'area_excl_tip', 'Área (m2)', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados, calculada automaticamente (idêntica à área da exclusão).; Alias: Área (m2), Tipo de data: REAL', NULL, NULL),
     ('excl_tip', 'objeto_designacao', 'Designação do Objeto', NULL, 'Descrição: Denominação atribuída ao objeto (códigos 1 a 36 e 39).; Alias: Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('quadro_anexo', 'fid_excl_tip', 'fid_excl_tip', NULL, 'Descrição: Identificador do registo na vista excl_tip (chave de ligação à exclusão).; Alias: fid_excl_tip; Tipo de data: INT', NULL, NULL),
     ('quadro_anexo', 'subtema', 'Tipologia(s) REN', NULL, 'Descrição: Nome da(s) tipologia(s) REN abrangida(s) pela exclusão (obtido do catálogo).; Alias: Tipologia(s) REN; Tipo de data: TEXT', NULL, NULL);


-- ==========================================================
-- Table: gpkg_extensions
-- ==========================================================
INSERT INTO gpkg_extensions 
     (table_name, column_name, extension_name, definition, scope)
 VALUES
     ('gpkg_data_columns', NULL, 'gpkg_schema', 'https://www.geopackage.org/spec140/#extension_schema', 'read-write'),
     ('gpkg_data_column_constraints', NULL, 'gpkg_schema', 'https://www.geopackage.org/spec140/#extension_schema', 'read-write'),
     ('gpkg_metadata', NULL, 'gpkg_metadata', 'https://www.geopackage.org/spec140/#extension_metadata', 'read-write'),
     ('gpkg_metadata_reference', NULL, 'gpkg_metadata', 'https://www.geopackage.org/spec140/#extension_metadata', 'read-write'),
     ('gpkg_spatial_ref_sys', 'definition_12_063', 'gpkg_crs_wkt', 'https://www.geopackage.org/spec140/#extension_crs_wkt', 'read-write'),
     ('excl_p', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only'),
     ('tip_l', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only'),
     ('tip_p', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only'),
     ('excl_tip', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only');


-- ==========================================================
-- Table: gpkg_geometry_columns
-- ==========================================================
INSERT INTO gpkg_geometry_columns
     (table_name, column_name, geometry_type_name, srs_id, z, m)
 VALUES
     ('excl_p', 'geom', 'MULTIPOLYGON', 3763, 0, 0),
     ('tip_l', 'geom', 'MULTILINESTRING', 3763, 0, 0),
     ('tip_p', 'geom', 'MULTIPOLYGON', 3763, 0, 0),
     ('excl_tip', 'geom', 'MULTIPOLYGON', 3763, 0, 0);


-- ==========================================================
-- Tabela: catalogo
-- ==========================================================
INSERT INTO catalogo 
     (fid, tema, subtema, objeto_designacao, objeto_codigo, legenda, objeto_acronimo, geometria)
 VALUES 
     (1, 'Áreas de proteção do litoral', 'Faixa marítima de proteção costeira', 'Faixa marítima de proteção costeira', 1, 'Faixa marítima de proteção costeira', 'FMPC', 'polígono'),
     (2, 'Áreas de proteção do litoral', 'Praias', 'Praias', 2, 'Praias', 'PRA', 'polígono'),
     (3, 'Áreas de proteção do litoral', 'Barreiras detríticas', 'Restingas', 3, 'Barreiras detríticas', 'REST', 'polígono'),
     (4, 'Áreas de proteção do litoral', 'Barreiras detríticas', 'Barreiras soldadas', 4, 'Barreiras detríticas', 'BARR_SOLD', 'polígono'),
     (5, 'Áreas de proteção do litoral', 'Barreiras detríticas', 'Ilhas-Barreira', 5, 'Barreiras detríticas', 'ILH-BARR', 'polígono'),
     (6, 'Áreas de proteção do litoral', 'Tômbolos', 'Tômbolos', 6, 'Tômbolos', 'TOMB', 'polígono'),
     (7, 'Áreas de proteção do litoral', 'Sapais', 'Sapais', 7, 'Sapais', 'SAP', 'polígono'),
     (8, 'Áreas de proteção do litoral', 'Ilhéus e rochedos emersos no mar', 'Ilhéus', 8, 'Ilhéus e rochedos emersos no mar', 'ILHEUS', 'polígono'),
     (9, 'Áreas de proteção do litoral', 'Ilhéus e rochedos emersos no mar', 'Rochedos emersos no mar', 9, 'Ilhéus e rochedos emersos no mar', 'ROCHEDOS', 'polígono'),
     (10, 'Áreas de proteção do litoral', 'Dunas costeiras e dunas fósseis', 'Dunas costeiras litorais', 10, 'Dunas costeiras litorais', 'DUN_LIT', 'polígono'),
     (11, 'Áreas de proteção do litoral', 'Dunas costeiras e dunas fósseis', 'Dunas costeiras interiores', 11, 'Dunas costeiras interiores', 'DUN_INT', 'polígono'),
     (12, 'Áreas de proteção do litoral', 'Dunas costeiras e dunas fósseis', 'Dunas fósseis', 12, 'Dunas fósseis', 'DUN_FOSS', 'polígono'),
     (13, 'Áreas de proteção do litoral', 'Arribas e respetivas faixas de proteção', 'Arribas', 13, 'Arribas', 'ARRIB', 'polígono'),
     (14, 'Áreas de proteção do litoral', 'Arribas e respetivas faixas de proteção', 'Faixa de proteção de arribas a partir do rebordo superior', 14, 'Faixas de proteção das arribas', 'FPA_SUP', 'polígono'),
     (15, 'Áreas de proteção do litoral', 'Arribas e respetivas faixas de proteção', 'Faixa de proteção de arribas a partir da base da arriba', 15, 'Faixas de proteção das arribas', 'FPA_BASE', 'polígono'),
     (16, 'Áreas de proteção do litoral', 'Faixa terrestre de proteção costeira', 'Faixa terrestre de proteção costeira', 16, 'Faixa terrestre de proteção costeira', 'FTPC', 'polígono'),
     (17, 'Áreas de proteção do litoral', 'Faixa terrestre de proteção costeira', 'Águas do mar - Margem', 17, 'Águas do mar - Margem', 'AG_MAR', 'polígono'),
     (18, 'Áreas de proteção do litoral', 'Águas de transição e respetivos leitos, margens e faixas de proteção', 'Águas de transição - Leito', 18, 'Águas de transição - Leito', 'AT_LEITO', 'polígono'),
     (19, 'Áreas de proteção do litoral', 'Águas de transição e respetivos leitos, margens e faixas de proteção', 'Águas de transição - Faixa de proteção - Margem', 19, 'Águas de transição - Faixa de proteção - Margem', 'AT_MARGEM', 'polígono'),
     (20, 'Áreas de proteção do litoral', 'Águas de transição e respetivos leitos, margens e faixas de proteção', 'Águas de transição - Faixa de proteção - Contígua à margem', 20, 'Águas de transição - Faixa de proteção - Contígua à margem', 'AT_FP', 'polígono'),
     (21, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Cursos de água e respetivos leitos e margens', 'Cursos de água - Leito', 21, 'Cursos de água - Leito', 'CA_LEITO', 'linha, polígono'),
     (22, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Cursos de água e respetivos leitos e margens', 'Cursos de água - Leito canalizado', 22, 'Cursos de água - Leito canalizado', 'CA_LCANAL', 'linha'),
     (23, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Cursos de água e respetivos leitos e margens', 'Cursos de água - Margem', 23, 'Cursos de água - Margem', 'CA_MARGEM', 'polígono'),
     (24, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Lagoas e lagos e respetivos leitos, margens e faixas de proteção', 'Lagoas e lagos - Leito', 24, 'Lagoas e lagos - Leito', 'LL_LEITO', 'polígono'),
     (25, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Lagoas e lagos e respetivos leitos, margens e faixas de proteção', 'Lagoas e lagos - Faixa de proteção - Margem', 25, 'Lagoas e lagos - Faixa de proteção - Margem', 'LL_MARGEM', 'polígono'),
     (26, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Lagoas e lagos e respetivos leitos, margens e faixas de proteção', 'Lagoas e lagos - Faixa de proteção - Contígua à margem', 26, 'Lagoas e lagos - Faixa de proteção - Contígua à margem', 'LL_FP', 'polígono'),
     (27, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção', 'Albufeiras - Leito', 27, 'Albufeiras - Leito', 'ALB_LEITO', 'polígono'),
     (28, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção', 'Albufeiras - Faixa de proteção - Margem', 28, 'Albufeiras - Faixa de proteção - Margem', 'ALB_MARGEM', 'polígono'),
     (29, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção', 'Albufeiras - Faixa de proteção - Contígua à margem', 29, 'Albufeiras - Faixa de proteção - Contígua à margem', 'ALB_FP', 'polígono'),
     (30, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Áreas estratégicas de infiltração e de proteção e recarga de aquíferos', 'Áreas estratégicas de infiltração e de proteção e recarga de aquíferos', 30, 'Áreas estratégicas de infiltração e de proteção e recarga de aquíferos', 'AEIPRA', 'polígono'),
     (31, 'Áreas de prevenção de riscos naturais', 'Zonas adjacentes', 'Zonas adjacentes', 31, 'Zonas adjacentes', 'ZA', 'polígono'),
     (32, 'Áreas de prevenção de riscos naturais', 'Zonas ameaçadas pelo mar', 'Zonas ameaçadas pelo mar', 32, 'Zonas ameaçadas pelo mar', 'ZAM', 'polígono'),
     (33, 'Áreas de prevenção de riscos naturais', 'Zonas ameaçadas pelas cheias', 'Zonas ameaçadas pelas cheias', 33, 'Zonas ameaçadas pelas cheias', 'ZAC', 'polígono'),
     (34, 'Áreas de prevenção de riscos naturais', 'Áreas de elevado risco de erosão hídrica do solo', 'Áreas de elevado risco de erosão hídrica do solo', 34, 'Áreas de elevado risco de erosão hídrica do solo', 'AEREHS', 'polígono'),
     (35, 'Áreas de prevenção de riscos naturais', 'Áreas de instabilidade de vertentes', 'Áreas de instabilidade de vertentes', 35, 'Áreas de instabilidade de vertentes', 'AIV', 'polígono'),
     (36, 'Áreas de prevenção de riscos naturais', 'Áreas de instabilidade de vertentes', 'Escarpas', 36, 'Escarpas', 'ESCARP', 'polígono'),
     (37, 'Áreas de exclusão', 'Exclusão por compromisso - C', 'Exclusão por compromisso - C', 37, 'Exclusão por compromisso - C', 'EXCL_C', 'polígono'),
     (38, 'Áreas de exclusão', 'Exclusão para a satisfação de carências - E', 'Exclusão para a satisfação de carências - E', 38, 'Exclusão para a satisfação de carências - E', 'EXCL_E', 'polígono'),
     (39, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Áreas estratégicas de infiltração e de proteção e recarga de aquíferos', 'Cabeceiras das Bacias Hidrográficas', 39, 'Cabeceiras das Bacias Hidrográficas', 'CBH', 'polígono');


-- ==========================================================
-- Table: codigo_ine
-- ==========================================================
INSERT OR IGNORE INTO codigo_ine
     (fid, municipio, dtcc)
 VALUES 
     (1, 'Abrantes', '1401'),
     (2, 'Águeda', '0101'),
     (3, 'Aguiar da Beira', '0901'),
     (4, 'Alandroal', '0701'),
     (5, 'Albergaria-a-Velha', '0102'),
     (6, 'Albufeira', '0801'),
     (7, 'Alcácer do Sal', '1501'),
     (8, 'Alcanena', '1402'),
     (9, 'Alcobaça', '1001'),
     (10, 'Alcochete', '1502'),
     (11, 'Alcoutim', '0802'),
     (12, 'Alenquer', '1101'),
     (13, 'Alfândega da Fé', '0401'),
     (14, 'Alijó', '1701'),
     (15, 'Aljezur', '0803'),
     (16, 'Aljustrel', '0201'),
     (17, 'Almada', '1503'),
     (18, 'Almeida', '0902'),
     (19, 'Almeirim', '1403'),
     (20, 'Almodôvar', '0202'),
     (21, 'Alpiarça', '1404'),
     (22, 'Alter do Chão', '1201'),
     (23, 'Alvaiázere', '1002'),
     (24, 'Alvito', '0203'),
     (25, 'Amadora', '1115'),
     (26, 'Amarante', '1301'),
     (27, 'Amares', '0301'),
     (28, 'Anadia', '0103'),
     (29, 'Ansião', '1003'),
     (30, 'Arcos de Valdevez', '1601'),
     (31, 'Arganil', '0601'),
     (32, 'Armamar', '1801'),
     (33, 'Arouca', '0104'),
     (34, 'Arraiolos', '0702'),
     (35, 'Arronches', '1202'),
     (36, 'Arruda dos Vinhos', '1102'),
     (37, 'Aveiro', '0105'),
     (38, 'Avis', '1203'),
     (39, 'Azambuja', '1103'),
     (40, 'Baião', '1302'),
     (41, 'Barcelos', '0302'),
     (42, 'Barrancos', '0204'),
     (43, 'Barreiro', '1504'),
     (44, 'Batalha', '1004'),
     (45, 'Beja', '0205'),
     (46, 'Belmonte', '0501'),
     (47, 'Benavente', '1405'),
     (48, 'Bombarral', '1005'),
     (49, 'Borba', '0703'),
     (50, 'Boticas', '1702'),
     (51, 'Braga', '0303'),
     (52, 'Bragança', '0402'),
     (53, 'Cabeceiras de Basto', '0304'),
     (54, 'Cadaval', '1104'),
     (55, 'Caldas da Rainha', '1006'),
     (56, 'Caminha', '1602'),
     (57, 'Campo Maior', '1204'),
     (58, 'Cantanhede', '0602'),
     (59, 'Carrazeda de Ansiães', '0403'),
     (60, 'Carregal do Sal', '1802'),
     (61, 'Cartaxo', '1406'),
     (62, 'Cascais', '1105'),
     (63, 'Castanheira de Pêra', '1007'),
     (64, 'Castelo Branco', '0502'),
     (65, 'Castelo de Paiva', '0106'),
     (66, 'Castelo de Vide', '1205'),
     (67, 'Castro Daire', '1803'),
     (68, 'Castro Marim', '0804'),
     (69, 'Castro Verde', '0206'),
     (70, 'Celorico da Beira', '0903'),
     (71, 'Celorico de Basto', '0305'),
     (72, 'Chamusca', '1407'),
     (73, 'Chaves', '1703'),
     (74, 'Cinfães', '1804'),
     (75, 'Coimbra', '0603'),
     (76, 'Condeixa-a-Nova', '0604'),
     (77, 'Constância', '1408'),
     (78, 'Coruche', '1409'),
     (79, 'Covilhã', '0503'),
     (80, 'Crato', '1206'),
     (81, 'Cuba', '0207'),
     (82, 'Elvas', '1207'),
     (83, 'Entroncamento', '1410'),
     (84, 'Espinho', '0107'),
     (85, 'Esposende', '0306'),
     (86, 'Estarreja', '0108'),
     (87, 'Estremoz', '0704'),
     (88, 'Évora', '0705'),
     (89, 'Fafe', '0307'),
     (90, 'Faro', '0805'),
     (91, 'Felgueiras', '1303'),
     (92, 'Ferreira do Alentejo', '0208'),
     (93, 'Ferreira do Zêzere', '1411'),
     (94, 'Figueira da Foz', '0605'),
     (95, 'Figueira de Castelo Rodrigo', '0904'),
     (96, 'Figueiró dos Vinhos', '1008'),
     (97, 'Fornos de Algodres', '0905'),
     (98, 'Freixo de Espada à Cinta', '0404'),
     (99, 'Fronteira', '1208'),
     (100, 'Fundão', '0504'),
     (101, 'Gavião', '1209'),
     (102, 'Góis', '0606'),
     (103, 'Golegã', '1412'),
     (104, 'Gondomar', '1304'),
     (105, 'Gouveia', '0906'),
     (106, 'Grândola', '1505'),
     (107, 'Guarda', '0907'),
     (108, 'Guimarães', '0308'),
     (109, 'Idanha-a-Nova', '0505'),
     (110, 'Ílhavo', '0110'),
     (111, 'Lagoa', '0806'),
     (112, 'Lagos', '0807'),
     (113, 'Lamego', '1805'),
     (114, 'Leiria', '1009'),
     (115, 'Lisboa', '1106'),
     (116, 'Loulé', '0808'),
     (117, 'Loures', '1107'),
     (118, 'Lourinhã', '1108'),
     (119, 'Lousã', '0607'),
     (120, 'Lousada', '1305'),
     (121, 'Mação', '1413'),
     (122, 'Macedo de Cavaleiros', '0405'),
     (123, 'Mafra', '1109'),
     (124, 'Maia', '1306'),
     (125, 'Mangualde', '1806'),
     (126, 'Manteigas', '0908'),
     (127, 'Marco de Canaveses', '1307'),
     (128, 'Marinha Grande', '1010'),
     (129, 'Marvão', '1210'),
     (130, 'Matosinhos', '1308'),
     (131, 'Mealhada', '0111'),
     (132, 'Meda', '0909'),
     (133, 'Melgaço', '1603'),
     (134, 'Mértola', '0209'),
     (135, 'Mesão Frio', '1704'),
     (136, 'Mira', '0608'),
     (137, 'Miranda do Corvo', '0609'),
     (138, 'Miranda do Douro', '0406'),
     (139, 'Mirandela', '0407'),
     (140, 'Mogadouro', '0408'),
     (141, 'Moimenta da Beira', '1807'),
     (142, 'Moita', '1506'),
     (143, 'Monção', '1604'),
     (144, 'Monchique', '0809'),
     (145, 'Mondim de Basto', '1705'),
     (146, 'Monforte', '1211'),
     (147, 'Montalegre', '1706'),
     (148, 'Montemor-o-Novo', '0706'),
     (149, 'Montemor-o-Velho', '0610'),
     (150, 'Montijo', '1507'),
     (151, 'Mora', '0707'),
     (152, 'Mortágua', '1808'),
     (153, 'Moura', '0210'),
     (154, 'Mourão', '0708'),
     (155, 'Murça', '1707'),
     (156, 'Murtosa', '0112'),
     (157, 'Nazaré', '1011'),
     (158, 'Nelas', '1809'),
     (159, 'Nisa', '1212'),
     (160, 'Óbidos', '1012'),
     (161, 'Odemira', '0211'),
     (162, 'Odivelas', '1116'),
     (163, 'Oeiras', '1110'),
     (164, 'Oleiros', '0506'),
     (165, 'Olhão', '0810'),
     (166, 'Oliveira de Azeméis', '0113'),
     (167, 'Oliveira de Frades', '1810'),
     (168, 'Oliveira do Bairro', '0114'),
     (169, 'Oliveira do Hospital', '0611'),
     (170, 'Ourém', '1421'),
     (171, 'Ourique', '0212'),
     (172, 'Ovar', '0115'),
     (173, 'Paços de Ferreira', '1309'),
     (174, 'Palmela', '1508'),
     (175, 'Pampilhosa da Serra', '0612'),
     (176, 'Paredes', '1310'),
     (177, 'Paredes de Coura', '1605'),
     (178, 'Pedrógão Grande', '1013'),
     (179, 'Penacova', '0613'),
     (180, 'Penafiel', '1311'),
     (181, 'Penalva do Castelo', '1811'),
     (182, 'Penamacor', '0507'),
     (183, 'Penedono', '1812'),
     (184, 'Penela', '0614'),
     (185, 'Peniche', '1014'),
     (186, 'Peso da Régua', '1708'),
     (187, 'Pinhel', '0910'),
     (188, 'Pombal', '1015'),
     (189, 'Ponte da Barca', '1606'),
     (190, 'Ponte de Lima', '1607'),
     (191, 'Ponte de sor', '1213'),
     (192, 'Portalegre', '1214'),
     (193, 'Portel', '0709'),
     (194, 'Portimão', '0811'),
     (195, 'Porto', '1312'),
     (196, 'Porto de Mós', '1016'),
     (197, 'Póvoa de Lanhoso', '0309'),
     (198, 'Póvoa de Varzim', '1313'),
     (199, 'Proença-a-Nova', '0508'),
     (200, 'Redondo', '0710'),
     (201, 'Reguengos de Monsaraz', '0711'),
     (202, 'Resende', '1813'),
     (203, 'Ribeira de Pena', '1709'),
     (204, 'Rio Maior', '1414'),
     (205, 'Sabrosa', '1710'),
     (206, 'Sabugal', '0911'),
     (207, 'Salvaterra de Magos', '1415'),
     (208, 'Santa Comba Dão', '1814'),
     (209, 'Santa Maria da Feira', '0109'),
     (210, 'Santa Marta de Penaguião', '1711'),
     (211, 'Santarém', '1416'),
     (212, 'Santiago do Cacém', '1509'),
     (213, 'Santo Tirso', '1314'),
     (214, 'São Brás de Alportel', '0812'),
     (215, 'São João da Madeira', '0116'),
     (216, 'São João da Pesqueira', '1815'),
     (217, 'São Pedro do Sul', '1816'),
     (218, 'Sardoal', '1417'),
     (219, 'Sátão', '1817'),
     (220, 'Seia', '0912'),
     (221, 'Seixal', '1510'),
     (222, 'Sernancelhe', '1818'),
     (223, 'Serpa', '0213'),
     (224, 'Sertã', '0509'),
     (225, 'Sesimbra', '1511'),
     (226, 'Setúbal', '1512'),
     (227, 'Sever do Vouga', '0117'),
     (228, 'Silves', '0813'),
     (229, 'Sines', '1513'),
     (230, 'Sintra', '1111'),
     (231, 'Sobral de Monte Agraço', '1112'),
     (232, 'Soure', '0615'),
     (233, 'Sousel', '1215'),
     (234, 'Tábua', '0616'),
     (235, 'Tabuaço', '1819'),
     (236, 'Tarouca', '1820'),
     (237, 'Tavira', '0814'),
     (238, 'Terras de Bouro', '0310'),
     (239, 'Tomar', '1418'),
     (240, 'Tondela', '1821'),
     (241, 'Torre de Moncorvo', '0409'),
     (242, 'Torres Novas', '1419'),
     (243, 'Torres Vedras', '1113'),
     (244, 'Trancoso', '0913'),
     (245, 'Trofa', '1318'),
     (246, 'Vagos', '0118'),
     (247, 'Vale de Cambra', '0119'),
     (248, 'Valença', '1608'),
     (249, 'Valongo', '1315'),
     (250, 'Valpaços', '1712'),
     (251, 'Vendas Novas', '0712'),
     (252, 'Viana do Alentejo', '0713'),
     (253, 'Viana do Castelo', '1609'),
     (254, 'Vidigueira', '0214'),
     (255, 'Vieira do Minho', '0311'),
     (256, 'Vila de Rei', '0510'),
     (257, 'Vila do Bispo', '0815'),
     (258, 'Vila do Conde', '1316'),
     (259, 'Vila Flor', '0410'),
     (260, 'Vila Franca de Xira', '1114'),
     (261, 'Vila Nova da Barquinha', '1420'),
     (262, 'Vila Nova de Cerveira', '1610'),
     (263, 'Vila nova de Famalicão', '0312'),
     (264, 'Vila Nova de Foz Côa', '0914'),
     (265, 'Vila Nova de Gaia', '1317'),
     (266, 'Vila Nova de Paiva', '1822'),
     (267, 'Vila Nova de Poiares', '0617'),
     (268, 'Vila Pouca de Aguiar', '1713'),
     (269, 'Vila real', '1714'),
     (270, 'Vila Real de Santo António', '0816'),
     (271, 'Vila velha de Ródão', '0511'),
     (272, 'Vila verde', '0313'),
     (273, 'Vila viçosa', '0714'),
     (274, 'Vimioso', '0411'),
     (275, 'Vinhais', '0412'),
     (276, 'Viseu', '1823'),
     (277, 'Vizela', '0314'),
     (278, 'Vouzela', '1824');


-- ==========================================================
-- Table: atribuir_municipio
-- ==========================================================
INSERT OR IGNORE INTO atribuir_municipio 
     (dtcc)
 VALUES 
     ('1401');


-- ==========================================================
-- Table: gpkg_ogr_contents
-- ==========================================================
INSERT OR IGNORE INTO gpkg_ogr_contents
     (table_name, feature_count)
 VALUES 
     ('codigo_ine', 278),
     ('atribuir_municipio', 1),
     ('catalogo', 39),
     ('tip_l', 0),
     ('tip_p', 0),
     ('excl_p', 0);


-- COMMIT TRANSACTION;
PRAGMA foreign_keys = on;