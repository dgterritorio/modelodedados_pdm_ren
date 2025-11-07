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
-- Tabela: objeto_planta
-- ==========================================================
DROP TABLE IF EXISTS objeto_planta;

CREATE TABLE IF NOT EXISTS objeto_planta (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    planta TEXT UNIQUE
);

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
-- Tabela: objeto_tipo
-- ==========================================================
DROP TABLE IF EXISTS objeto_tipo;

CREATE TABLE IF NOT EXISTS objeto_tipo (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    codigo INTEGER NOT NULL UNIQUE,
    planta_o     TEXT,
    tema_o       TEXT,
    subtema_o    TEXT,
    planta_c     TEXT,
    tema_c       TEXT,
    subtema_c    TEXT,
    designacao   TEXT,
    geometria    TEXT,
    FOREIGN KEY (planta_o) REFERENCES objeto_planta (planta),
    FOREIGN KEY (planta_c) REFERENCES objeto_planta (planta)
);

-- ==========================================================
-- Tabela: objeto_ponto
-- ==========================================================
DROP TABLE IF EXISTS objeto_ponto;

CREATE TABLE IF NOT EXISTS objeto_ponto (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom MULTIPOINT,
    objeto_uuid TEXT,
    dtcc        TEXT NOT NULL,
    planta      TEXT NOT NULL,
    codigo      INTEGER NOT NULL,
    legenda     TEXT,
    etiqueta    TEXT,
    fonte_inf   TEXT,
    data_inf    DATE,
    ato_id      INTEGER,
    FOREIGN KEY (codigo) REFERENCES objeto_tipo (codigo),
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta)
    -- (opcional) valida que é um UUID hex de 32 chars
    -- , CHECK (length(objeto_uuid)=32 AND objeto_uuid GLOB '[0-9a-f]*')
);

-- Trigger para gerar UUID automaticamente
-- Trigger: objeto_ponto_calc_uuid
DROP TRIGGER IF EXISTS objeto_ponto_calc_uuid;
CREATE TRIGGER IF NOT EXISTS objeto_ponto_calc_uuid
                       AFTER INSERT
                          ON objeto_ponto
                    FOR EACH ROW
                        WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE objeto_ponto
       SET objeto_uuid = (substr(lower(hex(randomblob(16) ) ), 1, 32) ) 
       -- objeto_uuid = CreateUUID(),
     WHERE fid = NEW.fid;
END;

-- ==========================================================
-- Tabela: objeto_linha
-- ==========================================================
DROP TABLE IF EXISTS objeto_linha;

CREATE TABLE IF NOT EXISTS objeto_linha (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom MULTILINESTRING,
    objeto_uuid TEXT,
    dtcc        TEXT NOT NULL,
    planta      TEXT NOT NULL,
    codigo      INTEGER NOT NULL,
    legenda     TEXT,
    etiqueta    TEXT,
    fonte_inf   TEXT,
    data_inf    DATE,
    medida      REAL,
    ato_id      INTEGER,
    -- medida NUMERIC GENERATED ALWAYS AS (ROUND(ST_Length(geom) / 1000.0, 2)) STORED -- disponivel SQLite ≥ 3.31
    FOREIGN KEY (codigo) REFERENCES objeto_tipo (codigo),
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta)
);

-- Trigger para calcular comprimento (km) depois do insert e gerar UUID automaticamente
-- Trigger: objeto_linha_calc_uuid
DROP TRIGGER IF EXISTS objeto_linha_calc_uuid;

CREATE TRIGGER IF NOT EXISTS objeto_linha_calc_uuid
AFTER INSERT ON objeto_linha
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE objeto_linha
    SET objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    -- objeto_uuid = CreateUUID(),
    medida = (ROUND(ST_Length(geom) / 1000.0, 2)) -- AS comprimento_km
    -- SET medida = (ROUND(ST_Length(geom), 2)) AS comprimento_m, -- 
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular comprimento quando a geometria mudar
-- Trigger: objeto_linha_recalc
DROP TRIGGER IF EXISTS objeto_linha_recalc;

CREATE TRIGGER IF NOT EXISTS objeto_linha_recalc
AFTER UPDATE OF geom ON objeto_linha
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE objeto_linha
    SET medida = (ROUND(ST_Length(geom) / 1000.0, 2)) -- AS comprimento_km
    -- SET medida = (ROUND(ST_Length(geom), 2)) AS comprimento_m, -- 
    WHERE fid = NEW.fid;
END;

-- ==========================================================
-- Tabela: objeto_poligono
-- ==========================================================
DROP TABLE IF EXISTS objeto_poligono;

CREATE TABLE IF NOT EXISTS objeto_poligono (
    fid INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    geom MULTIPOLYGON,
    objeto_uuid TEXT,
    dtcc        TEXT NOT NULL,
    planta      TEXT NOT NULL,
    codigo      INTEGER NOT NULL,
    legenda     TEXT,
    etiqueta    TEXT,
    fonte_inf   TEXT,
    data_inf    DATE,
    medida      REAL,
    ato_id      INTEGER,
    -- medida NUMERIC GENERATED ALWAYS AS (ROUND(ST_Area(geom) / 1000.0, 2)) STORED -- disponivel SQLite ≥ 3.31
    FOREIGN KEY (codigo) REFERENCES objeto_tipo (codigo),
    FOREIGN KEY (ato_id) REFERENCES ato_especifico (fid),
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (planta) REFERENCES objeto_planta (planta)
);

-- Trigger para calcular área (ha) depois do insert e  gerar UUID automaticamente
-- Trigger: objeto_poligono_calc_uuid
DROP TRIGGER IF EXISTS objeto_poligono_calc_uuid;

