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
-- Table: objeto_planta
-- ==========================================================
DROP TABLE IF EXISTS objeto_planta;

CREATE TABLE IF NOT EXISTS objeto_planta (
    fid    INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    planta TEXT UNIQUE CHECK (planta IN ('Condicionantes', 'Ordenamento'))
);


-- ==========================================================
-- Table: catalogo
-- ==========================================================
DROP TABLE IF EXISTS catalogo;

CREATE TABLE IF NOT EXISTS catalogo (
    fid               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    objeto_codigo     INTEGER NOT NULL,
    planta            TEXT    NOT NULL,
    tema              TEXT,
    subtema           TEXT,
    objeto_designacao TEXT,
    etiqueta          TEXT,
    geometria         TEXT,
    observacoes       TEXT,
    UNIQUE (objeto_codigo, planta),
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta) 
);



-- ==========================================================
-- Table: objeto_ponto
-- ==========================================================
DROP TABLE IF EXISTS objeto_ponto;

CREATE TABLE IF NOT EXISTS objeto_ponto (
    fid               INTEGER    PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom              MULTIPOINT,
    uuid              TEXT,
    dtcc              TEXT NOT NULL,
    planta            TEXT NOT NULL CHECK (planta IN ('Condicionantes', 'Ordenamento')),
    objeto_codigo     INTEGER NOT NULL,
    legenda           TEXT,
    etiqueta          TEXT,
    id_ato_especifico INTEGER,
    FOREIGN KEY (planta, objeto_codigo) REFERENCES catalogo (planta, objeto_codigo),
    FOREIGN KEY (id_ato_especifico) REFERENCES ato_especifico (id_ato_especifico),
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta),
    -- Se for o valor 'Ordenamento' - id_ato_especifico tem de ser NULL
    -- Se for o valor 'Condicionantes' - não há restrição (pode ser NULL ou ter valor)
    CHECK (planta != 'Ordenamento' OR id_ato_especifico IS NULL)
);


-- ==========================================================
-- Table: objeto_linha
-- ==========================================================
DROP TABLE IF EXISTS objeto_linha;

CREATE TABLE IF NOT EXISTS objeto_linha (
    fid               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom              MULTILINESTRING,
    uuid              TEXT,
    dtcc              TEXT NOT NULL,
    planta            TEXT NOT NULL CHECK (planta IN ('Condicionantes', 'Ordenamento')),
    objeto_codigo     INTEGER NOT NULL,
    legenda           TEXT,
    etiqueta          TEXT,
    comp_m            REAL,
    id_ato_especifico INTEGER,
    FOREIGN KEY (planta, objeto_codigo) REFERENCES catalogo (planta, objeto_codigo),
    FOREIGN KEY (id_ato_especifico) REFERENCES ato_especifico (id_ato_especifico),
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc) 
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta),
    -- Se for o valor 'Ordenamento' - id_ato_especifico tem de ser NULL
    -- Se for o valor 'Condicionantes' - não há restrição (pode ser NULL ou ter valor)
    CHECK (planta != 'Ordenamento' OR id_ato_especifico IS NULL)
);


-- ==========================================================
-- Table: objeto_poligono
-- ==========================================================
DROP TABLE IF EXISTS objeto_poligono;

CREATE TABLE IF NOT EXISTS objeto_poligono (
    fid               INTEGER      PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom              MULTIPOLYGON,
    uuid              TEXT,
    dtcc              TEXT NOT NULL,
    planta            TEXT NOT NULL CHECK (planta IN ('Condicionantes', 'Ordenamento')),
    objeto_codigo     INTEGER NOT NULL,
    legenda           TEXT,
    etiqueta          TEXT,
    area_m2           REAL,
    id_ato_especifico INTEGER,
    FOREIGN KEY (planta, objeto_codigo) REFERENCES catalogo (planta, objeto_codigo),
    FOREIGN KEY (id_ato_especifico) REFERENCES ato_especifico (id_ato_especifico),
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc) 
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta),
    -- Se for o valor 'Ordenamento' - id_ato_especifico tem de ser NULL
    -- Se for o valor 'Condicionantes' - não há restrição (pode ser NULL ou ter valor)
    CHECK (planta != 'Ordenamento' OR id_ato_especifico IS NULL)
);


-- ==========================================================
-- Table: ato_especifico
-- ==========================================================
DROP TABLE IF EXISTS ato_especifico;

