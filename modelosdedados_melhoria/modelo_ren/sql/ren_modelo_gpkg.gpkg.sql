-- ==========================================================
-- Preparação do GeoPackage (ativa SpatiaLite)
-- ==========================================================
-- Necessário correr antes:
-- .load mod_spatialite
-- SELECT InitSpatialMetadata();
-- Usar o ogrinfo gerir o gpkg

-- Criar schema lógico (SQLite não tem schemas nativos)
-- Apenas usado como prefixo no nome das tabelas

--
-- Text encoding used: UTF-8
--

PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- ==========================================================
-- TABELAS
-- ==========================================================

-- ==========================================================
-- Tabela: atribuir_concelho
-- ==========================================================
DROP TABLE IF EXISTS atribuir_concelho;

CREATE TABLE IF NOT EXISTS atribuir_concelho (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL CHECK(fid = 1),
    dtcc TEXT UNIQUE,
    FOREIGN KEY (dtcc) REFERENCES codigo_ine (dtcc)
);

-- ==========================================================
-- Tabela: ato_especifico
-- ==========================================================
DROP TABLE IF EXISTS ato_especifico;

CREATE TABLE IF NOT EXISTS ato_especifico (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    serie      TEXT,
    num_dr     TEXT,
    tipo_ato   TEXT,
    num_ato    TEXT NOT NULL,
    data_ato   DATE,
    dtcc       TEXT NOT NULL,
    n_deposito TEXT,
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Trigger: trigger_insert_feature_count_ato_especifico
DROP TRIGGER IF EXISTS trigger_insert_feature_count_ato_especifico;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_ato_especifico
                       AFTER INSERT
                          ON ato_especifico
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('ato_especifico');
END;

-- Trigger: trigger_delete_feature_count_ato_especifico
DROP TRIGGER IF EXISTS trigger_delete_feature_count_ato_especifico;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_ato_especifico
                       AFTER DELETE
                          ON ato_especifico
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('ato_especifico');
END;



-- ==========================================================
-- Tabela: catalogo
-- ==========================================================
DROP TABLE IF EXISTS catalogo;

CREATE TABLE IF NOT EXISTS catalogo (
    fid        INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    tema       TEXT,
    subtema    TEXT,
    nome_obje  TEXT,
    cod_obje   INTEGER UNIQUE,
    legenda    TEXT,
    acron_obje TEXT,
    geometria  TEXT
);

-- Trigger: trigger_insert_feature_count_catalogo
DROP TRIGGER IF EXISTS trigger_insert_feature_count_catalogo;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_catalogo
                       AFTER INSERT
                          ON catalogo
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('catalogo');
END;

-- Trigger: trigger_delete_feature_count_catalogo
DROP TRIGGER IF EXISTS trigger_delete_feature_count_catalogo;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_catalogo
                       AFTER DELETE
                          ON catalogo
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('catalogo');
END;


-- ==========================================================
-- Tabela: codigo_ine
-- ==========================================================
DROP TABLE IF EXISTS codigo_ine;

CREATE TABLE IF NOT EXISTS codigo_ine (
    fid        INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    municipio TEXT,
    dtcc      TEXT UNIQUE
);

-- Trigger: trigger_delete_feature_count_codigo_ine
DROP TRIGGER IF EXISTS trigger_delete_feature_count_codigo_ine;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_codigo_ine
                       AFTER DELETE
                          ON codigo_ine
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('codigo_ine');
END;

-- Trigger: trigger_insert_feature_count_codigo_ine
DROP TRIGGER IF EXISTS trigger_insert_feature_count_codigo_ine;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_codigo_ine
                       AFTER INSERT
                          ON codigo_ine
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('codigo_ine');
END;


-- ==========================================================
-- Tabela: det_excl_p
-- ==========================================================
DROP TABLE IF EXISTS det_excl_p;

CREATE TABLE IF NOT EXISTS det_excl_p (
    fid      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom     MULTIPOLYGON,
    dtcc     TEXT NOT NULL,
    exclusao TEXT UNIQUE,
    cod_obje INTEGER NOT NULL,
    area_m2  REAL,
    ato_id   INTEGER,
    FOREIGN KEY (cod_obje) REFERENCES catalogo (cod_obje),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid)
);

-- Trigger para calcular área (ha) depois do insert e  gerar UUID automaticamente
-- Trigger: det_excl_p_calc_uuid
DROP TRIGGER IF EXISTS det_excl_p_calc_uuid;

CREATE TRIGGER IF NOT EXISTS det_excl_p_calc_uuid
AFTER INSERT ON det_excl_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE det_excl_p
    SET 
    -- objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular área quando a geometria mudar
-- Trigger: det_excl_p_recalc
DROP TRIGGER IF EXISTS det_excl_p_recalc;

CREATE TRIGGER IF NOT EXISTS det_excl_p_recalc
AFTER UPDATE OF geom ON det_excl_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE det_excl_p
    SET area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger: trigger_insert_feature_count_det_excl_p
DROP TRIGGER IF EXISTS trigger_insert_feature_count_det_excl_p;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_det_excl_p
                       AFTER INSERT
                          ON det_excl_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('det_excl_p');
END;


-- Trigger: trigger_delete_feature_count_det_excl_p
DROP TRIGGER IF EXISTS trigger_delete_feature_count_det_excl_p;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_det_excl_p
                       AFTER DELETE
                          ON det_excl_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('det_excl_p');
END;


-- ==========================================================
-- Tabela: det_excl_tip
-- ==========================================================
-- DROP TABLE IF EXISTS det_excl_tip;
-- 
-- CREATE TABLE IF NOT EXISTS det_excl_tip (
--     fid          INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--     geom         MULTIPOLYGON,
--     fid_d_tip_p  MEDIUMINT,
--     fid_d_excl_p MEDIUMINT,
--     FOREIGN KEY (fid_d_tip_p) REFERENCES det_tip_p (fid) ON DELETE CASCADE ON UPDATE CASCADE,
--     FOREIGN KEY (fid_d_excl_p) REFERENCES det_excl_p (fid) ON DELETE CASCADE ON UPDATE CASCADE
-- );
-- 
-- -- Trigger: trigger_insert_feature_count_det_excl_tip
-- DROP TRIGGER IF EXISTS trigger_insert_feature_count_det_excl_tip;
-- CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_det_excl_tip
--                        AFTER INSERT
--                           ON det_excl_tip
-- BEGIN
--     UPDATE gpkg_ogr_contents
--        SET feature_count = feature_count + 1
--      WHERE lower(table_name) = lower('det_excl_tip');
-- END;
-- 
-- -- Trigger: trigger_delete_feature_count_det_excl_tip
-- DROP TRIGGER IF EXISTS trigger_delete_feature_count_det_excl_tip;
-- CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_det_excl_tip
--                        AFTER DELETE
--                           ON det_excl_tip
-- BEGIN
--     UPDATE gpkg_ogr_contents
--        SET feature_count = feature_count - 1
--      WHERE lower(table_name) = lower('det_excl_tip');
-- END;