CREATE TRIGGER IF NOT EXISTS objeto_poligono_calc_uuid
AFTER INSERT ON objeto_poligono
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE objeto_poligono
    SET objeto_uuid = (substr(lower(hex(randomblob(16))), 1, 32)),
    -- objeto_uuid = CreateUUID(),
    medida = (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    -- medida = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    WHERE fid = NEW.fid;
END;

-- Trigger para recalcular área quando a geometria mudar
-- Trigger: objeto_poligono_recalc
DROP TRIGGER IF EXISTS objeto_poligono_recalc;

CREATE TRIGGER IF NOT EXISTS objeto_poligono_recalc
AFTER UPDATE OF geom ON objeto_poligono
FOR EACH ROW
WHEN NEW.geom IS NOT NULL
BEGIN
    UPDATE objeto_poligono
    SET medida= (ROUND(ST_Area(geom) / 10000.0, 2)) -- AS area_ha
    -- SET medida = (ROUND(ST_Area(geom), 2)) -- AS area_m2
    WHERE fid = NEW.fid;
END;

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
    dtcc       TEXT,
    n_deposito TEXT,
    FOREIGN KEY (dtcc) REFERENCES atribuir_concelho (dtcc) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ==========================================================
-- VISTAS
-- ==========================================================
-- View: objeto_tipo_ord
DROP VIEW IF EXISTS objeto_tipo_ord;

CREATE VIEW IF NOT EXISTS objeto_tipo_ord AS
    SELECT t.fid
           , t.codigo
           , t.planta_o AS planta
           , t.tema_o AS tema
           , t.subtema_o AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_o IS NOT NULL;

-- View: objeto_tipo_cond
DROP VIEW IF EXISTS objeto_tipo_cond;

CREATE VIEW IF NOT EXISTS objeto_tipo_cond AS
    SELECT t.fid
           , t.codigo
           , t.planta_c AS planta
           , t.tema_c AS tema
           , t.subtema_c AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_c IS NOT NULL;

-- View: objeto_tipo_cond_pt
DROP VIEW IF EXISTS objeto_tipo_cond_pt;

CREATE VIEW IF NOT EXISTS objeto_tipo_cond_pt AS
    SELECT t.fid
           , t.codigo
           , t.planta_c AS planta
           , t.tema_c AS tema
           , t.subtema_c AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_c IS NOT NULL AND t.geometria LIKE '%Ponto%' COLLATE NOCASE;

-- View: objeto_tipo_cond_ln
DROP VIEW IF EXISTS objeto_tipo_cond_ln;

CREATE VIEW IF NOT EXISTS objeto_tipo_cond_ln AS
    SELECT t.fid
           , t.codigo
           , t.planta_c AS planta
           , t.tema_c AS tema
           , t.subtema_c AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_c IS NOT NULL AND t.geometria LIKE '%Linha%' COLLATE NOCASE;

-- View: objeto_tipo_cond_pl
DROP VIEW IF EXISTS objeto_tipo_cond_pl;

CREATE VIEW IF NOT EXISTS objeto_tipo_cond_pl AS
    SELECT t.fid
           , t.codigo
           , t.planta_c AS planta
           , t.tema_c AS tema
           , t.subtema_c AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_c IS NOT NULL AND t.geometria LIKE '%Polígono%' COLLATE NOCASE;

-- View: objeto_tipo_ord_pt
DROP VIEW IF EXISTS objeto_tipo_ord_pt;

CREATE VIEW IF NOT EXISTS objeto_tipo_ord_pt AS
    SELECT t.fid
           , t.codigo
           , t.planta_o AS planta
           , t.tema_o AS tema
           , t.subtema_o AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_o IS NOT NULL AND t.geometria LIKE '%Ponto%' COLLATE NOCASE;

-- View: objeto_tipo_ord_ln
DROP VIEW IF EXISTS objeto_tipo_ord_ln;

CREATE VIEW IF NOT EXISTS objeto_tipo_ord_ln AS
    SELECT t.fid
           , t.codigo
           , t.planta_o AS planta
           , t.tema_o AS tema
           , t.subtema_o AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_o IS NOT NULL AND t.geometria LIKE '%Linha%' COLLATE NOCASE;

-- View: objeto_tipo_ord_pl
DROP VIEW IF EXISTS objeto_tipo_ord_pl;

CREATE VIEW IF NOT EXISTS objeto_tipo_ord_pl AS
    SELECT t.fid
           , t.codigo
           , t.planta_o AS planta
           , t.tema_o AS tema
           , t.subtema_o AS subtema
           , t.designacao
           , t.geometria
           , t.codigo || ' - ' ||  t.designacao AS cod_designacao
    FROM objeto_tipo t
    WHERE t.planta_o IS NOT NULL AND t.geometria LIKE '%Polígono%' COLLATE NOCASE;

-- View: objetos_ln
DROP VIEW IF EXISTS objetos_ln;
CREATE VIEW IF NOT EXISTS objetos_ln AS
    SELECT l.objeto_uuid,
           'objeto_linha' AS tipo_geom,
           CASE WHEN ot.planta_c IS NULL THEN ot.planta_o ELSE ot.planta_c END AS planta,
           CASE WHEN ot.tema_c IS NULL THEN ot.tema_o ELSE ot.tema_c END AS tema,
           CASE WHEN ot.subtema_c IS NULL THEN ot.subtema_o ELSE ot.subtema_c END AS subtema,
           ot.designacao,
           l.codigo,
           l.legenda,
           l.etiqueta,
           l.medida,
           l.fonte_inf,
           l.data_inf,
           l.geom
      FROM objeto_linha l
           JOIN
           objeto_tipo ot ON l.codigo = ot.codigo;

-- View: objetos_pl
DROP VIEW IF EXISTS objetos_pl;
CREATE VIEW IF NOT EXISTS objetos_pl AS
    SELECT g.objeto_uuid,
           'objeto_poligono' AS tipo_geom,
           CASE WHEN ot.planta_c IS NULL THEN ot.planta_o ELSE ot.planta_c END AS planta,
           CASE WHEN ot.tema_c IS NULL THEN ot.tema_o ELSE ot.tema_c END AS tema,
           CASE WHEN ot.subtema_c IS NULL THEN ot.subtema_o ELSE ot.subtema_c END AS subtema,
           ot.designacao,
           g.codigo,
           g.legenda,
           g.etiqueta,
           g.medida,
           g.fonte_inf,
           g.data_inf,
           g.geom
      FROM objeto_poligono g
           JOIN
           objeto_tipo ot ON g.codigo = ot.codigo;


-- View: objetos_pt
DROP VIEW IF EXISTS objetos_pt;
CREATE VIEW IF NOT EXISTS objetos_pt AS
    SELECT p.objeto_uuid,
           'objeto_ponto' AS tipo_geom,
           CASE WHEN ot.planta_c IS NULL THEN ot.planta_o ELSE ot.planta_c END AS planta,
           CASE WHEN ot.tema_c IS NULL THEN ot.tema_o ELSE ot.tema_c END AS tema,
           CASE WHEN ot.subtema_c IS NULL THEN ot.subtema_o ELSE ot.subtema_c END AS subtema,
           ot.designacao,
           p.codigo,
           p.legenda,
           p.etiqueta,
           p.fonte_inf,
           p.data_inf,
           p.geom
      FROM objeto_ponto p
           JOIN
           objeto_tipo ot ON p.codigo = ot.codigo;


--- -- View: atos_com_objetos_ln
--- DROP VIEW IF EXISTS atos_com_objetos_ln;
--- CREATE VIEW IF NOT EXISTS atos_com_objetos_ln AS
---     SELECT ae.fid AS ato_fid,
---            ae.tipo_ato,
---            ae.num_ato,
---            ae.data_ato,
---            ae.fonte_ato,
---            ae.observ,
---            ao.tipo_geom,
---            ao.objeto_fid,
---            ot.planta,
---            ot.tema,
---            ot.subtema,
---            ot.designacao,
---            ot.codigo,
---            o.especifica,
---            o.legenda,
---            o.etiqueta,
---            o.medida,
---            o.fonte_inf,
---            o.data_inf,
---            o.geom
---       FROM ato_especifico ae
---            JOIN
---            ato_objeto ao ON ao.ato_fid = ae.fid AND
---                             ao.tipo_geom = 'objeto_linha'
---            JOIN
---            objetos_ln o ON o.id_unico = ao.objeto_fid
---            JOIN
---            objeto_tipo ot ON ot.codigo = o.especifica AND
---                              ot.planta = o.planta;
--- 
--- 
--- -- View: atos_com_objetos_pl
--- DROP VIEW IF EXISTS atos_com_objetos_pl;
--- CREATE VIEW IF NOT EXISTS atos_com_objetos_pl AS
---     SELECT ae.fid AS ato_fid,
---            ae.tipo_ato,
---            ae.num_ato,
---            ae.data_ato,
---            ae.fonte_ato,
---            ae.observ,
---            ao.tipo_geom,
---            ao.objeto_fid,
---            ot.planta,
---            ot.tema,
---            ot.subtema,
---            ot.designacao,
---            ot.codigo,
---            o.especifica,
---            o.legenda,
---            o.etiqueta,
---            o.medida,
---            o.fonte_inf,
---            o.data_inf,
---            o.geom
---       FROM ato_especifico ae
---            JOIN
---            ato_objeto ao ON ao.ato_fid = ae.fid AND
---                             ao.tipo_geom = 'objeto_poligono'
---            JOIN
---            objetos_pl o ON o.id_unico = ao.objeto_fid
---            JOIN
---            objeto_tipo ot ON ot.codigo = o.especifica AND
---                              ot.planta = o.planta;
--- 
--- 
--- -- View: atos_com_objetos_pt
--- DROP VIEW IF EXISTS atos_com_objetos_pt;
--- CREATE VIEW IF NOT EXISTS atos_com_objetos_pt AS
---     SELECT ae.fid AS ato_fid,
---            ae.tipo_ato,
---            ae.num_ato,
---            ae.data_ato,
---            ae.fonte_ato,
---            ae.observ,
---            ao.tipo_geom,
---            ao.objeto_fid,
---            ot.planta,
---            ot.tema,
---            ot.subtema,
---            ot.designacao,
---            ot.codigo,
---            o.especifica,
---            o.legenda,
---            o.etiqueta,
---            o.fonte_inf,
---            o.data_inf,
---            o.geom
---       FROM ato_especifico ae
---            JOIN
---            ato_objeto ao ON ao.ato_fid = ae.fid AND
---                             ao.tipo_geom = 'objeto_ponto'
---            JOIN
---            objetos_pt o ON o.id_unico = ao.objeto_fid
---            JOIN
---            objeto_tipo ot ON ot.codigo = o.codigo AND
---                              ot.planta = o.planta;


-- ==========================================================
-- TRIGGERS - INSERT
-- ==========================================================
-- ato_especifico
CREATE TRIGGER trigger_insert_feature_count_ato_especifico
AFTER INSERT ON ato_especifico
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count + 1
    WHERE lower(table_name) = lower('ato_especifico');
END;

CREATE TRIGGER trigger_delete_feature_count_ato_especifico
AFTER DELETE ON ato_especifico
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count - 1
    WHERE lower(table_name) = lower('ato_especifico');
END;

-- objeto_ponto
CREATE TRIGGER trigger_insert_feature_count_objeto_ponto
AFTER INSERT ON objeto_ponto
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count + 1
    WHERE lower(table_name) = lower('objeto_ponto');
END;

CREATE TRIGGER trigger_delete_feature_count_objeto_ponto
AFTER DELETE ON objeto_ponto
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count - 1
    WHERE lower(table_name) = lower('objeto_ponto');
END;

-- objeto_linha
CREATE TRIGGER trigger_insert_feature_count_objeto_linha
AFTER INSERT ON objeto_linha
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count + 1
    WHERE lower(table_name) = lower('objeto_linha');
END;

CREATE TRIGGER trigger_delete_feature_count_objeto_linha
AFTER DELETE ON objeto_linha
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count - 1
    WHERE lower(table_name) = lower('objeto_linha');
END;

-- objeto_poligono
CREATE TRIGGER trigger_insert_feature_count_objeto_poligono
AFTER INSERT ON objeto_poligono
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count + 1
    WHERE lower(table_name) = lower('objeto_poligono');
END;

CREATE TRIGGER trigger_delete_feature_count_objeto_poligono
AFTER DELETE ON objeto_poligono
BEGIN
    UPDATE gpkg_ogr_contents
    SET feature_count = feature_count - 1
    WHERE lower(table_name) = lower('objeto_poligono');
END;

-- ==========================================================
-- DADOS - INSERT
-- ==========================================================

-- ==========================================================
-- Tabela: objeto_planta
-- ==========================================================
INSERT INTO objeto_planta (fid, planta) VALUES
(1,'Condicionantes'),
(2,'Ordenamento');

-- ==========================================================
-- Tabela: objeto_tipo
-- ==========================================================
INSERT INTO objeto_tipo (fid, codigo, planta_o, tema_o, subtema_o, planta_c, tema_c, subtema_c, designacao, geometria) VALUES 
(1, 1, 'Ordenamento', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', 'Condicionantes', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', 'Área de Intervenção do Plano', 'Polígono'),
(2, 2, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço Central', 'Polígono'),
(3, 3, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço Habitacional', 'Polígono'),
(4, 4, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço Urbano de Baixa Densidade', 'Polígono'),
(5, 5, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço de Atividades Económicas', 'Polígono'),
(6, 152, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço de uso especial – equipamento', 'Polígono'),
(7, 151, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço de uso especial – infraestrutura estruturante', 'Polígono'),
(8, 6, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço de uso especial – turístico', 'Polígono'),
(9, 7, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Urbano', NULL, NULL, NULL, 'Espaço Verde', 'Polígono'),
(10, 8, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço Agrícola', 'Polígono'),
(11, 9, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço Florestal', 'Polígono'),
(12, 10, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço de Exploração de Recursos Energéticos e Geológicos', 'Polígono'),
(13, 11, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço Natural e Paisagístico', 'Polígono'),
(14, 12, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço de Atividades Industriais', 'Polígono'),
(15, 13, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Aglomerado Rural', 'Polígono'),
(16, 14, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Área de Edificação Dispersa', 'Polígono'),
(17, 15, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço Cultural', 'Polígono'),
(18, 16, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço de Ocupação Turística', 'Polígono'),
(19, 17, 'Ordenamento', 'Classificação e Qualificação do Solo', 'Solo Rústico', NULL, NULL, NULL, 'Espaço de Equipamentos e Infraestruturas', 'Polígono'),
(20, 18, 'Ordenamento', 'Áreas com Funções Específicas', 'Estrutura Ecológica Municipal', NULL, NULL, NULL, 'Estrutura Ecológica Municipal', 'Polígono'),
(21, 19, 'Ordenamento', 'Áreas com Funções Específicas', 'Espaço Canal', NULL, NULL, NULL, 'Espaço Canal', 'Polígono'),
(22, 134, 'Ordenamento', 'Áreas com Funções Específicas', 'Risco', NULL, NULL, NULL, 'Área de Perigosidade', 'Polígono'),
(23, 133, 'Ordenamento', 'Áreas com Funções Específicas', 'Risco', NULL, NULL, NULL, 'Área de Risco', 'Polígono'),
(24, 139, 'Ordenamento', 'Áreas com Funções Específicas', 'Ruído', NULL, NULL, NULL, 'Zona Sensível ao Ruído', 'Polígono'),
(25, 140, 'Ordenamento', 'Áreas com Funções Específicas', 'Ruído', NULL, NULL, NULL, 'Zona Mista ao Ruído', 'Polígono'),
(26, 145, 'Ordenamento', 'Áreas com Funções Específicas', 'Zona de proteção e de salvaguarda dos recursos e valores naturais', NULL, NULL, NULL, 'Zona de proteção e de salvaguarda dos recursos e valores naturais', 'Polígono'),
(27, 149, 'Ordenamento', 'Áreas com Funções Específicas', 'Património geológico', NULL, NULL, NULL, 'Geossítio', 'Polígono'),
(28, 150, 'Ordenamento', 'Áreas com Funções Específicas', 'Inventário de bens culturais', NULL, NULL, NULL, 'Imóvel inventariado', 'Ponto'),
(29, 20, 'Ordenamento', 'Programação da Execução do Plano', 'Programação da Execução do Plano', NULL, NULL, NULL, 'Unidade Operativa de Planeamento e Gestão (U.O.P.G.)', 'Polígono'),
(30, 138, 'Ordenamento', 'Programação da Execução do Plano', 'Programação da Execução do Plano', NULL, NULL, NULL, 'Unidade de execução', 'Polígono'),
(31, 21, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Programas Territoriais', NULL, NULL, NULL, 'Área de Intervenção de Programa Especial', 'Polígono'),
(32, 130, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Programas Territoriais', NULL, NULL, NULL, 'Área de Intervenção de Programa Setorial', 'Polígono'),
(33, 131, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Programas Territoriais', NULL, NULL, NULL, 'Área de Intervenção de Programa Intermunicipal', 'Polígono'),
(34, 132, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Planos Territoriais', NULL, NULL, NULL, 'Área de Intervenção de Plano Intermunicipal (PUI, PPI)', 'Polígono'),
(35, 22, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Planos Territoriais', NULL, NULL, NULL, 'Área de Intervenção de Plano Municipal (PU, PP)', 'Polígono'),
(36, 135, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Reabilitação ou Revitalização', NULL, NULL, NULL, 'Área Urbana de Génese Ilegal (AUGI)', 'Polígono'),
(37, 136, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Reabilitação ou Revitalização', NULL, NULL, NULL, 'Área de Reabilitação Urbana (ARU)', 'Polígono'),
(38, 129, 'Ordenamento', 'Áreas de Intervenção de Outros Instrumentos ou Entidades', 'Área de Jurisdição dos Portos', NULL, NULL, NULL, 'Área de Jurisdição do Porto', 'Polígono'),
(39, 23, 'Ordenamento', 'Sistemas Estruturantes', 'Equipamentos de Utilização Coletiva', NULL, NULL, NULL, 'Equipamento de Utilização Coletiva', 'Polígono, Ponto'),
(40, 24, 'Ordenamento', 'Sistemas Estruturantes', 'Equipamentos de Utilização Coletiva', NULL, NULL, NULL, 'Equipamento de Utilização Coletiva Previsto', 'Polígono, Ponto'),
(41, 25, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Rodovia Principal', 'Linha'),
(42, 26, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Rodovia Principal Prevista', 'Linha'),
(43, 27, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Rodovia Distribuidora', 'Linha'),
(44, 28, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Rodovia Distribuidora Prevista', 'Linha'),
(45, 29, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Rodovia de Acesso Local', 'Linha'),
(46, 30, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Rodovia de Acesso Local Prevista', 'Linha'),
(47, 31, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Nó Rodoviário', 'Ponto'),
(48, 32, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Nó Rodoviário Previsto', 'Ponto'),
(49, 35, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', 'Condicionantes', 'Infraestruturas', 'Rede Ferroviária', 'Via-Férrea', 'Linha'),
(50, 36, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Via-Férrea Prevista', 'Linha'),
(51, 33, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Estação ou Interface de Transporte', 'Ponto'),
(52, 34, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Estação ou Interface de Transporte Prevista', 'Ponto'),
(53, 146, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Estacionamento', 'Ponto'),
(54, 147, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Estacionamento Previsto', 'Ponto'),
(55, 37, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Infraestrutura de Transporte Aéreo', 'Ponto'),
(56, 38, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Infraestrutura de Transporte Aéreo Prevista', 'Ponto'),
(57, 39, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Porto', 'Ponto'),
(58, 40, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Circulação e Transporte', NULL, NULL, NULL, 'Porto Previsto', 'Ponto'),
(59, 41, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Água', 'Condicionantes', 'Infraestruturas', 'Abastecimento de Água', 'Captação, Tratamento ou Armazenamento de Água', 'Ponto'),
(60, 42, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Água', NULL, NULL, NULL, 'Captação, Tratamento ou Armazenamento de Água Prevista', 'Ponto'),
(61, 45, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Drenagem de Águas Residuais', 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais', 'Bombagem ou Tratamento de Águas Residuais', 'Ponto'),
(62, 46, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Drenagem de Águas Residuais', NULL, NULL, NULL, 'Bombagem ou Tratamento de Águas Residuais Prevista', 'Ponto'),
(63, 47, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturasde Recolha e Tratamento de Resíduos Sólidos', NULL, NULL, NULL, 'Estação de Tratamento de Resíduos Sólidos', 'Ponto'),
(64, 48, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturasde Recolha e Tratamento de Resíduos Sólidos', NULL, NULL, NULL, 'Estação de Tratamento de Resíduos Sólidos Prevista', 'Ponto'),
(65, 49, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Energia Elétrica', 'Condicionantes', 'Infraestruturas', 'Rede Elétrica', 'Infraestrutura de Produção ou Transformação de Energia Elétrica', 'Ponto'),
(66, 50, 'Ordenamento', 'Sistemas Estruturantes', 'Infraestruturas de Abastecimento de Energia Elétrica', NULL, NULL, NULL, 'Infraestrutura de Produção ou Transformação de Energia Elétrica Prevista', 'Ponto'),
(67, 53, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Leito e Margem das Águas do Mar', 'Polígono'),
(68, 54, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Leito e Margem das Águas Fluviais', 'Linha, Polígono'),
(69, 55, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Zona Contígua à Margem', 'Polígono'),
(70, 56, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Domínio Público Hídrico', 'Zona Adjacente', 'Polígono'),
(71, 57, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Albufeira Classificada', 'Polígono'),
(72, 58, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Lago ou Lagoa classificada', 'Polígono'),
(73, 59, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona Terrestre de Proteção', 'Polígono'),
(74, 60, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona Reservada da Zona Terrestre de Proteção', 'Polígono'),
(75, 61, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona de Proteção da Barragem', 'Polígono'),
(76, 62, NULL, NULL, NULL, 'Condicionantes', 'Recursos Hídricos', 'Albufeiras, Lagos ou Lagoas de Águas Públicas', 'Zona de Respeito da Barragem', 'Polígono'),
(77, 63, NULL, NULL, NULL, 'Condicionantes', 'Recursos Geológicos', 'Captações de Águas Subterrâneas para Abastecimento Público', 'Perímetro de Proteção de Captação de Água Subterrânea', 'Polígono'),
(78, 64, NULL, NULL, NULL, 'Condicionantes', 'Recursos Geológicos', 'Águas de Nascente', 'Perímetro de Proteção de Águas da Nascente', 'Polígono'),
(79, 65, NULL, NULL, NULL, 'Condicionantes', 'Recursos Geológicos', 'Águas Minerais Naturais', 'Perímetro de Proteção de Águas Minerais Naturais', 'Polígono'),
(80, 66, NULL, NULL, NULL, 'Condicionantes', 'Recursos Geológicos', 'Pedreiras', 'Zona de Defesa / Zona Especial de Defesa', 'Polígono'),
(81, 67, NULL, NULL, NULL, 'Condicionantes', 'Recursos Geológicos', 'Pedreiras', 'Área Cativa / Área de Reserva', 'Polígono'),
(82, 142, NULL, NULL, NULL, 'Condicionantes', 'Recursos Geológicos', 'Recursos Geológicos', 'Área de Servidão de Recurso Geológico', 'Polígono'),
(83, 68, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Reserva Agrícola Nacional', 'Reserva Agrícola Nacional', 'Polígono'),
(84, 69, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Reserva Agrícola Nacional', 'Área Excluida da Reserva Agrícola Nacional', 'Polígono'),
(85, 70, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Obras de Aproveitamento Hidroagrícola', 'Perímetro Hidroagrícola', 'Polígono'),
(86, 71, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Oliveiras', 'Povoamento de Oliveiras', 'Polígono'),
(87, 72, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Sobreiros ou Azinheiras', 'Povoamento de Sobreiros ou Azinheiras', 'Polígono'),
(88, 73, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Sobreiros ou Azinheiras', 'Área onde tenham ocorrido Incêndios,Depreciação do Arvoredo ou Abates Ilegais', 'Polígono'),
(89, 74, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Azevinho', 'Povoamento de Azevinho', 'Polígono'),
(90, 75, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Regime Florestal', 'Regime Florestal Total', 'Polígono'),
(91, 76, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Regime Florestal', 'Regime Florestal Parcial', 'Polígono'),
(92, 77, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Povoamentos Florestais Percorridos por Incêndio', 'Povoamento Florestal Percorrido por Incêndio', 'Polígono'),
(93, 78, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Protecção ao Risco de Incêndio', 'Classe de Risco de Incêndio (alta ou muito alta)', 'Polígono'),
(94, 79, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Protecção ao Risco de Incêndio', 'Zona critica', 'Polígono'),
(95, 80, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Protecção ao Risco de Incêndio', 'Redes de Faixas de Gestão de Combustível (rede primária e secundária)', 'Linha, Polígono'),
(96, 81, NULL, NULL, NULL, 'Condicionantes', 'Recursos Agrícolas e Florestais', 'Árvores e Arvoredo de Interesse Público', 'Árvore ou Arvoredo de Interesse Público', 'Polígono, Ponto'),
(97, 148, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Reserva Ecológica Nacional', 'Reserva Ecológica Nacional', 'Polígono'),
(98, 82, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Reserva Ecológica Nacional', 'Área Excluida da Reserva Ecológica Nacional', 'Polígono'),
(99, 83, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Parque Nacional', 'Polígono'),
(100, 84, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Parque Natural', 'Polígono'),
(101, 85, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Reserva Natural', 'Polígono'),
(102, 86, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Monumento Natural', 'Polígono, Ponto'),
(103, 87, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Áreas Protegidas', 'Paisagem Protegida (de interesse regional ou local)', 'Polígono, Ponto'),
(104, 88, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Rede Natura 2000', 'Sítio da Lista Nacional', 'Polígono'),
(105, 89, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Rede Natura 2000', 'Zona Especial de Conservação', 'Polígono'),
(106, 90, NULL, NULL, NULL, 'Condicionantes', 'Recursos Ecológicos', 'Rede Natura 2000', 'Zona de Proteção Especial', 'Polígono'),
(107, 141, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Património Arqueológico', 'Parque Arqueológico', 'Polígono, Ponto'),
(108, 91, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Monumento Nacional', 'Polígono, Ponto'),
(109, 92, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Imóvel de Interesse Público', 'Polígono, Ponto'),
(110, 93, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Imóvel de Interesse Municipal', 'Polígono, Ponto'),
(111, 94, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Imóvel em Vias De Classificação', 'Polígono, Ponto'),
(112, 95, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Zona Geral de Proteção', 'Polígono'),
(113, 96, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Zona Especial de Proteção Provisória', 'Polígono'),
(114, 97, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Imóveis Classificados', 'Zona Especial de Proteção', 'Polígono'),
(115, 98, NULL, NULL, NULL, 'Condicionantes', 'Património Cultural', 'Edifícios Públicos e Outras Construções', 'Zona de Proteção de Edifício Público ou de Outra Construção', 'Polígono'),
(116, 99, NULL, NULL, NULL, 'Condicionantes', 'Equipamentos', 'Estabelecimentos Prisionais e Tutelares de Menores', 'Zona de Proteção de Estabelecimento Prisional ou Tutelar de Menores', 'Polígono'),
(117, 100, NULL, NULL, NULL, 'Condicionantes', 'Equipamentos', 'Instalações Aduaneiras', 'Área de Jurisdição de Alfândega', 'Polígono'),
(118, 101, NULL, NULL, NULL, 'Condicionantes', 'Equipamentos', 'Defesa Nacional', 'Zona de Servidão Militar', 'Polígono'),
(119, 43, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Abastecimento de Água', 'Conduta Adutora', 'Linha'),
(120, 102, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Abastecimento de Água', 'Zona de Servidão de Abastecimento de Água', 'Polígono'),
(121, 44, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais', 'Colector de Águas Residuais', 'Linha'),
(122, 103, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Drenagem de Águas Residuais', 'Zona de Servidão de Drenagem de Águas Residuais', 'Polígono'),
(123, 51, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Elétrica', 'Infraestrutura de Transporte de Energia Eletrica', 'Linha'),
(124, 104, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Elétrica', 'Zona de Servidão de Rede Elétrica', 'Polígono'),
(125, 52, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Gasodutos e Oleodutos', 'Gasoduto ou Oleoduto', 'Linha'),
(126, 137, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Gasodutos e Oleodutos', 'Infraestrutura Associada a Gasoduto ou Oleoduto', 'Ponto'),
(127, 105, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Gasodutos e Oleodutos', 'Zona de Servidão de Gasoduto ou Oleoduto', 'Polígono'),
(128, 106, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Principal', 'Linha'),
(129, 107, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Principal Autoestrada', 'Linha'),
(130, 108, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Complementar', 'Linha'),
(131, 109, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Itinerário Complementar Autoestrada', 'Linha'),
(132, 110, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Estrada Nacional', 'Linha'),
(133, 111, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Estrada Regional', 'Linha'),
(134, 143, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Estrada em Projeto', 'Linha'),
(135, 112, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Zona de Servidão de Estrada do Plano Rodoviário Nacional', 'Polígono'),
(136, 144, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Rodoviária Nacional e Regional', 'Zona de Respeito de Estrada do Plano Rodoviário Nacional', 'Polígono'),
(137, 113, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Estradas Nacionais Desclassificadas', 'Estradas Nacionais Desclassificadas', 'Linha'),
(138, 114, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Estradas Nacionais Desclassificadas', 'Zona de Servidão de Estrada Nacional Desclassificada', 'Polígono'),
(139, 115, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Estradas e Caminhos Municipais', 'Estrada Municipal', 'Linha'),
(140, 116, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Estradas e Caminhos Municipais', 'Caminho Municipal', 'Linha'),
(141, 117, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Estradas e Caminhos Municipais', 'Zona de Servidão de Estrada ou Caminho Municipal', 'Polígono'),
(142, 118, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Ferroviária', 'Zona de Servidão de Via-Férrea', 'Polígono'),
(143, 119, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Aeroportos e Aeródromos', 'Zona de Servidão Aeronaútica', 'Polígono'),
(144, 120, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Telecomunicações', 'Zona de Servidão Radioeléctrica', 'Polígono'),
(145, 121, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Faróis e Outros Sinais Marítimos', 'Farol ou Outro Sinal Marítimo', 'Ponto'),
(146, 122, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Faróis e Outros Sinais Marítimos', 'Zona de Servidão de Sinalização Maritima', 'Polígono'),
(147, 123, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Geodésica', 'Zona de Proteção da Rede Geodésica', 'Polígono'),
(148, 124, NULL, NULL, NULL, 'Condicionantes', 'Infraestruturas', 'Rede Geodésica', 'Marco Geodésico', 'Ponto'),
(149, 125, NULL, NULL, NULL, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Estabelecimento com Produtos Explosivos', 'Ponto'),
(150, 126, NULL, NULL, NULL, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Zona de Segurança de Estabelecimento com Produtos Explosivos', 'Polígono'),
(151, 127, NULL, NULL, NULL, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Estabelecimento com Substâncias Perigosas', 'Ponto'),
(152, 128, NULL, NULL, NULL, 'Condicionantes', 'Atividades Perigosas', 'Substâncias Perigosas', 'Zona de Segurança de Estabelecimento com Substâncias Perigosas', 'Polígono');


-- ==========================================================
-- Tabela: codigo_ine
-- ==========================================================

DROP TABLE IF EXISTS codigo_ine;

CREATE TABLE IF NOT EXISTS codigo_ine (
    fid        INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    municipio TEXT,
    dtcc      TEXT UNIQUE
);

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

-- ==========================================================
-- Tabela: gpkg_contents
-- ==========================================================

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

INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo', 'attributes', 'objeto_tipo', 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf
Tabela auxiliar "OBJETO_TIPO"', '2025-09-22T17:54:10.615Z', NULL, NULL, NULL, NULL, 0);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_ponto', 'features', 'objeto_ponto', 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf', '2025-09-24T06:42:51.288Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_linha', 'features', 'objeto_linha', 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf', '2025-09-24T06:42:51.294Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_poligono', 'features', 'objeto_poligono', 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf', '2025-09-24T06:42:51.298Z', NULL, NULL, NULL, NULL, 3763);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('ato_especifico', 'attributes', 'ato_especifico', 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf
Tabela secundária "ATO_ESPECIFICO"', '2025-09-22T18:03:21.110Z', NULL, NULL, NULL, NULL, 0);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('codigo_ine', 'attributes', 'codigo_ine', 'Tipo de tabela: Base. Descrição: Lista de municípios portugueses com seus respectivos códigos DTCC (Divisão Territorial de Classificação Cartográfica).', '2025-08-12T10:42:53.786Z', NULL, NULL, NULL, NULL, 0);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objetos_pt', 'features', 'objetos_pt', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objetos_ln', 'features', 'objetos_ln', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objetos_pl', 'features', 'objetos_pl', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_ord', 'attributes', 'objeto_tipo_ord', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_cond', 'attributes', 'objeto_tipo_cond', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_planta', 'attributes', 'objeto_planta', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_cond_pt', 'attributes', 'objeto_tipo_cond_pt', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_cond_ln', 'attributes', 'objeto_tipo_cond_ln', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_cond_pl', 'attributes', 'objeto_tipo_cond_pl', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_ord_pt', 'attributes', 'objeto_tipo_ord_pt', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_ord_ln', 'attributes', 'objeto_tipo_ord_ln', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('objeto_tipo_ord_pl', 'attributes', 'objeto_tipo_ord_pl', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);
INSERT INTO gpkg_contents (table_name, data_type, identifier, description, last_change, min_x, min_y, max_x, max_y, srs_id) VALUES ('atribuir_concelho', 'attributes', 'atribuir_concelho', NULL, '2025-08-15T15:00:13.603Z', NULL, NULL, NULL, NULL, NULL);

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

INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_tipo', 'codigo', NULL, NULL, 'CODIGO – campo do tipo número inteiro que correspondendo ao código utilizado no catálogo de objetos (Anexo I) para permitir a sua articulação com o catálogo de simbologia (Anexo III).', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_tipo', 'planta', NULL, NULL, 'PLANTA – campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_tipo', 'tema', NULL, NULL, 'Os campos “TEMA”, “SUBTEMA” e “DESIGNACAO”, do tipo texto, devem ser preenchidos conforme o exposto no Anexo I;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_tipo', 'subtema', NULL, NULL, 'Os campos “TEMA”, “SUBTEMA” e “DESIGNACAO”, do tipo texto, devem ser preenchidos conforme o exposto no Anexo I;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_tipo', 'designacao', NULL, NULL, 'Os campos “TEMA”, “SUBTEMA” e “DESIGNACAO”, do tipo texto, devem ser preenchidos conforme o exposto no Anexo I;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'objecto_uuid', NULL, NULL, 'IDENTIFICA – campo do tipo texto que identifica inequivocamente cada registo em qualquer tabela gráfica, devendo ser único e não podendo ser nulo. É chave primária das tabelas gráficas e chave estrangeira para a tabela secundária “ATO_ESPECIFICO”. Deve ser utilizado preferencialmente um Identificador Global Exclusivo (GUID - Globally Unique Identifier) para cada registo. A geração de GUID é possível obter, por exemplo, no seguinte endereço: https://www.guidgenerator.com/;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'codigo', NULL, NULL, 'ESPECIFICA – campo do tipo texto, utilizável quando se desagrega ou especifica o objeto. Aplica-se às seguintes situações:
a) Aos objetos cuja desagregação é opcional, que podem ser:
i) Objetos do tema “Classificação e Qualificação do Solo”, de modo a desagregar as categorias de solo em subcategorias;
ii) Objetos do tema “Sistemas Estruturantes”, de modo a identificar a sua especificidade;
iii) Objetos da planta de condicionantes que se pretendam especificar individualmente, como por exemplo, os imóveis classificados, as áreas protegidas ou as captações de água.
b) Aos objetos da planta de ordenamento cuja especificação é obrigatória, que são
i) Objetos do tema “Programação da Execução do Plano” em que é obrigatória a identificação das UOPG e UE estabelecidas no plano;
ii) Objetos dos temas “Programas territoriais” e “Planos territoriais” em que é obrigatória a identificação das áreas do PDM abrangidas por programas setoriais, especiais ou intermunicipais e por planos territoriais de âmbito intermunicipal ou municipal, em vigor;
iii) Objetos do tema “Áreas de Intervenção de outros Instrumentos ou Entidades” bem como, AUGI e ARU representadas na planta de ordenamento.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'legenda', NULL, NULL, 'Nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'etiqueta', NULL, NULL, 'ETIQUETA - campo do tipo texto, permite introduzir na simbologia uma etiqueta com uma sigla que identifique na planta o objeto em questão, indicando-se no título 3.1.2 (parágrafos 3.1.2.6 e 3.1.2.7) um exemplo da utilização deste campo.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'fonte_inf', NULL, NULL, 'FONTE_INF - campo do tipo texto, para indicação da fonte/entidade de origem da informação representada (Por exemplo na planta de condicionantes, o objeto pode ter sido fornecido pela entidade que tutela a respetiva servidão).', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'data_inf', NULL, NULL, 'DATA_INF – campo do tipo data, para indicação da data a que se reporta o objeto ou a data em que a câmara municipal obteve o objeto da fonte referida no campo FONTE_INF.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_ponto', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'objeto_uuid', NULL, NULL, 'IDENTIFICA – campo do tipo texto que identifica inequivocamente cada registo em qualquer tabela gráfica, devendo ser único e não podendo ser nulo. É chave primária das tabelas gráficas e chave estrangeira para a tabela secundária “ATO_ESPECIFICO”. Deve ser utilizado preferencialmente um Identificador Global Exclusivo (GUID - Globally Unique Identifier) para cada registo. A geração de GUID é possível obter, por exemplo, no seguinte endereço: https://www.guidgenerator.com/;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'codigo', NULL, NULL, 'ESPECIFICA – campo do tipo texto, utilizável quando se desagrega ou especifica o objeto. Aplica-se às seguintes situações:
a) Aos objetos cuja desagregação é opcional, que podem ser:
i) Objetos do tema “Classificação e Qualificação do Solo”, de modo a desagregar as categorias de solo em subcategorias;
ii) Objetos do tema “Sistemas Estruturantes”, de modo a identificar a sua especificidade;
iii) Objetos da planta de condicionantes que se pretendam especificar individualmente, como por exemplo, os imóveis classificados, as áreas protegidas ou as captações de água.
b) Aos objetos da planta de ordenamento cuja especificação é obrigatória, que são
i) Objetos do tema “Programação da Execução do Plano” em que é obrigatória a identificação das UOPG e UE estabelecidas no plano;
ii) Objetos dos temas “Programas territoriais” e “Planos territoriais” em que é obrigatória a identificação das áreas do PDM abrangidas por programas setoriais, especiais ou intermunicipais e por planos territoriais de âmbito intermunicipal ou municipal, em vigor;
iii) Objetos do tema “Áreas de Intervenção de outros Instrumentos ou Entidades” bem como, AUGI e ARU representadas na planta de ordenamento.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'legenda', NULL, NULL, 'Nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'etiqueta', NULL, NULL, 'ETIQUETA - campo do tipo texto, permite introduzir na simbologia uma etiqueta com uma sigla que identifique na planta o objeto em questão, indicando-se no título 3.1.2 (parágrafos 3.1.2.6 e 3.1.2.7) um exemplo da utilização deste campo.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'fonte_inf', NULL, NULL, 'FONTE_INF - campo do tipo texto, para indicação da fonte/entidade de origem da informação representada (Por exemplo na planta de condicionantes, o objeto pode ter sido fornecido pela entidade que tutela a respetiva servidão).', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'data_inf', NULL, NULL, 'DATA_INF – campo do tipo data, para indicação da data a que se reporta o objeto ou a data em que a câmara municipal obteve o objeto da fonte referida no campo FONTE_INF.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'medida', NULL, NULL, 'MEDIDA – campo de tipo número decimal que se destina a registar a área dos polígonos em hectares (ha) ou o comprimento das linhas em quilómetros (km).
NOVO - Cálculo automático', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_linha', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'objeto_uuid', NULL, NULL, 'IDENTIFICA – campo do tipo texto que identifica inequivocamente cada registo em qualquer tabela gráfica, devendo ser único e não podendo ser nulo. É chave primária das tabelas gráficas e chave estrangeira para a tabela secundária “ATO_ESPECIFICO”. Deve ser utilizado preferencialmente um Identificador Global Exclusivo (GUID - Globally Unique Identifier) para cada registo. A geração de GUID é possível obter, por exemplo, no seguinte endereço: https://www.guidgenerator.com/;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'codigo', NULL, NULL, 'ESPECIFICA – campo do tipo texto, utilizável quando se desagrega ou especifica o objeto. Aplica-se às seguintes situações:
a) Aos objetos cuja desagregação é opcional, que podem ser:
i) Objetos do tema “Classificação e Qualificação do Solo”, de modo a desagregar as categorias de solo em subcategorias;
ii) Objetos do tema “Sistemas Estruturantes”, de modo a identificar a sua especificidade;
iii) Objetos da planta de condicionantes que se pretendam especificar individualmente, como por exemplo, os imóveis classificados, as áreas protegidas ou as captações de água.
b) Aos objetos da planta de ordenamento cuja especificação é obrigatória, que são
i) Objetos do tema “Programação da Execução do Plano” em que é obrigatória a identificação das UOPG e UE estabelecidas no plano;
ii) Objetos dos temas “Programas territoriais” e “Planos territoriais” em que é obrigatória a identificação das áreas do PDM abrangidas por programas setoriais, especiais ou intermunicipais e por planos territoriais de âmbito intermunicipal ou municipal, em vigor;
iii) Objetos do tema “Áreas de Intervenção de outros Instrumentos ou Entidades” bem como, AUGI e ARU representadas na planta de ordenamento.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'etiqueta', NULL, NULL, 'ETIQUETA - campo do tipo texto, permite introduzir na simbologia uma etiqueta com uma sigla que identifique na planta o objeto em questão, indicando-se no título 3.1.2 (parágrafos 3.1.2.6 e 3.1.2.7) um exemplo da utilização deste campo.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'fonte_inf', NULL, NULL, 'FONTE_INF - campo do tipo texto, para indicação da fonte/entidade de origem da informação representada (Por exemplo na planta de condicionantes, o objeto pode ter sido fornecido pela entidade que tutela a respetiva servidão).', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'data_inf', NULL, NULL, 'DATA_INF – campo do tipo data, para indicação da data a que se reporta o objeto ou a data em que a câmara municipal obteve o objeto da fonte referida no campo FONTE_INF.', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'medida', NULL, NULL, 'MEDIDA – campo de tipo número decimal que se destina a registar a área dos polígonos em hectares (ha) ou o comprimento das linhas em quilómetros (km).', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('objeto_poligono', 'dtcc', 'DTCC', NULL, 'DTCC - Código para identificar o município a que pertence cada elemento/objeto', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'num_dr', NULL, NULL, 'NUM_DR – campo do tipo texto que indica o número do Diário da República onde foi publicado o ato específico que constitui a servidão ou restrição de utilidade pública;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'tipo_ato', NULL, NULL, 'TIPO_ATO – campo do tipo texto que indica o tipo de ato que constitui a servidão ou restrição de utilidade pública. Este campo tem como domínio do atributo as seguintes opções: “Lei”; “Decreto-Lei”; “Dec-Reg” caso se trate de Decreto-Regulamentar; “Decreto”; “RCM” caso se trate de Resolução do Conselho de Ministros”; “Portaria”; “Aviso”; “Decisao” caso se trate de Decisão; “Declaracao” caso se trate de Declaração; “Deliberacao” caso se trate de Deliberação; “Despacho”; “Desp-Conj” caso se trate de Despacho-Conjunto; e “Regulamento”;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'num_ato', NULL, NULL, 'NUM_ATO – campo do tipo texto que indica o número do ato específico que constitui a servidão ou restrição de utilidade pública;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'data_ato', NULL, NULL, 'DATA – campo do tipo data que indica a data do ato específico que constitui a servidão ou restrição de utilidade pública;', NULL, NULL);
INSERT INTO gpkg_data_columns (table_name, column_name, name, title, description, mime_type, constraint_name) VALUES ('ato_especifico', 'n_deposito', NULL, NULL, 'OBSERV – campo do tipo texto, de preenchimento não obrigatório, destinado à indicação de outras observações.', NULL, NULL);


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

INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('objeto_linha', 'geom', 'MULTILINESTRING', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('objeto_ponto', 'geom', 'MULTIPOINT', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('objeto_poligono', 'geom', 'MULTIPOLYGON', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('objetos_pt', 'geom', 'MULTIPOINT', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('objetos_ln', 'geom', 'MULTILINESTRING', 3763, 0, 0);
INSERT INTO gpkg_geometry_columns (table_name, column_name, geometry_type_name, srs_id, z, m) VALUES ('objetos_pl', 'geom', 'MULTIPOLYGON', 3763, 0, 0);


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


-- Table: gpkg_ogr_contents
DROP TABLE IF EXISTS gpkg_ogr_contents;

CREATE TABLE IF NOT EXISTS gpkg_ogr_contents (
    table_name    TEXT    NOT NULL
                          PRIMARY KEY,
    feature_count INTEGER DEFAULT NULL
);

INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('objeto_tipo', 157);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('objeto_ponto', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('objeto_linha', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('objeto_poligono', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('ato_especifico', 0);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('codigo_ine', 278);
INSERT INTO gpkg_ogr_contents (table_name, feature_count) VALUES ('objeto_planta', 2);

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


-- Table: metadata
DROP TABLE IF EXISTS metadata;

CREATE TABLE IF NOT EXISTS metadata (
    key TEXT PRIMARY KEY,
    value TEXT
);

COMMIT TRANSACTION;
PRAGMA foreign_keys = on;