CREATE TABLE IF NOT EXISTS ato_especifico (
    fid               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    id_ato_especifico INTEGER NOT NULL UNIQUE,
    serie_dr          TEXT,
    numero_dr         TEXT,
    tipo_ato          TEXT,
    numero_ato        TEXT    NOT NULL,
    data_publicacao   DATE,
    dtcc              TEXT,
    FOREIGN KEY (dtcc) REFERENCES atribuir_municipio (dtcc)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


-- ==========================================================
-- VISTAS
-- ==========================================================

-- ==========================================================
-- View: catalogo_cond
-- ==========================================================
DROP VIEW IF EXISTS catalogo_cond;
CREATE VIEW IF NOT EXISTS catalogo_cond AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           t.observacoes,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Condicionantes';


-- ==========================================================
-- View: catalogo_cond_pt
-- ==========================================================
DROP VIEW IF EXISTS catalogo_cond_pt;
CREATE VIEW IF NOT EXISTS catalogo_cond_pt AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Condicionantes' AND
           lower(t.geometria) LIKE lower('%ponto%') COLLATE NOCASE;


-- ==========================================================
-- View: catalogo_cond_ln
-- ==========================================================
DROP VIEW IF EXISTS catalogo_cond_ln;
CREATE VIEW IF NOT EXISTS catalogo_cond_ln AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Condicionantes' AND
           lower(t.geometria) LIKE lower('%linha%') COLLATE NOCASE;


-- ==========================================================
-- View: catalogo_cond_pl
-- ==========================================================
DROP VIEW IF EXISTS catalogo_cond_pl;
CREATE VIEW IF NOT EXISTS catalogo_cond_pl AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Condicionantes' AND
           lower(t.geometria) LIKE lower('%polígono%') COLLATE NOCASE;


-- ==========================================================
-- View: catalogo_ord
-- ==========================================================
DROP VIEW IF EXISTS catalogo_ord;
CREATE VIEW IF NOT EXISTS catalogo_ord AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           t.observacoes,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Ordenamento';


-- ==========================================================
-- View: catalogo_ord_pt
-- ==========================================================
DROP VIEW IF EXISTS catalogo_ord_pt;
CREATE VIEW IF NOT EXISTS catalogo_ord_pt AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Ordenamento' AND
           lower(t.geometria) LIKE lower('%ponto%') COLLATE NOCASE;


-- ==========================================================
-- View: catalogo_ord_ln
-- ==========================================================
DROP VIEW IF EXISTS catalogo_ord_ln;
CREATE VIEW IF NOT EXISTS catalogo_ord_ln AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Ordenamento' AND
           lower(t.geometria) LIKE lower('%linha%') COLLATE NOCASE;


-- ==========================================================
-- View: catalogo_ord_pl
-- ==========================================================
DROP VIEW IF EXISTS catalogo_ord_pl;
CREATE VIEW IF NOT EXISTS catalogo_ord_pl AS
    SELECT t.fid,
           t.objeto_codigo,
           t.planta,
           t.tema,
           t.subtema,
           t.objeto_designacao,
           t.geometria,
           CAST (t.objeto_codigo || ' - ' || t.objeto_designacao AS TEXT) AS cod_designacao
      FROM catalogo t
     WHERE t.planta = 'Ordenamento' AND
           lower(t.geometria) LIKE lower('%polígono%') COLLATE NOCASE;


-- ==========================================================
-- TRIGGERS
-- ==========================================================

-- ==========================================================
-- Trigger: objeto_ponto_uuid - Table: objeto_ponto
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_ponto_uuid";
CREATE TRIGGER IF NOT EXISTS "objeto_ponto_uuid"
AFTER INSERT ON "objeto_ponto"
WHEN NEW."geom" IS NOT NULL
BEGIN
    UPDATE "objeto_ponto"
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
                  END
     WHERE "fid" = NEW."fid";
END

-- ==========================================================
-- Trigger: objeto_ponto_uuid_protect - Table: objeto_ponto
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_ponto_uuid_protect";
CREATE TRIGGER IF NOT EXISTS "objeto_ponto_uuid_protect"
BEFORE UPDATE OF "geom" ON "objeto_ponto"
WHEN OLD."geom" IS NOT NULL
 AND NEW."geom" IS NOT OLD."geom"
BEGIN
    SELECT RAISE(FAIL, 'O campo geom e apenas de leitura e nao pode ser alterado.
Reponha o valor original ou cancele a edicao para repor o valor e edite novamente os restantes campos.');
END;


-- ==========================================================
-- Trigger: objeto_linha_calc_uuid_l - Table: objeto_linha
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_linha_calc_uuid_l";
CREATE TRIGGER IF NOT EXISTS "objeto_linha_calc_uuid_l"
AFTER INSERT ON "objeto_linha"
WHEN NEW."geom" IS NOT NULL
BEGIN
    UPDATE "objeto_linha"
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
-- Trigger: objeto_linha_recalc_l - Table: objeto_linha
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_linha_recalc_l";
CREATE TRIGGER IF NOT EXISTS "objeto_linha_recalc_l"
AFTER UPDATE OF "geom" ON "objeto_linha"
WHEN NEW."geom" IS NOT NULL
 AND (OLD."geom" IS NULL OR NOT ST_Equals(OLD."geom", NEW."geom"))
BEGIN
    UPDATE "objeto_linha"
       SET comp_m = (ROUND(ST_Length(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: objeto_linha_uuid_protect - Table: objeto_linha
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_linha_uuid_protect";
CREATE TRIGGER IF NOT EXISTS "objeto_linha_uuid_protect"
BEFORE UPDATE OF "geom" ON "objeto_linha"
WHEN OLD."geom" IS NOT NULL
 AND NEW."geom" IS NOT OLD."geom"
BEGIN
    SELECT RAISE(FAIL, 'O campo geom e apenas de leitura e nao pode ser alterado.
Reponha o valor original ou cancele a edicao para repor o valor e edite novamente os restantes campos.');
END;


-- ==========================================================
-- Trigger: objeto_poligono_calc_uuid_p - Table: objeto_poligono
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_poligono_calc_uuid_p";
CREATE TRIGGER IF NOT EXISTS "objeto_poligono_calc_uuid_p"
AFTER INSERT ON "objeto_poligono"
WHEN NEW."geom" IS NOT NULL
BEGIN
    UPDATE "objeto_poligono"
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
-- Trigger: objeto_poligono_recalc_p - Table: objeto_poligono
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_poligono_recalc_p";
CREATE TRIGGER IF NOT EXISTS "objeto_poligono_recalc_p"
AFTER UPDATE OF "geom" ON "objeto_poligono"
WHEN NEW."geom" IS NOT NULL
 AND (OLD."geom" IS NULL OR NOT ST_Equals(OLD."geom", NEW."geom"))
BEGIN
    UPDATE "objeto_poligono"
       SET area_m2 = (ROUND(ST_Area(NEW."geom"), 2))
     WHERE "fid" = NEW."fid";
END;

-- ==========================================================
-- Trigger: objeto_poligono_uuid_protect - Table: objeto_poligono
-- ==========================================================
DROP TRIGGER IF EXISTS "objeto_poligono_uuid_protect";
CREATE TRIGGER IF NOT EXISTS "objeto_poligono_uuid_protect"
BEFORE UPDATE OF "geom" ON "objeto_poligono"
WHEN OLD."geom" IS NOT NULL
 AND NEW."geom" IS NOT OLD."geom"
BEGIN
    SELECT RAISE(FAIL, 'O campo geom e apenas de leitura e nao pode ser alterado.
Reponha o valor original ou cancele a edicao para repor o valor e edite novamente os restantes campos.');
END;

-- ==========================================================
-- Trigger: autoincrement_id_ato_especifico - Table: ato_especifico
-- ==========================================================
DROP TRIGGER IF EXISTS "autoincrement_id_ato_especifico_seq";
CREATE TRIGGER IF NOT EXISTS "autoincrement_id_ato_especifico_seq"
AFTER INSERT ON "ato_especifico"
WHEN NEW."id_ato_especifico" IS NULL
BEGIN
    UPDATE "ato_especifico"
       SET "id_ato_especifico" = (
           SELECT COALESCE(MAX("id_ato_especifico"), 0) + 1
           FROM "ato_especifico"
       )
     WHERE "fid" = NEW."fid";
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
     ('atribuir_municipio', 'attributes', 'atribuir_municipio', 'Identifica o município de trabalho do utilizador. Esta tabela contém um único registo e funciona como elemento de configuração, centralizando a identificação do território a que os dados se referem através do código DTCC. O respetivo código atua como chave estrangeira nas tabelas gráficas, garantindo a integridade referencial. Qualquer alteração ao registo é automaticamente refletida nas tabelas dependentes, assegurando a associação de todos os dados ao mesmo município.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo', 'attributes', 'catalogo', 'Identifica os objetos que podem existir na base de dados, a natureza geométrica que cada objeto pode assumir e a sua organização em cada planta do plano.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, NULL),
     ('codigo_ine', 'attributes', 'codigo_ine', 'Lista os municípios e respetivos códigos da divisão administrativa do Instituto Nacional de Estatística (código DTCC).', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, NULL),
     ('objeto_linha', 'features', 'objeto_linha', 'Contém os objetos com geometria do tipo linear.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, 3763),
     ('objeto_planta', 'attributes', 'objeto_planta', 'Garante a integridade relacional das geometrias (tabelas gráficas) e alfanumérica (tabela catalogo) com as plantas do PDM (Ordenamento e Condicionantes), utilizando chaves compostas e restrições condicionais baseadas no tipo de planta.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, NULL),
     ('objeto_poligono', 'features', 'objeto_poligono', 'Contém os objetos com geometria do tipo poligonal.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, 3763),
     ('objeto_ponto', 'features', 'objeto_ponto', 'Contém os objetos com geometria do tipo pontual.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, 3763),
     ('catalogo_cond', 'attributes', 'catalogo_cond', 'catalogo_cond', '2026-08-07T06:58:47.678Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_cond_ln', 'attributes', 'catalogo_cond_ln', 'catalogo_cond_ln', '2026-08-07T06:58:47.680Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_cond_pl', 'attributes', 'catalogo_cond_pl', 'catalogo_cond_pl', '2026-08-07T06:58:47.682Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_cond_pt', 'attributes', 'catalogo_cond_pt', 'catalogo_cond_pt', '2026-08-07T06:58:47.684Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_ord', 'attributes', 'catalogo_ord', 'catalogo_ord', '2026-08-07T06:58:47.686Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_ord_ln', 'attributes', 'catalogo_ord_ln', 'catalogo_ord_ln', '2026-08-07T06:58:47.688Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_ord_pl', 'attributes', 'catalogo_ord_pl', 'catalogo_ord_pl', '2026-08-07T06:58:47.690Z', NULL, NULL, NULL, NULL, NULL),
     ('catalogo_ord_pt', 'attributes', 'catalogo_ord_pt', 'catalogo_ord_pt', '2026-08-07T06:58:47.692Z', NULL, NULL, NULL, NULL, NULL),
     ('ato_especifico', 'attributes', 'ato_especifico', 'Tabela de preenchimento exclusivo para os objetos da Planta de Condicionantes que tenham associada uma servidão ou restrição de utilidade pública constituída por ato específico.', '2026-08-17T13:27:34.380Z', NULL, NULL, NULL, NULL, NULL);


-- ==========================================================
-- Table: gpkg_data_columns
-- ==========================================================
INSERT INTO gpkg_data_columns 
     (table_name, column_name, name, title, description, mime_type, constraint_name)
 VALUES
     ('objeto_ponto', 'legenda', 'Legenda', NULL, 'Descrição: Designação do objeto criado por desagregação de um objeto do catálogo do PDM.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('objeto_ponto', 'etiqueta', 'Etiqueta', NULL, 'Descrição: Texto associado ao objeto para efeitos de rotulagem.; Alias: Etiqueta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_ponto', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'uuid', 'UUID', NULL, 'Descrição: Identificador único universal (UUID) do registo, gerado automaticamente.; Alias: UUID; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'legenda', 'Legenda', NULL, 'Descrição: Designação do objeto criado por desagregação de um objeto do catálogo do PDM.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'etiqueta', 'Etiqueta', NULL, 'Descrição: Texto associado ao objeto para efeitos de rotulagem.; Alias: Etiqueta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('objeto_poligono', 'uuid', 'UUID', NULL, 'Descrição: Identificador único universal (UUID) do registo, gerado automaticamente.; Alias: UUID; Tipo de data: TEXT', NULL, NULL),
     ('objeto_poligono', 'etiqueta', 'Etiqueta', NULL, 'Descrição: Texto associado ao objeto para efeitos de rotulagem.; Alias: Etiqueta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_poligono', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('ato_especifico', 'tipo_ato', 'Tipo Ato', NULL, 'Descrição: Campo do tipo texto que indica o tipo de ato que constitui a servidão ou restrição de utilidade pública. Este campo tem como domínio do atributo as seguintes opções: “Lei”; “Decreto-Lei”; “Dec-Reg” caso se trate de Decreto-Regulamentar; “Decreto”; “RCM” caso se trate de Resolução do Conselho de Ministros”; “Portaria”; “Aviso”; “Decisao” caso se trate de Decisão; “Declaracao” caso se trate de Declaração; “Deliberacao” caso se trate de Deliberação; “Despacho”; “Desp-Conj” caso se trate de Despacho-Conjunto; e “Regulamento”;; Alias: Tipo Ato; Tipo de data: TEXT', NULL, NULL),
     ('codigo_ine', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município. Este campo funciona como chave estrangeira para a tabela atribuir_municipio.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('codigo_ine', 'municipio', 'Município', NULL, 'Descrição: Designação do Município.; Alias: Município; Tipo de data: TEXT', NULL, NULL),
     ('codigo_ine', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('atribuir_municipio', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município. Este campo funciona como chave estrangeira para as tabelas gráficas e alfanumérica ato_especifico.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('atribuir_municipio', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('ato_especifico', 'dtcc', 'DTCC', NULL, 'Descrição: Código DTCC que identifica o município.; Alias: DTCC; Tipo de data: TEXT', NULL, NULL),
     ('ato_especifico', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_planta', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_planta', 'planta', 'Planta', NULL, 'Descrição: Identifica a planta onde o objeto pode ser representado (Ordenamento ou Condicionantes).; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_ponto', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_ponto', 'geom', 'Geometria', NULL, 'Descrição: Geometria do objeto do tipo MULTIPOINT.; Alias: Geometria; Tipo de data: MULTIPOINT', NULL, NULL),
     ('objeto_ponto', 'planta', 'Planta', NULL, 'Descrição: Identifica a planta do PDM a que o objeto pertence.; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_linha', 'geom', 'Geometria', NULL, 'Descrição: Geometria do objeto do tipo MULTILINESTRING.; Alias: Geometria; Tipo de data: MULTILINESTRING', NULL, NULL),
     ('objeto_linha', 'planta', 'Planta', NULL, 'Descrição: Identifica a planta do PDM a que o objeto pertence.; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_poligono', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_poligono', 'geom', 'Geometria', NULL, 'Descrição: Geometria do objeto do tipo MULTIPOLYGON.; Alias: Geometria; Tipo de data: MULTIPOLYGON', NULL, NULL),
     ('objeto_poligono', 'planta', 'Planta', NULL, 'Descrição: Identifica a planta do PDM a que o objeto pertence.; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('objeto_poligono', 'legenda', 'Legenda', NULL, 'Descrição: Designação do objeto criado por desagregação de um objeto do catálogo do PDM.; Alias: Legenda; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pt', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond_pt', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pt', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pt', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pt', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pt', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_ln', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond_ln', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_ln', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_ln', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_ln', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_ln', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pl', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond_pl', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pl', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pl', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pl', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pl', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pt', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord_pt', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pt', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pt', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pt', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pt', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_ln', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord_ln', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_ln', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_ln', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_ln', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_ln', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pl', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord_pl', 'planta', 'Planta', NULL, 'Descrição: Campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pl', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pl', 'subtema', 'Subtema', NULL, 'Descrição: Subdivisão do tema.; Alias: Subtema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pl', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pl', 'cod_designacao', 'Cod. Designação', NULL, 'Descrição: Código e Designação do Objeto; Alias: Cod. Designação; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos do PDM. É a chave estrangeira para a tabela catalogo, permitindo identificar o tipo de objeto.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_linha', 'id_ato_especifico', 'id_ato_especifico', NULL, 'Descrição: Permite associar o ato específico às geometrias que configuram condicionantes específicas do município.; Alias: id_ato_especifico; Tipo de data: INTEGER', NULL, NULL),
     ('ato_especifico', 'id_ato_especifico', 'id_ato_especifico', NULL, 'Descrição: identificador único do ato específico. Chave estrangeira nas tabelas gráficas.; Alias: id_ato_especifico; Tipo de data: INTEGER', NULL, NULL),
     ('ato_especifico', 'serie_dr', 'Série do D.R.', NULL, 'Descrição: Série do Diário da República onde foi publicado o ato específico. Domínio: “SERIE I” ou “SERIE II”.; Alias: Série do D.R.; Tipo de data: TEXT', NULL, NULL),
     ('ato_especifico', 'numero_dr', 'Número do D.R.', NULL, 'Descrição: Número do Diário da República onde foi publicado o ato específico.; Alias: Número do D.R.; Tipo de data: TEXT', NULL, NULL),
     ('ato_especifico', 'numero_ato', 'Número do Ato', NULL, 'Descrição: Número do ato específico.; Alias: Número do Ato; Tipo de data: TEXT', NULL, NULL),
     ('ato_especifico', 'data_publicacao', 'Data de Publicação', NULL, 'Descrição: Data de publicação do ato específico em Diário da República.; Alias: Data de Publicação; Tipo de data: DATE', NULL, NULL),
     ('objeto_poligono', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos do PDM. É a chave estrangeira para a tabela catalogo, permitindo identificar o tipo de objeto.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_poligono', 'id_ato_especifico', 'id_ato_especifico', NULL, 'Descrição: Permite associar o ato específico às geometrias que configuram condicionantes específicas do município.; Alias: id_ato_especifico; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_ponto', 'uuid', 'UUID', NULL, 'Descrição: Identificador único universal (UUID) do registo, gerado automaticamente.; Alias: UUID; Tipo de data: TEXT', NULL, NULL),
     ('objeto_ponto', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos do PDM. É a chave estrangeira para a tabela catalogo, permitindo identificar o tipo de objeto.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('objeto_ponto', 'id_ato_especifico', 'id_ato_especifico', NULL, 'Descrição: Permite associar o ato específico às geometrias que configuram condicionantes específicas do município.; Alias: id_ato_especifico; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond', 'observacoes', 'Observações', NULL, 'Descrição: Regista observações relevantes sobre o objeto.; Alias: Observações; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord', 'observacoes', 'Observações', NULL, 'Descrição: Regista observações relevantes sobre o objeto.; Alias: Observações; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_ln', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond_ln', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pl', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond_pl', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_cond_pt', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_cond_pt', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_ln', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord_ln', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pl', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord_pl', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('catalogo_ord_pt', 'objeto_codigo', 'Objeto Código', NULL, 'Descrição: Código do objeto; Alias: Objeto Código; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo_ord_pt', 'objeto_designacao', 'Objeto Designação', NULL, 'Descrição: Designação do objeto.; Alias: Objeto Designação; Tipo de data: TEXT', NULL, NULL),
     ('objeto_linha', 'comp_m', 'Comprimento (m)', NULL, 'Descrição: Comprimento da linha em metros (m), calculado automaticamente.; Alias: Comprimento (m), Tipo de data: REAL', NULL, NULL),
     ('objeto_poligono', 'area_m2', 'Área (m2)', NULL, 'Descrição: Área do polígono em metros quadrados (m²), calculado automaticamente.; Alias: Área (m2), Tipo de data: REAL', NULL, NULL),
     ('catalogo', 'objeto_codigo', 'Código do Objeto', NULL, 'Descrição: Código identificador atribuído ao objeto no catálogo de objetos do PDM. Campo que identifica univocamente cada linha da tabela. Este campo funciona como chave estrangeira para as tabelas gráficas.; Alias: Código do Objeto; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo', 'planta', 'Planta', NULL, 'Descrição: Identifica a planta onde o objeto pode ser representado (Ordenamento ou Condicionantes).; Alias: Planta; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'tema', 'Tema', NULL, 'Descrição: Divisão dos objetos do catálogo em função do conteúdo temático.; Alias: Tema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'subtema', 'SubTema', NULL, 'Descrição: Subdivisão do tema.; Alias: SubTema; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'fid', 'fid', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela. Chave primária.; Alias: fid; Tipo de data: INTEGER', NULL, NULL),
     ('catalogo', 'geometria', 'Geometria', NULL, 'Descrição: Tipo ou tipos de geometria que o objeto pode assumir (polígono, linha ou ponto).; Alias: Geometria; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'objeto_designacao', 'Designação do Objeto', NULL, 'Descrição: Denominação atribuída ao objeto.; Alias: Designação do Objeto; Tipo de data: TEXT', NULL, NULL),
     ('catalogo', 'observacoes', 'Observações', NULL, 'Descrição: Regista observações relevantes sobre o objeto.; Alias: Observações; Tipo de data: TEXT', NULL, NULL);


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
     ('objeto_ponto', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only'),
     ('objeto_linha', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only'),
     ('objeto_poligono', 'geom', 'gpkg_rtree_index', 'https://www.geopackage.org/spec140/#extension_rtree', 'write-only');


-- ==========================================================
-- Table: gpkg_geometry_columns
-- ==========================================================
INSERT INTO gpkg_geometry_columns
     (table_name, column_name, geometry_type_name, srs_id, z, m)
 VALUES
     ('objeto_ponto', 'geom', 'MULTIPOLYGON', 3763, 0, 0),
     ('objeto_linha', 'geom', 'MULTILINESTRING', 3763, 0, 0),
     ('objeto_poligono', 'geom', 'MULTIPOLYGON', 3763, 0, 0);


-- ==========================================================
-- Tabela: catalogo
-- ==========================================================
INSERT OR IGNORE INTO catalogo
     (fid, objeto_codigo, planta, tema, subtema, objeto_designacao, etiqueta, geometria, observacoes)
 VALUES 
     (1, 1, 'Ordenamento', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', NULL, 'polígono', NULL),
     (2, 2, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço Central', 'EC', 'polígono', NULL),
     (3, 3, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço Habitacional', 'EH', 'polígono', NULL),
     (4, 4, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço Urbano de Baixa Densidade', 'BD', 'polígono', NULL),
     (5, 5, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço de Atividades Económicas', 'AE', 'polígono', NULL),
     (6, 151, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço de uso especial – infraestrutura estruturante', 'UEI', 'polígono', NULL),
     (7, 152, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço de uso especial – equipamento', 'UEE', 'polígono', NULL),
     (8, 6, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço de uso especial – turístico', 'UET', 'polígono', NULL),
     (9, 7, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', 'Espaço Verde', 'EV', 'polígono', NULL),
     (10, 8, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço Agrícola', 'A', 'polígono', NULL),
     (11, 9, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço Florestal', 'F', 'polígono', NULL),
     (12, 10, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço de Exploração de Recursos Energéticos e Geológicos', 'EG', 'polígono', NULL),
     (13, 11, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço Natural e Paisagístico', 'NP', 'polígono', NULL),
     (14, 12, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço de Atividades Industriais', 'I', 'polígono', NULL),
     (15, 13, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Aglomerado Rural', 'AR', 'polígono', NULL),
     (16, 14, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Área de Edificação Dispersa', 'ED', 'polígono', NULL),
     (17, 15, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço Cultural', 'C', 'polígono', NULL),
     (18, 16, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço de Ocupação Turística', 'T', 'polígono', NULL),
     (19, 17, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', 'Espaço de Equipamentos e Infraestruturas', 'EI', 'polígono', NULL),
     (20, 18, 'Ordenamento', 'Áreas com Funções Específicas', 'Estrutura Ecológica Municipal', 'Estrutura Ecológica Municipal', NULL, 'polígono', NULL),
     (21, 19, 'Ordenamento', 'Áreas com Funções Específicas', 'Espaço Canal', 'Espaço Canal', NULL, 'polígono', NULL),
     (22, 133, 'Ordenamento', 'Áreas com Funções Específicas', 'Risco', 'Área de Risco', 'R', 'polígono', NULL),
     (23, 134, 'Ordenamento', 'Áreas com Funções Específicas', 'Risco', 'Área de Perigosidade', 'P', 'polígono', NULL),
     (24, 139, 'Ordenamento', 'Áreas com Funções Específicas', 'Ruído', 'Zona Sensível ao Ruído', NULL, 'polígono', NULL),
     (25, 140, 'Ordenamento', 'Áreas com Funções Específicas', 'Ruído', 'Zona Mista ao Ruído', NULL, 'polígono', NULL),
     (26, 145, 'Ordenamento', 'Áreas com Funções Específicas', 'Zona de proteção e de salvaguarda dos recursos e valores naturais', 'Zona de proteção e de salvaguarda dos recursos e valores naturais', 'ZPSRVN', 'polígono', NULL),
     (27, 149, 'Ordenamento', 'Áreas com Funções Específicas', 'Património geológico', 'Geossítio', NULL, 'polígono', NULL),
     (28, 150, 'Ordenamento', 'Áreas com Funções Específicas', 'Inventário de bens culturais', 'Imóvel inventariado', 'I', 'ponto', NULL),
     (29, 170, 'Ordenamento', 'Áreas com Funções Específicas', 'Património Arqueológico', 'Sítio Arqueológico', 'S', 'polígono, ponto', NULL),
     (30, 20, 'Ordenamento', 'Programação da Execução do Plano', 'Programação da Execução do Plano', 'Unidade Operativa de Planeamento e Gestão (UOPG)', 'UOPG', 'polígono', NULL),
     (31, 138, 'Ordenamento', 'Programação da Execução do Plano', 'Programação da Execução do Plano', 'Unidade de Execução (UE)', NULL, 'polígono', NULL),
     (32, 21, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Programas Territoriais', 'Área de Intervenção de Programa Especial', 'PE', 'polígono', NULL),
     (33, 130, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Programas Territoriais', 'Área de Intervenção de Programa Setorial', 'PS', 'polígono', NULL),
     (34, 131, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Programas Territoriais', 'Área de Intervenção de Programa Intermunicipal', 'PI', 'polígono', NULL),
     (35, 132, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Planos Territoriais', 'Área de Intervenção de Plano Intermunicipal (PUI, PPI)', 'PTIM', 'polígono', NULL),
     (36, 22, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Planos Territoriais', 'Área de Intervenção de Plano Municipal (PU, PP)', 'PTM', 'polígono', NULL),
     (37, 135, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Reabilitação ou Revitalização', 'Área Urbana de Génese Ilegal (AUGI)', 'AUGI', 'polígono', NULL),
     (38, 136, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Reabilitação ou Revitalização', 'Área de Reabilitação Urbana (ARU)', 'ARU', 'polígono', NULL),
     (39, 129, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Áreas de Jurisdição dos Portos', 'Área de Jurisdição do Porto', 'AJP', 'polígono', NULL),
     (40, 23, 'Ordenamento', 'Sistemas Estruturantes', 'Equipamentos de Utilização Coletiva', 'Equipamento de Utilização Coletiva', 'EUC', 'polígono, ponto', NULL),
     (41, 24, 'Ordenamento', 'Sistemas Estruturantes', 'Equipamentos de Utilização Coletiva', 'Equipamento de Utilização Coletiva Previsto', 'EUC', 'polígono, ponto', NULL),
     (42, 25, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Rodovia Principal', NULL, 'polígono, linha', NULL),
     (43, 26, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Rodovia Principal Prevista', NULL, 'polígono, linha', NULL),
     (44, 27, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Rodovia Distribuidora', NULL, 'polígono, linha', NULL),
     (45, 28, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Rodovia Distribuidora Prevista', NULL, 'polígono, linha', NULL),
     (46, 29, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Rodovia de Acesso Local', NULL, 'polígono, linha', NULL),
     (47, 30, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Rodovia de Acesso Local Prevista', NULL, 'polígono, linha', NULL),
     (48, 31, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Nó Rodoviário', NULL, 'ponto', NULL),
     (49, 32, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Nó Rodoviário Previsto', NULL, 'ponto', NULL),
     (50, 33, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Estação ou Interface de Transporte', NULL, 'ponto', NULL),
     (51, 34, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Estação ou Interface de Transporte Prevista', NULL, 'ponto', NULL),
     (52, 35, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Via-Férrea', NULL, 'polígono, linha', NULL),
     (53, 36, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Via-Férrea Prevista', NULL, 'polígono, linha', NULL),
     (54, 146, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Estacionamento', NULL, 'ponto', NULL),
     (55, 147, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Estacionamento Previsto', NULL, 'ponto', NULL),
     (56, 37, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Infraestrutura de Transporte Aéreo', NULL, 'ponto', NULL),
     (57, 38, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Infraestrutura de Transporte Aéreo Prevista', NULL, 'ponto', NULL),
     (58, 39, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Porto', NULL, 'ponto', NULL),
     (59, 40, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Porto Previsto', NULL, 'ponto', NULL),
     (60, 41, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Água', 'Captação, Tratamento ou Armazenamento de Água', NULL, 'ponto', NULL),
     (61, 42, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Água', 'Captação, Tratamento ou Armazenamento de Água Prevista', NULL, 'ponto', NULL),
     (62, 169, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Água', 'Nascente', NULL, 'ponto', NULL),
     (63, 45, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Drenagem de Águas Residuais e Pluviais', 'Bombagem ou Tratamento de Águas Residuais e Pluviais', NULL, 'ponto', NULL),
     (64, 46, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Drenagem de Águas Residuais e Pluviais', 'Bombagem ou Tratamento de Águas Residuais e Pluviais Prevista', NULL, 'ponto', NULL),
     (65, 47, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Recolha e Tratamento de Resíduos Sólidos', 'Estação de Tratamento de Resíduos Sólidos', NULL, 'ponto', NULL),
     (66, 48, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Recolha e Tratamento de Resíduos Sólidos', 'Estação de Tratamento de Resíduos Sólidos Prevista', NULL, 'ponto', NULL),
     (67, 49, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Energia Elétrica', 'Infraestrutura de Produção ou Transformação de Energia Elétrica', NULL, 'ponto', NULL),
     (68, 50, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Energia Elétrica', 'Infraestrutura de Produção ou Transformação de Energia Elétrica Prevista', NULL, 'ponto', NULL),
     (69, 1, 'Condicionantes', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', NULL, 'polígono', NULL),
     (70, 53, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Águas do Mar - Leito', NULL, 'polígono', NULL),
     (71, 54, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Águas Fluviais - Leito', NULL, 'polígono, linha', NULL),
     (72, 55, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Zona Contígua à Margem', NULL, 'polígono', NULL),
     (73, 56, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Zona Adjacente', NULL, 'polígono', NULL),
     (74, 153, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Águas do Mar - Margem', NULL, 'polígono', NULL),
     (75, 154, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Águas Fluviais - Margem', NULL, 'polígono', NULL),
     (76, 57, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Albufeira Classificada - Leito', 'AlbL', 'polígono', NULL),
     (77, 155, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Albufeira Classificada - Margem', 'AlbM', 'polígono', NULL),
     (78, 58, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Lago ou Lagoa Classificada - Leito', 'LagL', 'polígono', NULL),
     (79, 156, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Lago ou Lagoa Classificada - Margem', 'LagM', 'polígono', NULL),
     (80, 59, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona Terrestre de Proteção', NULL, 'polígono', NULL),
     (81, 60, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona Reservada da Zona Terrestre de Proteção', NULL, 'polígono', NULL),
     (82, 61, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona de Proteção da Barragem', NULL, 'polígono', NULL),
     (83, 62, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona de Respeito da Barragem', NULL, 'polígono', NULL),
     (84, 63, 'Condicionantes', 'Recursos Geológicos', 'Captações de Águas Subterrâneas para Abastecimento Público', 'Perímetro de Proteção de Captação de Água Subterrânea', NULL, 'polígono', NULL),
     (85, 64, 'Condicionantes', 'Recursos Geológicos', 'Águas de Nascente', 'Perímetro de Proteção de Águas da Nascente', NULL, 'polígono', NULL),
     (86, 65, 'Condicionantes', 'Recursos Geológicos', 'Águas Minerais Naturais', 'Perímetro de Proteção de Águas Minerais Naturais', NULL, 'polígono', NULL),
     (87, 66, 'Condicionantes', 'Recursos Geológicos', 'Pedreiras', 'Zona de Defesa / Zona Especial de Defesa', NULL, 'polígono', NULL),
     (88, 67, 'Condicionantes', 'Recursos Geológicos', 'Pedreiras', 'Área Cativa / Área de Reserva', NULL, 'polígono', NULL),
     (89, 142, 'Condicionantes', 'Recursos Geológicos', 'Recursos Geológicos', 'Área de Servidão de Recurso Geológico', NULL, 'polígono', NULL),
     (90, 68, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Reserva Agrícola Nacional', 'Reserva Agrícola Nacional', NULL, 'polígono', NULL),
     (91, 69, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Reserva Agrícola Nacional', 'Área Excluída da Reserva Agrícola Nacional', NULL, 'polígono', NULL),
     (92, 70, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Obras de Aproveitamento Hidroagrícola', 'Perímetro Hidroagrícola', NULL, 'polígono', NULL),
     (93, 71, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Oliveiras', 'Povoamento de Oliveiras', NULL, 'polígono', NULL),
     (94, 72, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Sobreiros ou Azinheiras', 'Povoamento de Sobreiros ou Azinheiras', NULL, 'polígono', NULL),
     (95, 73, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Sobreiros ou Azinheiras', 'Área onde tenham ocorrido incêndios, Depreciação do Arvoredo ou Abates Ilegais', NULL, 'polígono', NULL),
     (96, 74, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Azevinho', 'Povoamento de Azevinho', NULL, 'polígono', NULL),
     (97, 75, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Regime Florestal', 'Regime Florestal Total', NULL, 'polígono', NULL),
     (98, 76, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Regime Florestal', 'Regime Florestal Parcial', NULL, 'polígono', NULL),
     (99, 78, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Classe de Risco de Incêndio (alta e/ou muito alta)', NULL, 'polígono', NULL),
     (100, 79, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Zona critica', NULL, 'polígono', NULL),
     (101, 80, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Redes de Faixas de Gestão de Combustível (rede primária e/ou secundária)', NULL, 'polígono, linha', NULL),
     (102, 165, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Áreas Estratégicas de Mosaicos de Gestão de Combustíveis', NULL, 'polígono', NULL),
     (103, 166, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Áreas Prioritárias de Prevenção e Segurança', NULL, 'polígono', NULL),
     (104, 167, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Rede de Pontos de Água', NULL, 'ponto', NULL),
     (105, 168, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Proteção ao Risco de Incêndio', 'Rede Nacional de Postos de Vigia', NULL, 'ponto', NULL),
     (106, 81, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Árvores e Arvoredo de Interesse Público', 'Árvore ou Arvoredo de Interesse Público', NULL, 'polígono, ponto', NULL),
     (107, 148, 'Condicionantes', 'Recursos Ecológicos', 'Reserva Ecológica Nacional', 'Reserva Ecológica Nacional', NULL, 'polígono, linha', NULL),
     (108, 82, 'Condicionantes', 'Recursos Ecológicos', 'Reserva Ecológica Nacional', 'Área Excluída da Reserva Ecológica Nacional', NULL, 'polígono', NULL),
     (109, 83, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Parque Nacional', NULL, 'polígono', NULL),
     (110, 84, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Parque Natural', NULL, 'polígono', NULL),
     (111, 85, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Reserva Natural', NULL, 'polígono', NULL),
     (112, 86, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Monumento Natural', NULL, 'polígono, ponto', NULL),
     (113, 87, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Paisagem Protegida (de interesse regional ou local)', NULL, 'polígono, ponto', NULL),
     (114, 88, 'Condicionantes', 'Recursos Ecológicos', 'Rede Natura 2000', 'Sítio da Lista Nacional', NULL, 'polígono', NULL),
     (115, 89, 'Condicionantes', 'Recursos Ecológicos', 'Rede Natura 2000', 'Zona Especial de Conservação', NULL, 'polígono', NULL),
     (116, 90, 'Condicionantes', 'Recursos Ecológicos', 'Rede Natura 2000', 'Zona de Proteção Especial', NULL, 'polígono', NULL),
     (117, 141, 'Condicionantes', 'Património', 'Património Arqueológico', 'Parque Arqueológico', 'PA', 'polígono, ponto', NULL),
     (118, 91, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Monumento Nacional', 'MN', 'polígono, ponto', NULL),
     (119, 92, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Imóvel de Interesse Público', 'IP', 'polígono, ponto', NULL),
     (120, 93, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Imóvel de Interesse Municipal', 'IM', 'polígono, ponto', NULL),
     (121, 94, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Imóvel em Vias de Classificação', 'VC', 'polígono, ponto', NULL),
     (122, 95, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Zona Geral de Proteção', 'ZGP', 'polígono', NULL),
     (123, 96, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Zona Especial de Proteção Provisória', 'ZEP', 'polígono', NULL),
     (124, 97, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Zona Especial de Proteção', 'ZEP', 'polígono', NULL),
     (125, 159, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Sítio de Interesse Público', 'SIP', 'polígono', NULL),
     (126, 160, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Sítio de Interesse Municipal', 'SIM', 'polígono', NULL),
     (127, 161, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Monumento de Interesse Público', 'MIP', 'polígono, ponto', NULL),
     (128, 162, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Monumento de Interesse Municipal', 'MIM', 'polígono, ponto', NULL),
     (129, 163, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Conjunto de Interesse Público', 'CIP', 'polígono', NULL),
     (130, 164, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Conjunto de Interesse Municipal', 'CIM', 'polígono', NULL),
     (131, 171, 'Condicionantes', 'Património', 'Imóveis Classificados', 'Zona "non aedificandi"', 'ZNA', 'polígono', NULL),
     (132, 98, 'Condicionantes', 'Património', 'Edifícios Públicos e Outras Construções', 'Zona de Proteção de Edifício Público ou de Outra Construção', NULL, 'polígono', NULL),
     (133, 99, 'Condicionantes', 'Equipamentos', 'Estabelecimentos Prisionais e Tutelares de Menores', 'Zona de Proteção de Estabelecimento Prisional ou Tutelar de Menores', NULL, 'polígono', NULL),
     (134, 100, 'Condicionantes', 'Equipamentos', 'Instalações Aduaneiras', 'Área de Jurisdição de Alfândega', NULL, 'polígono', NULL),
     (135, 101, 'Condicionantes', 'Equipamentos', 'Defesa Nacional', 'Zona de Servidão Militar', NULL, 'polígono, ponto', NULL),
     (136, 41, 'Condicionantes', 'Infraestruturas', 'Abastecimento de Água', 'Captação, Tratamento ou Armazenamento de Água', NULL, 'ponto', NULL),
     (137, 43, 'Condicionantes', 'Infraestruturas', 'Abastecimento de Água', 'Conduta Adutora', NULL, 'polígono, linha', NULL),
     (138, 102, 'Condicionantes', 'Infraestruturas', 'Abastecimento de Água', 'Zona de Servidão de Abastecimento de Água', NULL, 'polígono', NULL),
     (139, 44, 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais e Pluviais', 'Coletor de Águas Residuais e Pluviais', NULL, 'polígono, linha', NULL),
     (140, 45, 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais e Pluviais', 'Bombagem ou Tratamento de Águas Residuais e Pluviais', NULL, 'ponto', NULL),
     (141, 103, 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais e Pluviais', 'Zona de Servidão de Drenagem de Águas Residuais e Pluviais', NULL, 'polígono', NULL),
     (142, 47, 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais e Pluviais', 'Estação de Tratamento de Resíduos Sólidos', NULL, 'ponto', NULL),
     (143, 49, 'Condicionantes', 'Infraestruturas', 'Rede Elétrica', 'Infraestrutura de Produção ou Transformação de Energia Elétrica', NULL, 'ponto', NULL),
     (144, 51, 'Condicionantes', 'Infraestruturas', 'Rede Elétrica', 'Infraestrutura de Transporte de Energia Elétrica', NULL, 'polígono, linha', NULL),
     (145, 104, 'Condicionantes', 'Infraestruturas', 'Rede Elétrica', 'Zona de Servidão de Rede Elétrica', NULL, 'polígono', NULL),
     (146, 52, 'Condicionantes', 'Infraestruturas', 'Gasodutos e Oleodutos', 'Gasoduto ou Oleoduto', NULL, 'polígono, linha', NULL),
     (147, 137, 'Condicionantes', 'Infraestruturas', 'Gasodutos e Oleodutos', 'Infraestrutura Associada a Gasoduto ou Oleoduto', NULL, 'ponto', NULL),
     (148, 105, 'Condicionantes', 'Infraestruturas', 'Gasodutos e Oleodutos', 'Zona de Servidão de Gasoduto ou Oleoduto', NULL, 'polígono', NULL),
     (149, 106, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Principal', NULL, 'polígono, linha', NULL),
     (150, 107, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Principal Autoestrada', NULL, 'polígono, linha', NULL),
     (151, 108, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Complementar', NULL, 'polígono, linha', NULL),
     (152, 109, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Complementar Autoestrada', NULL, 'polígono, linha', NULL),
     (153, 110, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Estrada Nacional', NULL, 'polígono, linha', NULL),
     (154, 111, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Estrada Regional', NULL, 'polígono, linha', NULL),
     (155, 143, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Estrada em Projeto', NULL, 'polígono, linha', NULL),
     (156, 112, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Zona de Servidão de Estrada do Plano Rodoviário Nacional', NULL, 'polígono', NULL),
     (157, 144, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Zona de Respeito de Estrada do Plano Rodoviário Nacional', NULL, 'polígono', NULL),
     (158, 113, 'Condicionantes', 'Infraestruturas', 'Estradas Nacionais Desclassificadas', 'Estradas Nacionais Desclassificadas', NULL, 'polígono, linha', NULL),
     (159, 114, 'Condicionantes', 'Infraestruturas', 'Estradas Nacionais Desclassificadas', 'Zona de Servidão de Estrada Nacional Desclassificada', NULL, 'polígono', NULL),
     (160, 115, 'Condicionantes', 'Infraestruturas', 'Estradas e Caminhos Municipais', 'Estrada Municipal', NULL, 'polígono, linha', NULL),
     (161, 116, 'Condicionantes', 'Infraestruturas', 'Estradas e Caminhos Municipais', 'Caminho Municipal', NULL, 'polígono, linha', NULL),
     (162, 117, 'Condicionantes', 'Infraestruturas', 'Estradas e Caminhos Municipais', 'Zona de Servidão de Estrada ou Caminho Municipal', NULL, 'polígono', NULL),
     (163, 35, 'Condicionantes', 'Infraestruturas', 'Rede Ferroviária', 'Via-Férrea', NULL, 'polígono, linha', NULL),
     (164, 118, 'Condicionantes', 'Infraestruturas', 'Rede Ferroviária', 'Zona de Servidão de Via-Férrea', NULL, 'polígono', NULL),
     (165, 119, 'Condicionantes', 'Infraestruturas', 'Aeroportos e Aeródromos', 'Zona de Servidão Aeronáutica', NULL, 'polígono', NULL),
     (166, 120, 'Condicionantes', 'Infraestruturas', 'Telecomunicações', 'Zona de Servidão Radioelétrica', NULL, 'polígono', NULL),
     (167, 121, 'Condicionantes', 'Infraestruturas', 'Faróis e Outros Sinais Marítimos', 'Farol ou Outro Sinal Marítimo', NULL, 'ponto', NULL),
     (168, 122, 'Condicionantes', 'Infraestruturas', 'Faróis e Outros Sinais Marítimos', 'Zona de Servidão de Sinalização Marítima', NULL, 'polígono', NULL),
     (169, 123, 'Condicionantes', 'Infraestruturas', 'Rede Geodésica', 'Zona de Proteção da Rede Geodésica', NULL, 'polígono', NULL),
     (170, 124, 'Condicionantes', 'Infraestruturas', 'Rede Geodésica', 'Marco Geodésico', NULL, 'ponto', NULL),
     (171, 125, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Estabelecimento com Produtos Explosivos', NULL, 'ponto', NULL),
     (172, 126, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Zona de Segurança de Estabelecimento com Produtos Explosivos', NULL, 'polígono', NULL),
     (173, 127, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Estabelecimento com Substâncias Perigosas', NULL, 'ponto', NULL),
     (174, 128, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Zona de Segurança de Estabelecimento com Substâncias Perigosas', NULL, 'polígono', NULL),
     (175, 157, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Estabelecimento com Substâncias Perigosas - Zona de perigosidade 1', NULL, 'polígono', NULL),
     (176, 158, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Estabelecimento com Substâncias Perigosas - Zona de perigosidade 2', NULL, 'polígono', NULL);


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
     ('catalogo', 176),
     ('objeto_planta', 2),
     ('objeto_ponto', 0),
     ('objeto_linha', 0),
     ('objeto_poligono', 0),
     ('ato_especifico', 0);


-- COMMIT TRANSACTION;
PRAGMA foreign_keys = on;