-- ==========================================================
-- Tabela: det_tip_l
-- ==========================================================
DROP TABLE IF EXISTS det_tip_l;

CREATE TABLE IF NOT EXISTS det_tip_l (
    fid      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom     MULTILINESTRING,
    dtcc     TEXT NOT NULL,
    cod_obje INTEGER NOT NULL,
    designacao TEXT,
    comp_m   REAL,
    ato_id   INTEGER,
    FOREIGN KEY (cod_obje) REFERENCES catalogo (cod_obje),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid)
);

-- Trigger para calcular comprimento (km) depois do insert e gerar UUID automaticamente
-- Trigger: det_tip_l_calc_uuid
DROP TRIGGER IF EXISTS det_tip_l_calc_uuid;

CREATE TRIGGER IF NOT EXISTS det_tip_l_calc_uuid
AFTER INSERT ON det_tip_l
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE det_tip_l
    SET 
    -- objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    comp_m = (ROUND(ST_Length(geom), 2)) -- AS comprimento_m
    -- comp_m = (ROUND(ST_Length(geom) / 1000.0, 2)) -- AS comprimento_km
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular comprimento quando a geometria mudar
-- Trigger: det_tip_l_recalc
DROP TRIGGER IF EXISTS det_tip_l_recalc;

CREATE TRIGGER IF NOT EXISTS det_tip_l_recalc
AFTER UPDATE OF geom ON det_tip_l
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE det_tip_l
    SET comp_m = (ROUND(ST_Length(geom), 2)) -- AS comprimento_m
    -- comp_m = (ROUND(ST_Length(geom) / 1000.0, 2)) -- AS comprimento_km
    WHERE fid = NEW.fid;
END;

-- Trigger: trigger_insert_feature_count_det_tip_l
DROP TRIGGER IF EXISTS trigger_insert_feature_count_det_tip_l;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_det_tip_l
                       AFTER INSERT
                          ON det_tip_l
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('det_tip_l');
END;

-- Trigger: trigger_delete_feature_count_det_tip_l
DROP TRIGGER IF EXISTS trigger_delete_feature_count_det_tip_l;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_det_tip_l
                       AFTER DELETE
                          ON det_tip_l
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('det_tip_l');
END;

-- ==========================================================
-- Tabela: det_tip_p
-- ==========================================================
DROP TABLE IF EXISTS det_tip_p;

CREATE TABLE IF NOT EXISTS det_tip_p (
    fid      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom     MULTIPOLYGON,
    dtcc     TEXT NOT NULL,
    cod_obje INTEGER NOT NULL,
    area_m2  REAL,
    ato_id   INTEGER,
    FOREIGN KEY (cod_obje) REFERENCES catalogo (cod_obje),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid)
);

-- Trigger para calcular área (ha) depois do insert e  gerar UUID automaticamente
-- Trigger: det_tip_p_calc_uuid
DROP TRIGGER IF EXISTS det_tip_p_calc_uuid;

CREATE TRIGGER IF NOT EXISTS det_tip_p_calc_uuid
AFTER INSERT ON det_tip_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE det_tip_p
    SET 
    -- objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular área quando a geometria mudar
-- Trigger: det_tip_p_recalc
DROP TRIGGER IF EXISTS det_tip_p_recalc;

CREATE TRIGGER IF NOT EXISTS det_tip_p_recalc
AFTER UPDATE OF geom ON det_tip_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE det_tip_p
    SET area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger: trigger_insert_feature_count_det_tip_p
DROP TRIGGER IF EXISTS trigger_insert_feature_count_det_tip_p;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_det_tip_p
                       AFTER INSERT
                          ON det_tip_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('det_tip_p');
END;

-- Trigger: trigger_delete_feature_count_det_tip_p
DROP TRIGGER IF EXISTS trigger_delete_feature_count_det_tip_p;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_det_tip_p
                       AFTER DELETE
                          ON det_tip_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('det_tip_p');
END;

-- ==========================================================
-- Tabela: excl_p
-- ==========================================================
DROP TABLE IF EXISTS excl_p;

CREATE TABLE IF NOT EXISTS excl_p (
    fid        INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom       MULTIPOLYGON,
    dtcc       TEXT NOT NULL,
    exclusao   TEXT UNIQUE,
    cod_obje   INTEGER NOT NULL,
    area_m2    REAL,
    fundamento TEXT,
    fim_dest   TEXT,
    ato_id     INTEGER,
    FOREIGN KEY (cod_obje) REFERENCES catalogo (cod_obje),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid)
);

-- Trigger para calcular área (ha) depois do insert e  gerar UUID automaticamente
-- Trigger: excl_p_calc_uuid
DROP TRIGGER IF EXISTS excl_p_calc_uuid;

CREATE TRIGGER IF NOT EXISTS excl_p_calc_uuid
AFTER INSERT ON excl_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE excl_p
    SET 
    -- objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular área quando a geometria mudar
-- Trigger: excl_p_recalc
DROP TRIGGER IF EXISTS excl_p_recalc;

CREATE TRIGGER IF NOT EXISTS excl_p_recalc
AFTER UPDATE OF geom ON excl_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE excl_p
    SET area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger: trigger_insert_feature_count_excl_p
DROP TRIGGER IF EXISTS trigger_insert_feature_count_excl_p;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_excl_p
                       AFTER INSERT
                          ON excl_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('excl_p');
END;


-- Trigger: trigger_delete_feature_count_excl_p
DROP TRIGGER IF EXISTS trigger_delete_feature_count_excl_p;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_excl_p
                       AFTER DELETE
                          ON excl_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('excl_p');
END;

-- ==========================================================
-- Tabela: excl_tip
-- ==========================================================
-- DROP TABLE IF EXISTS excl_tip;
-- 
-- CREATE TABLE IF NOT EXISTS excl_tip (
--     fid        INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
--     geom       MULTIPOLYGON,
--     fid_tip_p  MEDIUMINT,
--     fid_excl_p MEDIUMINT,
--     FOREIGN KEY (fid_tip_p) REFERENCES tip_p (fid) ON DELETE CASCADE ON UPDATE CASCADE,
--     FOREIGN KEY (fid_excl_p) REFERENCES excl_p (fid) ON DELETE CASCADE ON UPDATE CASCADE
-- );
-- 
-- -- Trigger: trigger_insert_feature_count_excl_tip
-- DROP TRIGGER IF EXISTS trigger_insert_feature_count_excl_tip;
-- CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_excl_tip
--                        AFTER INSERT
--                           ON excl_tip
-- BEGIN
--     UPDATE gpkg_ogr_contents
--        SET feature_count = feature_count + 1
--      WHERE lower(table_name) = lower('excl_tip');
-- END;
-- 
-- -- Trigger: trigger_delete_feature_count_excl_tip
-- DROP TRIGGER IF EXISTS trigger_delete_feature_count_excl_tip;
-- CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_excl_tip
--                        AFTER DELETE
--                           ON excl_tip
-- BEGIN
--     UPDATE gpkg_ogr_contents
--        SET feature_count = feature_count - 1
--      WHERE lower(table_name) = lower('excl_tip');
-- END;

-- ==========================================================
-- Tabela: tip_l
-- ==========================================================
DROP TABLE IF EXISTS tip_l;

CREATE TABLE IF NOT EXISTS tip_l (
    fid      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom     MULTILINESTRING,
    dtcc     TEXT NOT NULL,
    cod_obje INTEGER NOT NULL,
    designacao TEXT,
    comp_m   REAL,
    ato_id   INTEGER,
    FOREIGN KEY (cod_obje) REFERENCES catalogo (cod_obje),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid)
);

-- Trigger para calcular comprimento (km) depois do insert e gerar UUID automaticamente
-- Trigger: tip_l_calc_uuid
DROP TRIGGER IF EXISTS tip_l_calc_uuid;

CREATE TRIGGER IF NOT EXISTS tip_l_calc_uuid
AFTER INSERT ON tip_l
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE tip_l
    SET 
    -- objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    comp_m = (ROUND(ST_Length(geom), 2)) -- AS comprimento_m
    -- comp_m = (ROUND(ST_Length(geom) / 1000.0, 2)) -- AS comprimento_km
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular comprimento quando a geometria mudar
-- Trigger: tip_l_recalc
DROP TRIGGER IF EXISTS tip_l_recalc;

CREATE TRIGGER IF NOT EXISTS tip_l_recalc
AFTER UPDATE OF geom ON tip_l
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE tip_l
    SET area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger: trigger_insert_feature_count_tip_l
DROP TRIGGER IF EXISTS trigger_insert_feature_count_tip_l;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_tip_l
                       AFTER INSERT
                          ON tip_l
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('tip_l');
END;

-- Trigger: trigger_delete_feature_count_tip_l
DROP TRIGGER IF EXISTS trigger_delete_feature_count_tip_l;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_tip_l
                       AFTER DELETE
                          ON tip_l
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('tip_l');
END;

-- ==========================================================
-- Tabela: tip_p
-- ==========================================================
DROP TABLE IF EXISTS tip_p;

CREATE TABLE IF NOT EXISTS tip_p (
    fid      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom     MULTIPOLYGON,
    dtcc     TEXT NOT NULL,
    cod_obje INTEGER NOT NULL,
    area_m2  REAL,
    ato_id   INTEGER,
    FOREIGN KEY (cod_obje) REFERENCES catalogo (cod_obje),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid)
);

-- Trigger para calcular área (ha) depois do insert e  gerar UUID automaticamente
-- Trigger: tip_p_calc_uuid
DROP TRIGGER IF EXISTS tip_p_calc_uuid;

CREATE TRIGGER IF NOT EXISTS tip_p_calc_uuid
AFTER INSERT ON tip_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE tip_p
    SET 
    -- objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular área quando a geometria mudar
-- Trigger: tip_p_recalc
DROP TRIGGER IF EXISTS tip_p_recalc;

CREATE TRIGGER IF NOT EXISTS tip_p_recalc
AFTER UPDATE OF geom ON tip_p
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE tip_p
    SET area_m2 = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    -- area_m2 = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    WHERE fid = NEW.fid;
END;


-- Trigger: trigger_insert_feature_count_tip_p
DROP TRIGGER IF EXISTS trigger_insert_feature_count_tip_p;
CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_tip_p
                       AFTER INSERT
                          ON tip_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('tip_p');
END;

-- Trigger: trigger_delete_feature_count_tip_p
DROP TRIGGER IF EXISTS trigger_delete_feature_count_tip_p;
CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_tip_p
                       AFTER DELETE
                          ON tip_p
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('tip_p');
END;

-- ==========================================================
-- Tabela: layer_styles
-- ==========================================================

-- Trigger: trigger_insert_feature_count_layer_styles
-- DROP TRIGGER IF EXISTS trigger_insert_feature_count_layer_styles;
-- CREATE TRIGGER IF NOT EXISTS trigger_insert_feature_count_layer_styles
                       -- AFTER INSERT
                          -- ON layer_styles
-- BEGIN
    -- UPDATE gpkg_ogr_contents
       -- SET feature_count = feature_count + 1
     -- WHERE lower(table_name) = lower('layer_styles');
-- END;


-- Trigger: trigger_delete_feature_count_layer_styles
-- DROP TRIGGER IF EXISTS trigger_delete_feature_count_layer_styles;
-- CREATE TRIGGER IF NOT EXISTS trigger_delete_feature_count_layer_styles
                       -- AFTER DELETE
                          -- ON layer_styles
-- BEGIN
    -- UPDATE gpkg_ogr_contents
       -- SET feature_count = feature_count - 1
     -- WHERE lower(table_name) = lower('layer_styles');
-- END;


-- ==========================================================
-- VISTAS
-- ==========================================================
-- View: excl_tip
DROP VIEW IF EXISTS excl_tip;

CREATE VIEW IF NOT EXISTS excl_tip AS
    SELECT ROW_NUMBER() OVER () AS fid,
           t.fid AS fid_tip_p,
           e.fid AS fid_excl_p,
           ST_Intersection(t.geom, e.geom) AS geom,
           t.dtcc,
           t.cod_obje,
           e.exclusao,
           e.fundamento,
           e.fim_dest,
           ROUND(ST_Area(ST_Intersection(t.geom, e.geom)), 2) AS area_excl_tip,
           t.ato_id AS ato_tip,
           e.ato_id AS ato_excl
      FROM tip_p t
           JOIN
           excl_p e ON t.dtcc = e.dtcc
     WHERE ST_Intersects(t.geom, e.geom) = 1;


-- View: excl_tip
DROP VIEW IF EXISTS det_excl_tip;

CREATE VIEW IF NOT EXISTS det_excl_tip AS
    SELECT ROW_NUMBER() OVER() AS fid,
           t.fid AS fid_d_tip_p,
           e.fid AS fid_d_excl_p,
           ST_Intersection(t.geom, e.geom) AS geom,
           t.dtcc,
           t.cod_obje AS cod_tip,
           e.cod_obje AS cod_excl,
           e.exclusao,
           t.area_m2 AS area_tip,
           e.area_m2 AS area_excl,
           t.ato_id AS ato_tip,
           e.ato_id AS ato_excl
      FROM det_tip_p t
           JOIN
           det_excl_p e ON t.dtcc = e.dtcc
     WHERE ST_Intersects(t.geom, e.geom) = 1;


-- View: catalogo_l
DROP VIEW IF EXISTS catalogo_l;

CREATE VIEW IF NOT EXISTS catalogo_l AS
    SELECT t.fid,
           t.tema,
           t.subtema,
           t.nome_obje,
           t.cod_obje,
           t.legenda,
           t.acron_obje,
           t.geometria,
           t.cod_obje || ' - ' || t.nome_obje AS cod_nome_obje
      FROM catalogo t
     WHERE t.geometria LIKE '%linha%' COLLATE NOCASE;
    
-- View: catalogo_p
DROP VIEW IF EXISTS catalogo_p;

CREATE VIEW IF NOT EXISTS catalogo_p AS
    SELECT t.fid,
           t.tema,
           t.subtema,
           t.nome_obje,
           t.cod_obje,
           t.legenda,
           t.acron_obje,
           t.geometria,
           t.cod_obje || ' - ' || t.nome_obje AS cod_nome_obje
      FROM catalogo t
     -- WHERE t.geometria LIKE '%polígono%' COLLATE NOCASE;
     WHERE t.geometria LIKE '%polígono%' COLLATE NOCASE AND
           t.cod_obje NOT IN (37, 38);

-- View: catalogo_excl
DROP VIEW IF EXISTS catalogo_excl;

CREATE VIEW IF NOT EXISTS catalogo_excl AS
    SELECT t.fid,
           t.tema,
           t.subtema,
           t.nome_obje,
           t.cod_obje,
           t.legenda,
           t.acron_obje,
           t.geometria,
           t.cod_obje || ' - ' || t.nome_obje AS cod_nome_obje
      FROM catalogo t
     WHERE t.cod_obje IN (37, 38);
     -- WHERE t.geometria LIKE '%Exclusão%' COLLATE NOCASE;

-- View: quadro_anexo
DROP VIEW IF EXISTS quadro_anexo;

CREATE VIEW IF NOT EXISTS quadro_anexo AS
    SELECT t.fid,
           t.fid_excl_p,
           -- ST_Intersection(t.geom, e.geom) AS geom,
           t.dtcc,
           t.exclusao,
           t.area_excl AS area_m2,
           l.nome_obje,
           t.fim_dest,
           t.fundamento
      FROM excl_tip t
           JOIN excl_p e ON t.dtcc = e.dtcc
           LEFT JOIN catalogo l ON t.cod_obje = l.cod_obje;

-- ==========================================================
-- DADOS - INSERT
-- ==========================================================

-- ==========================================================
-- Tabela: catalogo
-- ==========================================================

INSERT INTO catalogo (fid, tema, subtema, nome_obje, cod_obje, legenda, acron_obje, geometria) VALUES 
(1, 'Áreas de proteção do litoral', 'Faixa marítima de proteção costeira', 'Faixa marítima de proteção costeira', 1, 'Faixa marítima de proteção costeira', 'FMPC', 'polígono'),
(2, 'Áreas de proteção do litoral', 'Praias', 'Praias', 2, 'Praias', 'PRA', 'polígono'),
(3, 'Áreas de proteção do litoral', 'Barreiras detríticas', 'Restingas', 3, 'Barreiras detríticas', 'REST', 'polígono'),
(4, 'Áreas de proteção do litoral', 'Ilhéus e rochedos emersos no mar', 'Ilhéus', 8, 'Ilhéus e rochedos emersos no mar', 'ILHEUS', 'polígono'),
(5, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Áreas estratégicas de infiltração, proteção e recarga de aquíferos', 'Áreas estratégicas de infiltração, proteção e recarga de aquíferos', 30, 'Áreas estratégicas de infiltração, proteção e recarga de aquíferos', 'AEIPRA', 'polígono'),
(6, 'Áreas de proteção do litoral', 'Barreiras detríticas', 'Barreiras soldadas', 4, 'Barreiras detríticas', 'BARR_SOLD', 'polígono'),
(7, 'Áreas de proteção do litoral', 'Barreiras detríticas', 'Ilhas-Barreira', 5, 'Barreiras detríticas', 'ILH-BARR', 'polígono'),
(8, 'Áreas de proteção do litoral', 'Tômbolos', 'Tômbolos', 6, 'Tômbolos', 'TOMB', 'polígono'),
(9, 'Áreas de proteção do litoral', 'Sapais', 'Sapais', 7, 'Sapais', 'SAP', 'polígono'),
(10, 'Áreas de proteção do litoral', 'Ilhéus e rochedos emersos no mar', 'Rochedos emersos no mar', 9, 'Ilhéus e rochedos emersos no mar', 'ROCHEDOS', 'polígono'),
(11, 'Áreas de proteção do litoral', 'Dunas costeiras e dunas fósseis', 'Dunas costeiras litorais', 10, 'Dunas costeiras litorais', 'DUN_LIT', 'polígono'),
(12, 'Áreas de proteção do litoral', 'Dunas costeiras e dunas fósseis', 'Dunas costeiras interiores', 11, 'Dunas costeiras interiores', 'DUN_INT', 'polígono'),
(13, 'Áreas de proteção do litoral', 'Dunas costeiras e dunas fósseis', 'Dunas fósseis', 12, 'Dunas fósseis', 'DUN_FOSS', 'polígono'),
(14, 'Áreas de proteção do litoral', 'Arribas e respetivas faixas de proteção', 'Arribas', 13, 'Arribas', 'ARRIB', 'polígono'),
(15, 'Áreas de proteção do litoral', 'Arribas e respetivas faixas de proteção', 'Faixa de proteção de arribas a partir do rebordo superior', 14, 'Faixas de proteção das arribas', 'FPA_SUP', 'polígono'),
(16, 'Áreas de proteção do litoral', 'Arribas e respetivas faixas de proteção', 'Faixa de proteção de arribas a partir da base da arriba', 15, 'Faixas de proteção das arribas', 'FPA_BASE', 'polígono'),
(17, 'Áreas de proteção do litoral', 'Faixa terrestre de proteção costeira', 'Faixa terrestre de proteção costeira', 16, 'Faixa terrestre de proteção costeira', 'FTPC', 'polígono'),
(18, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Águas de transição e respetivos leitos, margens e faixas de proteção', 'Águas de transição - Leito', 18, 'Águas de transição - Leito', 'AT_LEITO', 'polígono'),
(19, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Águas de transição e respetivos leitos, margens e faixas de proteção', 'Águas de transição - Margem', 19, 'Águas de transição - Margem', 'AT_MARGEM', 'polígono'),
(20, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Águas de transição e respetivos leitos, margens e faixas de proteção', 'Águas de transição - Faixa de proteção', 20, 'Águas de transição - Faixa de proteção', 'AT_FP', 'polígono'),
(21, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Cursos de água e respetivos leitos e margens', 'Cursos de água - Leito', 21, 'Cursos de água - Leito', 'CA_LEITO', 'linha, polígono'),
(22, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Cursos de água e respetivos leitos e margens', 'Cursos de água - Leito canalizado', 22, 'Cursos de água - Leito canalizado', 'CA_LCANAL', 'linha'),
(23, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Cursos de água e respetivos leitos e margens', 'Cursos de água - Margem', 23, 'Cursos de água - Margem', 'CA_MARGEM', 'polígono'),
(24, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Lagoas e lagos e respetivos leitos, margens e faixas de proteção', 'Lagoas e lagos - Leito', 24, 'Lagoas e lagos - Leito', 'LL_LEITO', 'polígono'),
(25, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Lagoas e lagos e respetivos leitos, margens e faixas de proteção', 'Lagoas e lagos - Margem', 25, 'Lagoas e lagos - Margem', 'LL_MARGEM', 'polígono'),
(26, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Lagoas e lagos e respetivos leitos, margens e faixas de proteção', 'Lagoas e lagos - Faixa de proteção', 26, 'Lagoas e lagos - Faixa de proteção', 'LL_FP', 'polígono'),
(27, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção', 'Albufeiras - Leito', 27, 'Albufeiras - Leito', 'ALB_LEITO', 'polígono'),
(28, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção', 'Albufeiras - Faixa de proteção', 29, 'Albufeiras - Faixa de proteção', 'ALB_FP', 'polígono'),
(29, 'Áreas de exclusão', 'Exclusão para a satisfação de carências - E', 'Exclusão para a satisfação de carências - E', 38, 'Exclusão para a satisfação de carências - E', 'EXCL_E', 'polígono'),
(30, 'Áreas de prevenção de riscos naturais', 'Zonas adjacentes', 'Zonas adjacentes', 31, 'Zonas adjacentes', 'ZA', 'polígono'),
(31, 'Áreas de prevenção de riscos naturais', 'Zonas ameaçadas pelo mar', 'Zonas ameaçadas pelo mar', 32, 'Zonas ameaçadas pelo mar', 'ZAM', 'polígono'),
(32, 'Áreas de prevenção de riscos naturais', 'Zonas ameaçadas pelas cheias', 'Zonas ameaçadas pelas cheias', 33, 'Zonas ameaçadas pelas cheias', 'ZAC', 'polígono'),
(33, 'Áreas de prevenção de riscos naturais', 'Áreas de elevado risco de erosão hídrica do solo', 'Áreas de elevado risco de erosão hídrica do solo', 34, 'Áreas de elevado risco de erosão hídrica do solo', 'AEREHS', 'polígono'),
(34, 'Áreas de prevenção de riscos naturais', 'Áreas de instabilidade de vertentes', 'Áreas de instabilidade de vertentes', 35, 'Áreas de instabilidade de vertentes', 'AIV', 'polígono'),
(35, 'Áreas de prevenção de riscos naturais', 'Áreas de instabilidade de vertentes', 'Escarpas', 36, 'Escarpas', 'ESCARP', 'polígono'),
(36, 'Áreas de exclusão', 'Exclusão por compromisso - C', 'Exclusão por compromisso - C', 37, 'Exclusão por compromisso - C', 'EXCL_C', 'polígono'),
(37, 'Áreas de proteção do litoral', 'Águas do mar', 'Águas do mar - Margem', 17, 'Águas do mar - Margem', 'AG_MAR', 'polígono'),
(38, 'Áreas relevantes para a sustentabilidade do ciclo hidrológico terrestre', 'Albufeiras que contribuam para a conectividade e coerência ecológica da REN, bem como os respetivos leitos, margens e faixas de proteção', 'Albufeiras - Margem', 28, 'Albufeiras - Margem', 'ALB_MARGEM', 'polígono');

-- ==========================================================
-- Tabela: codigo_ine
-- ==========================================================

INSERT INTO codigo_ine (fid, municipio, dtcc) VALUES 
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


-- Table: gpkg_contents
DROP TABLE IF EXISTS gpkg_contents;

CREATE TABLE IF NOT EXISTS gpkg_contents (
    table_name  TEXT     NOT NULL
                         PRIMARY KEY,
    data_type   TEXT     NOT NULL,
    identifier  TEXT     UNIQUE,
    description TEXT     DEFAULT '',
    last_change DATETIME NOT NULL
                         DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now') ),
    min_x       DOUBLE,
    min_y       DOUBLE,
    max_x       DOUBLE,
    max_y       DOUBLE,
    srs_id      INTEGER,
    CONSTRAINT fk_gc_r_srs_id FOREIGN KEY (
        srs_id
    )
    REFERENCES gpkg_spatial_ref_sys (srs_id) 
);

INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('tip_l', 'features', 'tip_l', 'Tipo de tabela: Tipologia Linear. Descrição: Contém os objetos com geometria linear - leitos dos cursos de água, canalizados ou não. Exemplo: O objeto Cursos de água-Leito (código 21) composto por várias linhas, tantas quantos os Rios, Ribeiros e afluentes ou outros considerados como REN, sendo que cada uma dessas linhas corresponde a um registo da tabela.', '2025-08-12T10:42:53.459Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('det_tip_l', 'features', 'det_tip_l', 'Tipo de tabela: Detalhe de Tipologia Linear. Descrição: Contém os objetos com geometria linear - leitos dos cursos de água, canalizados ou não. Exemplo: O objeto Cursos de água-Leito (código 21) composto por várias linhas, tantas quantos os Rios, Ribeiros e afluentes ou outros considerados como REN, sendo que cada uma dessas linhas corresponde a um registo da tabela.', '2025-08-12T10:42:53.460Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('tip_p', 'features', 'tip_p', 'Tipo de tabela: Tipologia Poligonal. Descrição: Contém os objetos com geometria poligonal que correpondem às tipologias delimitadas na carta da REN antes de serem ponderadas as exclusões (“REN Bruta”).Cada linha da tabela corresponde a um objeto do catálogo sendo que esse objeto é formado por um ou mais polígonos. Exemplo: Na tabela "tip_p", o objeto Cursos de água Leitos (código 21) é um único registo na tabela, não obstante ser composta por vários polígonos, tantos quantos os Rios, Ribeiros e afluentes ou outros considerados como REN.', '2025-09-22T05:31:09.998Z', -36177.87109375, 163565.671875, -25724.443359375, 177793.0625, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('det_tip_p', 'features', 'det_tip_p', 'Tipo de tabela: Detalhe de Tipologia Poligonal. Descrição: Contém os objetos com geometria poligonal que correpondem às tipologias delimitadas na carta da REN antes de serem ponderadas as exclusões (“REN Bruta”).Cada linha da tabela corresponde a um objeto do catálogo sendo que esse objeto é formado por um ou mais polígonos. Exemplo: Na tabela DET_TIP_P, o objeto Cursos de água Leitos (código 21) é um único registo na tabela, não obstante ser composta por vários polígonos, tantos quantos os Rios, Ribeiros e afluentes ou outros considerados como REN.', '2025-08-12T10:42:53.461Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('excl_p', 'features', 'excl_p', 'Tipo de tabela: Exclusão Poligonal. Descrição: Contém os objetos com geometria poligonal que correspondem às exclusões. Cada linha da tabela corresponde a uma exclusão identificada pelo tipo (C ou E) e n.º ordem (de 1 a n).', '2025-09-22T05:32:01.592Z', -35736.19140625, 164877.796875, -26140.447265625, 176237.0, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('det_excl_p', 'features', 'det_excl_p', 'Tipo de tabela: Detalhe de Exclusão Poligonal. Descrição: Contém os objetos com geometria poligonal que correspondem às exclusões. Cada linha da tabela corresponde a uma exclusão identificada pelo tipo (C ou E) e n.º ordem (de 1 a n).', '2025-08-12T10:42:53.462Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('det_excl_tip', 'features', 'det_excl_tip', 'Tipo de tabela: Relação Detalhe Exclusão-Tipologia. Descrição: Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.', '2025-08-12T10:42:53.462Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('excl_tip', 'features', 'excl_tip', 'Tipo de tabela: Relação Exclusão-Tipologia. Descrição: Relaciona, através de interseção, as exclusões com as tipologias de forma a explicitar as diferentes tipologias abrangidas por cada exclusão.', '2025-08-12T10:42:53.462Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('catalogo', 'attributes', 'catalogo', 'Tipo de tabela: Base. Descrição: Contém todos os objetos e organização previstos no catálogo de objetos da carta da REN.', '2025-08-12T10:42:53.642Z', NULL, NULL, NULL, NULL, 0);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('codigo_ine', 'attributes', 'codigo_ine', 'Tipo de tabela: Base. Descrição: Lista de municípios portugueses com seus respectivos códigos DTCC (Divisão Territorial de Classificação Cartográfica).', '2025-08-12T10:42:53.786Z', NULL, NULL, NULL, NULL, 0);
-- INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('layer_styles', 'attributes', 'layer_styles', '', '2025-08-14T00:11:07.778Z', NULL, NULL, NULL, NULL, 0);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('ato_especifico', 'attributes', 'ato_especifico', 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf
Tabela secundária "ATO_ESPECIFICO"', '2025-09-22T06:55:48.093Z', NULL, NULL, NULL, NULL, 0);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('atribuir_concelho', 'attributes', 'atribuir_concelho', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('catalogo_l', 'attributes', 'catalogo_l', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('catalogo_p', 'attributes', 'catalogo_p', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('catalogo_excl', 'attributes', 'catalogo_excl', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('quadro_anexo', 'attributes', 'quadro_anexo', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);

-- ==========================================================
-- Tabela: gpkg_data_columns
-- ==========================================================

-- Table: gpkg_data_columns
DROP TABLE IF EXISTS gpkg_data_columns;

CREATE TABLE IF NOT EXISTS gpkg_data_columns (
    table_name      TEXT NOT NULL,
    column_name     TEXT NOT NULL,
    name            TEXT,
    title           TEXT,
    description     TEXT,
    mime_type       TEXT,
    constraint_name TEXT,
    CONSTRAINT pk_gdc PRIMARY KEY (
        table_name,
        column_name
    ),
    CONSTRAINT gdc_tn UNIQUE (
        table_name,
        name
    )
);

INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'id', 'ID', NULL, 'Descrição: identificador único; Alias: Código Int; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'tema', 'Tema', NULL, 'Descrição: Agregação de tipologias de áreas a incluir na REN ou áreas a excluir da REN.; Alias: Tema; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'subtema', 'SubTema', NULL, 'Descrição: Nome da tipologia de área a incluir na REN ou do tipo de exclusão da REN.; Alias: Subtema; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'nome_obje', 'Nome_Obje', NULL, 'Descrição: Designação do objeto.; Alias: Nome do Objeto; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos. Campo que identifica univocamente cada linha da tabela. É a chave primária da tabela auxiliar que funciona como chave estrangeira para as tabelas gráficas.; Alias: Código do Objeto; Tipo de data: Inteiro (Nota: O PDF indica ""Texto"", mas implementado como Inteiro para compatibilidade com PK/FK)', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'legenda', 'legenda', NULL, 'Descrição: Texto que identifica o objeto na “Legenda da simbologia” da carta da REN; Alias: Legenda; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('catalogo', 'acron_obje', 'Acron_Obje', NULL, 'Descrição: Acrónimo do nome do objeto; Alias: Acrónimo Objeto; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('codigo_ine', 'id', 'ID', NULL, 'Descrição: identificador único; Alias: Código Int; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('codigo_ine', 'municipio', 'Municipio', NULL, 'Descrição: Nome do município; Alias: Município; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('codigo_ine', 'dtcc', 'dtcc', NULL, 'Descrição: Código DTCC do município; Alias: DTCC; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_p', 'fid_d_excl_p', 'fid_d_excl_p', NULL, 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_d_excl_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_p', 'exclusao', 'Exclusao', NULL, 'Descrição: Tipo e número de ordem da exclusão (de C1 a Cn e E1 a En); Alias: Exclusao; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_p', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 37 e 38). É a chave primária da tabela secundária.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_p', 'area_m2', 'Area_m2', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_tip', 'fid_d_tip_excl', 'fid_d_tip_excl', NULL, 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_d_tip_excl; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_tip', 'fid_d_tip_p', 'fid_d_tip_p', NULL, 'Descrição: Campo de numeração automatica da tabela DETALHE_TIPOLOGIAS_POLIGONOS; Alias: fid_d_tip_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_tip', 'fid_d_excl_p', 'fid_d_excl_p', NULL, 'Descrição: Campo de numeração automatica da tabela _DETALHE_EXCLUSOES_POLIGONOS; Alias: fid_d_excl_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_l', 'fid_d_tip_l', 'fid_d_tip_l', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_d_tip_l; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_l', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_l', 'comp_m', 'Comp_m', NULL, 'Descrição: Distância entre o ponto inicial e o final medida em metros.; Alias: Comp_m; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_p', 'fid_d_tip_p', 'fid_d_tip_p', NULL, 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_d_tip_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_p', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36). É a chave primária da tabela gráfica.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_p', 'area_m2', 'Area_m2', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'fid_excl_p', 'fid_excl_p', NULL, 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_excl_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'exclusao', 'Exclusao', NULL, 'Descrição: Tipo e número de ordem da exclusão (de C1 a Cn e E1 a En); Alias: Exclusao; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 37 e 38). É a chave primária da tabela secundária.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'area_m2', 'Area_m2', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'fundamento', 'Fundamento', NULL, 'Descrição: Fundamentação da necessidade de exclusão.; Alias: Fundamento; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'fimdest', 'FimDest', NULL, 'Descrição: Fim a que se destina a area a excluir.; Alias: FimDest; Tipo de data: Texto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_tip', 'fid_tip_excl', 'fid_tip_excl', NULL, 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_tip_excl; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_tip', 'fid_tip_p', 'fid_tip_p', NULL, 'Descrição: Campo de numeração automatica da tabela TIPOLOGIAS_POLIGONOS; Alias: fid_tip_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_tip', 'fid_excl_p', 'fid_excl_p', NULL, 'Descrição: Campo de numeração automatica da tabela EXCLUSOES_POLIGONOS; Alias: fid_excl_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_l', 'fid_tip_l', 'fid_tip_l', NULL, 'Descrição: Campo de numeração automática e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_tip_l; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_l', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 21 e 22). É a chave primária da tabela gráfica.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_l', 'comp_m', 'Comp_m', NULL, 'Descrição: Distância entre o ponto inicial e o final medida em metros.; Alias: Comp_m; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_p', 'fid_tip_p', 'fid_tip_p', NULL, 'Descrição: Campo de numeração automatica e crescente, que identifica univocamente cada linha da tabela.; Alias: fid_tip_p; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_p', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36). É a chave primária da tabela gráfica.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_p', 'area_m2', 'Area_m2', NULL, 'Descrição: Medida da superfície do polígono em metros quadrados.; Alias: Area_m2; Tipo de data: Número Real', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_tip', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36). É a chave primária da tabela gráfica.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_tip', 'cod_obje', 'cod_obje', NULL, 'Descrição: Código do objeto utilizado no catálogo de objetos (códigos 1 a 36). É a chave primária da tabela gráfica.; Alias: cod_obje; Tipo de data: Inteiro', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'num_dr', NULL, NULL, 'NUM_DR – campo do tipo texto que indica o número do Diário da República onde foi publicado o ato específico que constitui a servidão ou restrição de utilidade pública;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'tipo_ato', NULL, NULL, 'TIPO_ATO – campo do tipo texto que indica o tipo de ato que constitui a servidão ou restrição de utilidade pública. Este campo tem como domínio do atributo as seguintes opções: “Lei”; “Decreto-Lei”; “Dec-Reg” caso se trate de Decreto-Regulamentar; “Decreto”; “RCM” caso se trate de Resolução do Conselho de Ministros”; “Portaria”; “Aviso”; “Decisao” caso se trate de Decisão; “Declaracao” caso se trate de Declaração; “Deliberacao” caso se trate de Deliberação; “Despacho”; “Desp-Conj” caso se trate de Despacho-Conjunto; e “Regulamento”;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'num_ato', NULL, NULL, 'NUM_ATO – campo do tipo texto que indica o número do ato específico que constitui a servidão ou restrição de utilidade pública;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'data_ato', NULL, NULL, 'DATA – campo do tipo data que indica a data do ato específico que constitui a servidão ou restrição de utilidade pública;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'observ', NULL, NULL, 'OBSERV – campo do tipo texto, de preenchimento não obrigatório, destinado à indicação de outras observações.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_l', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('tip_p', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_p', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('excl_tip', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_l', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_tip_p', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_p', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('det_excl_tip', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);


-- Table: gpkg_extensions
DROP TABLE IF EXISTS gpkg_extensions;

CREATE TABLE IF NOT EXISTS gpkg_extensions (
    table_name     TEXT,
    column_name    TEXT,
    extension_name TEXT NOT NULL,
    definition     TEXT NOT NULL,
    scope          TEXT NOT NULL,
    CONSTRAINT ge_tce UNIQUE (
        table_name,
        column_name,
        extension_name
    )
);

INSERT INTO gpkg_extensions (table_name, column_name, extension_name, definition, scope) VALUES ('gpkg_data_columns', NULL, 'gpkg_schema', 'http://www.geopackage.org/spec121/#extension_schema', 'read-write');
INSERT INTO gpkg_extensions (table_name, column_name, extension_name, definition, scope) VALUES ('gpkg_data_column_constraints', NULL, 'gpkg_schema', 'http://www.geopackage.org/spec121/#extension_schema', 'read-write');
INSERT INTO gpkg_extensions (table_name, column_name, extension_name, definition, scope) VALUES ('gpkg_metadata', NULL, 'gpkg_metadata', 'http://www.geopackage.org/spec120/#extension_metadata', 'read-write');
INSERT INTO gpkg_extensions (table_name, column_name, extension_name, definition, scope) VALUES ('gpkg_metadata_reference', NULL, 'gpkg_metadata', 'http://www.geopackage.org/spec120/#extension_metadata', 'read-write');


-- Table: gpkg_geometry_columns
DROP TABLE IF EXISTS gpkg_geometry_columns;

CREATE TABLE IF NOT EXISTS gpkg_geometry_columns (
    table_name         TEXT    NOT NULL,
    column_name        TEXT    NOT NULL,
    geometry_type_name TEXT    NOT NULL,
    srs_id             INTEGER NOT NULL,
    z                  TINYINT NOT NULL,
    m                  TINYINT NOT NULL,
    CONSTRAINT pk_geom_cols PRIMARY KEY (
        table_name,
        column_name
    ),
    CONSTRAINT uk_gc_table_name UNIQUE (
        table_name
    ),
    CONSTRAINT fk_gc_tn FOREIGN KEY (
        table_name
    )
    REFERENCES gpkg_contents (table_name),
    CONSTRAINT fk_gc_srs FOREIGN KEY (
        srs_id
    )
    REFERENCES gpkg_spatial_ref_sys (srs_id) 
);

INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('tip_l', 'geom', 'MULTILINESTRING', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('det_tip_l', 'geom', 'MULTILINESTRING', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('tip_p', 'geom', 'MULTIPOLYGON', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('det_tip_p', 'geom', 'MULTIPOLYGON', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('excl_p', 'geom', 'MULTIPOLYGON', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('det_excl_p', 'geom', 'MULTIPOLYGON', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('det_excl_tip', 'geom', 'MULTIPOLYGON', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('excl_tip', 'geom', 'MULTIPOLYGON', 3763, 0, 0);


-- Table: gpkg_data_column_constraints
DROP TABLE IF EXISTS gpkg_data_column_constraints;

CREATE TABLE IF NOT EXISTS gpkg_data_column_constraints (
    constraint_name  TEXT    NOT NULL,
    constraint_type  TEXT    NOT NULL,
    value            TEXT,
    min              NUMERIC,
    min_is_inclusive BOOLEAN,
    max              NUMERIC,
    max_is_inclusive BOOLEAN,
    description      TEXT,
    CONSTRAINT gdcc_ntv UNIQUE (
        constraint_name,
        constraint_type,
        value
    )
);


-- Table: gpkg_metadata
DROP TABLE IF EXISTS gpkg_metadata;

CREATE TABLE IF NOT EXISTS gpkg_metadata (
    id              INTEGER CONSTRAINT m_pk PRIMARY KEY ASC
                            NOT NULL,
    md_scope        TEXT    NOT NULL
                            DEFAULT 'dataset',
    md_standard_uri TEXT    NOT NULL,
    mime_type       TEXT    NOT NULL
                            DEFAULT 'text/xml',
    metadata        TEXT    NOT NULL
                            DEFAULT ''
);


-- Table: gpkg_metadata_reference
DROP TABLE IF EXISTS gpkg_metadata_reference;

CREATE TABLE IF NOT EXISTS gpkg_metadata_reference (
    reference_scope TEXT     NOT NULL,
    table_name      TEXT,
    column_name     TEXT,
    row_id_value    INTEGER,
    timestamp       DATETIME NOT NULL
                             DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now') ),
    md_file_id      INTEGER  NOT NULL,
    md_parent_id    INTEGER,
    CONSTRAINT crmr_mfi_fk FOREIGN KEY (
        md_file_id
    )
    REFERENCES gpkg_metadata (id),
    CONSTRAINT crmr_mpi_fk FOREIGN KEY (
        md_parent_id
    )
    REFERENCES gpkg_metadata (id) 
);

-- INSERT INTO gpkg_metadata_reference (reference_scope, table_name, column_name, row_id_value, timestamp, md_file_id, md_parent_id) VALUES ('table', 'ato_especifico', NULL, NULL, '2025-09-22T06:55:48.157Z', 2, NULL);

-- Table: gpkg_ogr_contents
DROP TABLE IF EXISTS gpkg_ogr_contents;

CREATE TABLE IF NOT EXISTS gpkg_ogr_contents (
    table_name    TEXT    NOT NULL
                          PRIMARY KEY,
    feature_count INTEGER DEFAULT NULL
);

INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('tip_l', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('det_tip_l', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('tip_p', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('det_tip_p', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('excl_p', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('det_excl_p', 0);
-- INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('det_excl_tip', 0);
-- INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('excl_tip', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('catalogo', 38);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('codigo_ine', 278);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('ato_especifico', 0);

-- Table: gpkg_spatial_ref_sys
DROP TABLE IF EXISTS gpkg_spatial_ref_sys;

CREATE TABLE IF NOT EXISTS gpkg_spatial_ref_sys (
    srs_name                 TEXT    NOT NULL,
    srs_id                   INTEGER NOT NULL
                                     PRIMARY KEY,
    organization             TEXT    NOT NULL,
    organization_coordsys_id INTEGER NOT NULL,
    definition               TEXT    NOT NULL,
    description              TEXT
);

INSERT INTO gpkg_spatial_ref_sys (srs_name, srs_id, organization, organization_coordsys_id, definition, description) VALUES ('Undefined Cartesian SRS', -1, 'NONE', -1, 'undefined', 'undefined Cartesian coordinate reference system');
INSERT INTO gpkg_spatial_ref_sys (srs_name, srs_id, organization, organization_coordsys_id, definition, description) VALUES ('Undefined geographic SRS', 0, 'NONE', 0, 'undefined', 'undefined geographic coordinate reference system');
INSERT INTO gpkg_spatial_ref_sys (srs_name, srs_id, organization, organization_coordsys_id, definition, description) VALUES ('WGS 84 geodetic', 4326, 'EPSG', 4326, 'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AXIS["Latitude",NORTH],AXIS["Longitude",EAST],AUTHORITY["EPSG","4326"]]', 'longitude/latitude coordinates in decimal degrees on the WGS 84 spheroid');
INSERT INTO gpkg_spatial_ref_sys (srs_name, srs_id, organization, organization_coordsys_id, definition, description) VALUES ('ETRS89 / Portugal TM06', 3763, 'EPSG', 3763, 'PROJCS["ETRS89 / Portugal TM06",GEOGCS["ETRS89",DATUM["European_Terrestrial_Reference_System_1989",SPHEROID["GRS 1980",6378137,298.257222101,AUTHORITY["EPSG","7019"]],AUTHORITY["EPSG","6258"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4258"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",39.6682583333333],PARAMETER["central_meridian",-8.13310833333333],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AXIS["Easting",EAST],AXIS["Northing",NORTH],AUTHORITY["EPSG","3763"]]', NULL);



COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
