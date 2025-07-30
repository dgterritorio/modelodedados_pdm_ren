--
-- File generated with SQLiteStudio v3.4.17
--
-- Text encoding used: UTF-8
--
PRAGMA foreign_keys = off;
BEGIN TRANSACTION;

-- Table: CATALOGO
CREATE TABLE CATALOGO (
    fid        INTEGER PRIMARY KEY AUTOINCREMENT
                       NOT NULL,
    tema       TEXT,
    subtema    TEXT,
    nomeobjeto TEXT,
    codobje    TEXT,
    legenda    TEXT
);

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         1,
                         'Áreas de proteção do litoral',
                         'Faixa marítima de proteção costeira',
                         'Faixa marítima de proteção costeira',
                         '01',
                         'Faixa marítima de proteção costeira'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         2,
                         'Áreas de proteção do litoral',
                         'Praias',
                         'Praias',
                         '02',
                         'Praias'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         3,
                         'Áreas de proteção do litoral',
                         'Barreiras detríticas',
                         'Restingas',
                         '03',
                         'Barreiras detríticas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         4,
                         'Áreas de proteção do litoral',
                         'Barreiras detríticas',
                         'Barreiras soldadas',
                         '04',
                         'Barreiras detríticas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         5,
                         'Áreas de proteção do litoral',
                         'Barreiras detríticas',
                         'Ilhas-Barreira',
                         '05',
                         'Barreiras detríticas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         6,
                         'Áreas de proteção do litoral',
                         'Tômbolos',
                         'Tômbolos',
                         '06',
                         'Tômbolos'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         7,
                         'Áreas de proteção do litoral',
                         'Sapais',
                         'Sapais',
                         '07',
                         'Sapais'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         8,
                         'Áreas de proteção do litoral',
                         'Ilhéus e rochedos emersos no mar',
                         'Ilhéus',
                         '08',
                         'Ilhéus e rochedos emersos no mar'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         9,
                         'Áreas de proteção do litoral',
                         'Ilhéus e rochedos emersos no mar',
                         'Rochedos emersos no mar',
                         '09',
                         'Ilhéus e rochedos emersos no mar'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         10,
                         'Áreas de proteção do litoral',
                         'Dunas costeiras e dunas fósseis',
                         'Dunas costeiras litorais',
                         '10',
                         'Dunas costeiras litorais'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         11,
                         'Áreas de proteção do litoral',
                         'Dunas costeiras e dunas fósseis',
                         'Dunas costeiras interiores',
                         '11',
                         'Dunas costeiras interiores'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         12,
                         'Áreas de proteção do litoral',
                         'Dunas costeiras e dunas fósseis',
                         'Dunas fósseis',
                         '12',
                         'Dunas fósseis'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         13,
                         'Áreas de proteção do litoral',
                         'Arribas e respetivas  faixas de proteção',
                         'Arribas',
                         '13',
                         'Arribas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         14,
                         'Áreas de proteção do litoral',
                         'Arribas e respetivas  faixas de proteção',
                         'Faixa de proteção de arribas a  partir do rebordo superior',
                         '14',
                         'Faixas de proteção das arribas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         15,
                         'Áreas de proteção do litoral',
                         'Arribas e respetivas  faixas de proteção',
                         'Faixa de proteção de arribas a  partir da base da arriba',
                         '15',
                         'Faixas de proteção das arribas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         16,
                         'Áreas de proteção do litoral',
                         'Faixa terrestre de proteção costeira',
                         'Faixa terrestre de proteção costeira',
                         '16',
                         'Faixa terrestre de proteção costeira'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         17,
                         'Áreas de proteção do litoral',
                         'Faixa terrestre de proteção costeira',
                         'Águas do mar – Margem',
                         '17',
                         'Águas do mar – Margem'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         18,
                         'Áreas de proteção do litoral',
                         'Águas de transição e  respetivos leitos, margens e faixas de  proteção',
                         'Águas de transição – Leito',
                         '18',
                         'Águas de transição – Leito'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         19,
                         'Áreas de proteção do litoral',
                         'Águas de transição e  respetivos leitos, margens e faixas de  proteção',
                         'Águas de transição – Margem',
                         '19',
                         'Águas de transição – Margem'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         20,
                         'Áreas de proteção do litoral',
                         'Águas de transição e  respetivos leitos, margens e faixas de  proteção',
                         'Águas de transição – Faixa de  proteção',
                         '20',
                         'Águas de transição – Faixa  de proteção'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         21,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Cursos de água e  respetivos leitos e  margens',
                         'Cursos de água – Leito',
                         '21',
                         'Cursos de água – Leito'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         22,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Cursos de água e  respetivos leitos e  margens',
                         'Cursos de água – Leito canalizado',
                         '22',
                         'Cursos de água – Leito canalizado'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         23,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Cursos de água e  respetivos leitos e  margens',
                         'Cursos de água – Margem',
                         '23',
                         'Cursos de água – Margem'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         24,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Lagoas e lagos e respetivos leitos, margens e faixas de  proteção',
                         'Lagoas e lagos – Leito',
                         '24',
                         'Lagoas e lagos – Leito'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         25,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Lagoas e lagos e respetivos leitos, margens e faixas de  proteção',
                         'Lagoas e lagos – Margem',
                         '25',
                         'Lagoas e lagos – Margem'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         26,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Lagoas e lagos e respetivos leitos, margens e faixas de  proteção',
                         'Lagoas e lagos – Faixa de proteção',
                         '26',
                         'Lagoas e lagos – Faixa de  proteção'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         27,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Albufeiras que contribuam para a  conectividade e coerência ecológica  da REN, bem como  os respetivos leitos,  margens e faixas de  proteção',
                         'Albufeiras – Leito',
                         '27',
                         'Albufeiras – Leito'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         28,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Albufeiras que contribuam para a  conectividade e coerência ecológica  da REN, bem como  os respetivos leitos,  margens e faixas de  proteção',
                         'Albufeiras – Margem',
                         '28',
                         'Albufeiras – Margem'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         29,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Albufeiras que contribuam para a  conectividade e coerência ecológica  da REN, bem como  os respetivos leitos,  margens e faixas de  proteção',
                         'Albufeiras – Faixa de proteção',
                         '29',
                         'Albufeiras – Faixa de proteção'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         30,
                         'Áreas relevantes para a sustentabilida do ciclo hidrológico terrestre',
                         'Áreas estratégicas de  infiltração, proteção  e recarga de aquíferos',
                         'Áreas estratégicas de infiltração,  proteção e recarga de aquíferos',
                         '30',
                         'Áreas estratégicas de infiltração, proteção e recarga de aquíferos'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         31,
                         'Áreas de prevenção de  riscos naturais',
                         'Zonas adjacentes',
                         'Zonas adjacentes',
                         '31',
                         'Zonas adjacentes'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         32,
                         'Áreas de prevenção de  riscos naturais',
                         'Zonas ameaçadas pelo mar',
                         'Zonas ameaçadas pelo mar',
                         '32',
                         'Zonas ameaçadas pelo mar'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         33,
                         'Áreas de prevenção de  riscos naturais',
                         'Zonas ameaçadas pelas cheias',
                         'Zonas ameaçadas pelas cheias',
                         '33',
                         'Zonas ameaçadas pelas  cheias'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         34,
                         'Áreas de prevenção de  riscos naturais',
                         'Áreas de elevado risco de erosão hídrica do solo',
                         'Áreas de elevado risco de erosão  hídrica do solo',
                         '34',
                         'Áreas de elevado risco de  erosão hídrica do solo'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         35,
                         'Áreas de prevenção de  riscos naturais',
                         'Áreas de instabilidade de vertentes',
                         'Áreas de instabilidade de vertentes',
                         '35',
                         'Áreas de instabilidade de  vertentes'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         36,
                         'Áreas de prevenção de  riscos naturais',
                         'Áreas de instabilidade de vertentes',
                         'Escarpas',
                         '36',
                         'Escarpas'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         37,
                         'Áreas de exclusão',
                         'Exclusão por compromisso – C',
                         'Exclusão por compromisso – C',
                         '37',
                         'Exclusão por compromisso  – C'
                     );

INSERT INTO CATALOGO (
                         fid,
                         tema,
                         subtema,
                         nomeobjeto,
                         codobje,
                         legenda
                     )
                     VALUES (
                         38,
                         'Áreas de exclusão',
                         'Exclusão para a satisfação de carências – E',
                         'Exclusão para a satisfação de  carências – E',
                         '38',
                         'Exclusão para a satisfação  de carências – E'
                     );


-- Table: DTCC_EXCL_P
CREATE TABLE DTCC_EXCL_P (
    fid        INTEGER    PRIMARY KEY AUTOINCREMENT
                          NOT NULL,
    geom       POLYGON,
    Exclusao   TEXT (5),
    CodObje    TEXT (3),
    Area_m2    REAL,
    Fundamento TEXT,
    FimDest    TEXT (200),
    CodMun     TEXT (4) 
);


-- Table: DTCC_TIP_L
CREATE TABLE DTCC_TIP_L (
    fid     INTEGER    PRIMARY KEY AUTOINCREMENT
                       NOT NULL,
    geom    LINESTRING,
    CodObje TEXT (3),
    Legenda TEXT (120),
    Comp_m  REAL,
    CodMun  TEXT (4) 
);


-- Table: DTCC_TIP_P
CREATE TABLE DTCC_TIP_P (
    fid     INTEGER  PRIMARY KEY AUTOINCREMENT
                     NOT NULL,
    geom    POLYGON,
    CodObje TEXT (3),
    Area_m2 REAL,
    CodMun  TEXT (4) 
);


-- Table: gpkg_contents
CREATE TABLE gpkg_contents (
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

INSERT INTO gpkg_contents (
                              table_name,
                              data_type,
                              identifier,
                              description,
                              last_change,
                              min_x,
                              min_y,
                              max_x,
                              max_y,
                              srs_id
                          )
                          VALUES (
                              'DTCC_TIP_P',
                              'features',
                              'DTCC_TIP_P',
                              '',
                              '2025-07-30T15:12:28.559Z',
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              3763
                          );

INSERT INTO gpkg_contents (
                              table_name,
                              data_type,
                              identifier,
                              description,
                              last_change,
                              min_x,
                              min_y,
                              max_x,
                              max_y,
                              srs_id
                          )
                          VALUES (
                              'DTCC_TIP_L',
                              'features',
                              'DTCC_TIP_L',
                              '',
                              '2025-07-30T15:13:16.473Z',
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              3763
                          );

INSERT INTO gpkg_contents (
                              table_name,
                              data_type,
                              identifier,
                              description,
                              last_change,
                              min_x,
                              min_y,
                              max_x,
                              max_y,
                              srs_id
                          )
                          VALUES (
                              'DTCC_EXCL_P',
                              'features',
                              'DTCC_EXCL_P',
                              '',
                              '2025-07-30T15:11:49.529Z',
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              3763
                          );

INSERT INTO gpkg_contents (
                              table_name,
                              data_type,
                              identifier,
                              description,
                              last_change,
                              min_x,
                              min_y,
                              max_x,
                              max_y,
                              srs_id
                          )
                          VALUES (
                              'v_DTCC_TIP_P',
                              'features',
                              'v_DTCC_TIP_P',
                              '',
                              '2025-07-30T15:12:43.499Z',
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              3763
                          );

INSERT INTO gpkg_contents (
                              table_name,
                              data_type,
                              identifier,
                              description,
                              last_change,
                              min_x,
                              min_y,
                              max_x,
                              max_y,
                              srs_id
                          )
                          VALUES (
                              'CATALOGO',
                              'attributes',
                              'CATALOGO',
                              '',
                              '2025-04-07T18:53:04.971Z',
                              NULL,
                              NULL,
                              NULL,
                              NULL,
                              0
                          );


-- Table: gpkg_extensions
CREATE TABLE gpkg_extensions (
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

INSERT INTO gpkg_extensions (
                                table_name,
                                column_name,
                                extension_name,
                                definition,
                                scope
                            )
                            VALUES (
                                'gpkg_metadata',
                                NULL,
                                'gpkg_metadata',
                                'http://www.geopackage.org/spec120/#extension_metadata',
                                'read-write'
                            );

INSERT INTO gpkg_extensions (
                                table_name,
                                column_name,
                                extension_name,
                                definition,
                                scope
                            )
                            VALUES (
                                'gpkg_metadata_reference',
                                NULL,
                                'gpkg_metadata',
                                'http://www.geopackage.org/spec120/#extension_metadata',
                                'read-write'
                            );

INSERT INTO gpkg_extensions (
                                table_name,
                                column_name,
                                extension_name,
                                definition,
                                scope
                            )
                            VALUES (
                                'DTCC_TIP_P',
                                'geom',
                                'gpkg_rtree_index',
                                'http://www.geopackage.org/spec120/#extension_rtree',
                                'write-only'
                            );

INSERT INTO gpkg_extensions (
                                table_name,
                                column_name,
                                extension_name,
                                definition,
                                scope
                            )
                            VALUES (
                                'DTCC_TIP_L',
                                'geom',
                                'gpkg_rtree_index',
                                'http://www.geopackage.org/spec120/#extension_rtree',
                                'write-only'
                            );

INSERT INTO gpkg_extensions (
                                table_name,
                                column_name,
                                extension_name,
                                definition,
                                scope
                            )
                            VALUES (
                                'DTCC_EXCL_P',
                                'geom',
                                'gpkg_rtree_index',
                                'http://www.geopackage.org/spec120/#extension_rtree',
                                'write-only'
                            );

INSERT INTO gpkg_extensions (
                                table_name,
                                column_name,
                                extension_name,
                                definition,
                                scope
                            )
                            VALUES (
                                'v_DTCC_TIP_P',
                                'geom',
                                'gpkg_rtree_index',
                                'http://www.geopackage.org/spec120/#extension_rtree',
                                'write-only'
                            );


-- Table: gpkg_geometry_columns
CREATE TABLE gpkg_geometry_columns (
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

INSERT INTO gpkg_geometry_columns (
                                      table_name,
                                      column_name,
                                      geometry_type_name,
                                      srs_id,
                                      z,
                                      m
                                  )
                                  VALUES (
                                      'DTCC_TIP_P',
                                      'geom',
                                      'POLYGON',
                                      3763,
                                      0,
                                      0
                                  );

INSERT INTO gpkg_geometry_columns (
                                      table_name,
                                      column_name,
                                      geometry_type_name,
                                      srs_id,
                                      z,
                                      m
                                  )
                                  VALUES (
                                      'DTCC_TIP_L',
                                      'geom',
                                      'LINESTRING',
                                      3763,
                                      1,
                                      0
                                  );

INSERT INTO gpkg_geometry_columns (
                                      table_name,
                                      column_name,
                                      geometry_type_name,
                                      srs_id,
                                      z,
                                      m
                                  )
                                  VALUES (
                                      'DTCC_EXCL_P',
                                      'geom',
                                      'POLYGON',
                                      3763,
                                      0,
                                      0
                                  );

INSERT INTO gpkg_geometry_columns (
                                      table_name,
                                      column_name,
                                      geometry_type_name,
                                      srs_id,
                                      z,
                                      m
                                  )
                                  VALUES (
                                      'v_DTCC_TIP_P',
                                      'geom',
                                      'POLYGON',
                                      3763,
                                      0,
                                      0
                                  );


-- Table: gpkg_metadata
CREATE TABLE gpkg_metadata (
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

INSERT INTO gpkg_metadata (
                              id,
                              md_scope,
                              md_standard_uri,
                              mime_type,
                              metadata
                          )
                          VALUES (
                              1,
                              'dataset',
                              'http://gdal.org',
                              'text/xml',
                              '<GDALMultiDomainMetadata>
  <Metadata>
    <MDI key="GPKG_METADATA_ITEM_1">&lt;!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''&gt;
&lt;qgis version="3.22.4-Bia?owie?a"&gt;
  &lt;identifier&gt;&lt;/identifier&gt;
  &lt;parentidentifier&gt;&lt;/parentidentifier&gt;
  &lt;language&gt;&lt;/language&gt;
  &lt;type&gt;&lt;/type&gt;
  &lt;title&gt;&lt;/title&gt;
  &lt;abstract&gt;&lt;/abstract&gt;
  &lt;links/&gt;
  &lt;fees&gt;&lt;/fees&gt;
  &lt;encoding&gt;&lt;/encoding&gt;
  &lt;crs&gt;
    &lt;spatialrefsys&gt;
      &lt;wkt&gt;&lt;/wkt&gt;
      &lt;proj4&gt;&lt;/proj4&gt;
      &lt;srsid&gt;0&lt;/srsid&gt;
      &lt;srid&gt;0&lt;/srid&gt;
      &lt;authid&gt;&lt;/authid&gt;
      &lt;description&gt;&lt;/description&gt;
      &lt;projectionacronym&gt;&lt;/projectionacronym&gt;
      &lt;ellipsoidacronym&gt;&lt;/ellipsoidacronym&gt;
      &lt;geographicflag&gt;false&lt;/geographicflag&gt;
    &lt;/spatialrefsys&gt;
  &lt;/crs&gt;
  &lt;extent/&gt;
&lt;/qgis&gt;
</MDI>
  </Metadata>
</GDALMultiDomainMetadata>
'
                          );

INSERT INTO gpkg_metadata (
                              id,
                              md_scope,
                              md_standard_uri,
                              mime_type,
                              metadata
                          )
                          VALUES (
                              2,
                              'dataset',
                              'http://gdal.org',
                              'text/xml',
                              '<GDALMultiDomainMetadata>
  <Metadata>
    <MDI key="GPKG_METADATA_ITEM_1">&lt;!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''&gt;
&lt;qgis version="3.22.4-Bia?owie?a"&gt;
  &lt;identifier&gt;&lt;/identifier&gt;
  &lt;parentidentifier&gt;&lt;/parentidentifier&gt;
  &lt;language&gt;&lt;/language&gt;
  &lt;type&gt;&lt;/type&gt;
  &lt;title&gt;&lt;/title&gt;
  &lt;abstract&gt;&lt;/abstract&gt;
  &lt;links/&gt;
  &lt;fees&gt;&lt;/fees&gt;
  &lt;encoding&gt;&lt;/encoding&gt;
  &lt;crs&gt;
    &lt;spatialrefsys&gt;
      &lt;wkt&gt;&lt;/wkt&gt;
      &lt;proj4&gt;&lt;/proj4&gt;
      &lt;srsid&gt;0&lt;/srsid&gt;
      &lt;srid&gt;0&lt;/srid&gt;
      &lt;authid&gt;&lt;/authid&gt;
      &lt;description&gt;&lt;/description&gt;
      &lt;projectionacronym&gt;&lt;/projectionacronym&gt;
      &lt;ellipsoidacronym&gt;&lt;/ellipsoidacronym&gt;
      &lt;geographicflag&gt;false&lt;/geographicflag&gt;
    &lt;/spatialrefsys&gt;
  &lt;/crs&gt;
  &lt;extent/&gt;
&lt;/qgis&gt;
</MDI>
  </Metadata>
</GDALMultiDomainMetadata>
'
                          );

INSERT INTO gpkg_metadata (
                              id,
                              md_scope,
                              md_standard_uri,
                              mime_type,
                              metadata
                          )
                          VALUES (
                              3,
                              'dataset',
                              'http://gdal.org',
                              'text/xml',
                              '<GDALMultiDomainMetadata>
  <Metadata>
    <MDI key="GPKG_METADATA_ITEM_1">&lt;!DOCTYPE qgis PUBLIC ''http://mrcc.com/qgis.dtd'' ''SYSTEM''&gt;
&lt;qgis version="3.22.4-Bia?owie?a"&gt;
  &lt;identifier&gt;&lt;/identifier&gt;
  &lt;parentidentifier&gt;&lt;/parentidentifier&gt;
  &lt;language&gt;&lt;/language&gt;
  &lt;type&gt;&lt;/type&gt;
  &lt;title&gt;&lt;/title&gt;
  &lt;abstract&gt;&lt;/abstract&gt;
  &lt;links/&gt;
  &lt;fees&gt;&lt;/fees&gt;
  &lt;encoding&gt;&lt;/encoding&gt;
  &lt;crs&gt;
    &lt;spatialrefsys&gt;
      &lt;wkt&gt;&lt;/wkt&gt;
      &lt;proj4&gt;&lt;/proj4&gt;
      &lt;srsid&gt;0&lt;/srsid&gt;
      &lt;srid&gt;0&lt;/srid&gt;
      &lt;authid&gt;&lt;/authid&gt;
      &lt;description&gt;&lt;/description&gt;
      &lt;projectionacronym&gt;&lt;/projectionacronym&gt;
      &lt;ellipsoidacronym&gt;&lt;/ellipsoidacronym&gt;
      &lt;geographicflag&gt;false&lt;/geographicflag&gt;
    &lt;/spatialrefsys&gt;
  &lt;/crs&gt;
  &lt;extent/&gt;
&lt;/qgis&gt;
</MDI>
  </Metadata>
</GDALMultiDomainMetadata>
'
                          );


-- Table: gpkg_metadata_reference
CREATE TABLE gpkg_metadata_reference (
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

INSERT INTO gpkg_metadata_reference (
                                        reference_scope,
                                        table_name,
                                        column_name,
                                        row_id_value,
                                        timestamp,
                                        md_file_id,
                                        md_parent_id
                                    )
                                    VALUES (
                                        'table',
                                        'DTCC_TIP_P',
                                        NULL,
                                        NULL,
                                        '2025-04-07T18:53:04.918Z',
                                        1,
                                        NULL
                                    );

INSERT INTO gpkg_metadata_reference (
                                        reference_scope,
                                        table_name,
                                        column_name,
                                        row_id_value,
                                        timestamp,
                                        md_file_id,
                                        md_parent_id
                                    )
                                    VALUES (
                                        'table',
                                        'DTCC_TIP_L',
                                        NULL,
                                        NULL,
                                        '2025-04-07T18:53:04.918Z',
                                        2,
                                        NULL
                                    );

INSERT INTO gpkg_metadata_reference (
                                        reference_scope,
                                        table_name,
                                        column_name,
                                        row_id_value,
                                        timestamp,
                                        md_file_id,
                                        md_parent_id
                                    )
                                    VALUES (
                                        'table',
                                        'DTCC_EXCL_P',
                                        NULL,
                                        NULL,
                                        '2025-04-07T18:53:04.918Z',
                                        3,
                                        NULL
                                    );


-- Table: gpkg_ogr_contents
CREATE TABLE gpkg_ogr_contents (
    table_name    TEXT    NOT NULL
                          PRIMARY KEY,
    feature_count INTEGER DEFAULT NULL
);

INSERT INTO gpkg_ogr_contents (
                                  table_name,
                                  feature_count
                              )
                              VALUES (
                                  'DTCC_TIP_P',
                                  0
                              );

INSERT INTO gpkg_ogr_contents (
                                  table_name,
                                  feature_count
                              )
                              VALUES (
                                  'DTCC_TIP_L',
                                  0
                              );

INSERT INTO gpkg_ogr_contents (
                                  table_name,
                                  feature_count
                              )
                              VALUES (
                                  'DTCC_EXCL_P',
                                  0
                              );

INSERT INTO gpkg_ogr_contents (
                                  table_name,
                                  feature_count
                              )
                              VALUES (
                                  'v_DTCC_TIP_P',
                                  0
                              );

INSERT INTO gpkg_ogr_contents (
                                  table_name,
                                  feature_count
                              )
                              VALUES (
                                  'CATALOGO',
                                  38
                              );


-- Table: gpkg_spatial_ref_sys
CREATE TABLE gpkg_spatial_ref_sys (
    srs_name                 TEXT    NOT NULL,
    srs_id                   INTEGER NOT NULL
                                     PRIMARY KEY,
    organization             TEXT    NOT NULL,
    organization_coordsys_id INTEGER NOT NULL,
    definition               TEXT    NOT NULL,
    description              TEXT
);

INSERT INTO gpkg_spatial_ref_sys (
                                     srs_name,
                                     srs_id,
                                     organization,
                                     organization_coordsys_id,
                                     definition,
                                     description
                                 )
                                 VALUES (
                                     'Undefined Cartesian SRS',
-                                    1,
                                     'NONE',
-                                    1,
                                     'undefined',
                                     'undefined Cartesian coordinate reference system'
                                 );

INSERT INTO gpkg_spatial_ref_sys (
                                     srs_name,
                                     srs_id,
                                     organization,
                                     organization_coordsys_id,
                                     definition,
                                     description
                                 )
                                 VALUES (
                                     'Undefined geographic SRS',
                                     0,
                                     'NONE',
                                     0,
                                     'undefined',
                                     'undefined geographic coordinate reference system'
                                 );

INSERT INTO gpkg_spatial_ref_sys (
                                     srs_name,
                                     srs_id,
                                     organization,
                                     organization_coordsys_id,
                                     definition,
                                     description
                                 )
                                 VALUES (
                                     'ETRS89 / Portugal TM06',
                                     3763,
                                     'EPSG',
                                     3763,
                                     'PROJCS["ETRS89 / Portugal TM06",GEOGCS["ETRS89",DATUM["European_Terrestrial_Reference_System_1989",SPHEROID["GRS 1980",6378137,298.257222101,AUTHORITY["EPSG","7019"]],AUTHORITY["EPSG","6258"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AUTHORITY["EPSG","4258"]],PROJECTION["Transverse_Mercator"],PARAMETER["latitude_of_origin",39.6682583333333],PARAMETER["central_meridian",-8.13310833333333],PARAMETER["scale_factor",1],PARAMETER["false_easting",0],PARAMETER["false_northing",0],UNIT["metre",1,AUTHORITY["EPSG","9001"]],AXIS["Easting",EAST],AXIS["Northing",NORTH],AUTHORITY["EPSG","3763"]]',
                                     NULL
                                 );

INSERT INTO gpkg_spatial_ref_sys (
                                     srs_name,
                                     srs_id,
                                     organization,
                                     organization_coordsys_id,
                                     definition,
                                     description
                                 )
                                 VALUES (
                                     'WGS 84 geodetic',
                                     4326,
                                     'EPSG',
                                     4326,
                                     'GEOGCS["WGS 84",DATUM["WGS_1984",SPHEROID["WGS 84",6378137,298.257223563,AUTHORITY["EPSG","7030"]],AUTHORITY["EPSG","6326"]],PRIMEM["Greenwich",0,AUTHORITY["EPSG","8901"]],UNIT["degree",0.0174532925199433,AUTHORITY["EPSG","9122"]],AXIS["Latitude",NORTH],AXIS["Longitude",EAST],AUTHORITY["EPSG","4326"]]',
                                     'longitude/latitude coordinates in decimal degrees on the WGS 84 spheroid'
                                 );


-- Table: gpkg_tile_matrix
CREATE TABLE gpkg_tile_matrix (
    table_name    TEXT    NOT NULL,
    zoom_level    INTEGER NOT NULL,
    matrix_width  INTEGER NOT NULL,
    matrix_height INTEGER NOT NULL,
    tile_width    INTEGER NOT NULL,
    tile_height   INTEGER NOT NULL,
    pixel_x_size  DOUBLE  NOT NULL,
    pixel_y_size  DOUBLE  NOT NULL,
    CONSTRAINT pk_ttm PRIMARY KEY (
        table_name,
        zoom_level
    ),
    CONSTRAINT fk_tmm_table_name FOREIGN KEY (
        table_name
    )
    REFERENCES gpkg_contents (table_name) 
);


-- Table: gpkg_tile_matrix_set
CREATE TABLE gpkg_tile_matrix_set (
    table_name TEXT    NOT NULL
                       PRIMARY KEY,
    srs_id     INTEGER NOT NULL,
    min_x      DOUBLE  NOT NULL,
    min_y      DOUBLE  NOT NULL,
    max_x      DOUBLE  NOT NULL,
    max_y      DOUBLE  NOT NULL,
    CONSTRAINT fk_gtms_table_name FOREIGN KEY (
        table_name
    )
    REFERENCES gpkg_contents (table_name),
    CONSTRAINT fk_gtms_srs FOREIGN KEY (
        srs_id
    )
    REFERENCES gpkg_spatial_ref_sys (srs_id) 
);


-- Table: rtree_DTCC_EXCL_P_geom
CREATE VIRTUAL TABLE rtree_DTCC_EXCL_P_geom USING rtree (
    id,
    minx,
    maxx,
    miny,
    maxy
);


-- Table: rtree_DTCC_EXCL_P_geom_node
CREATE TABLE rtree_DTCC_EXCL_P_geom_node (
    nodeno INTEGER PRIMARY KEY,
    data
);

INSERT INTO rtree_DTCC_EXCL_P_geom_node (
                                            nodeno,
                                            data
                                        )
                                        VALUES (
                                            1,
                                            X'000000000000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000029c60d3ca0c60c7e954834b2cb4834bd070000000000000022c60ec755c60547f5483555ee4835b83c0000000000000022c60ec755c60547f5483555ee4835b83c0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb0000000000000024c6006747c5fa7fe948360be9483633cb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
                                        );


-- Table: rtree_DTCC_EXCL_P_geom_parent
CREATE TABLE rtree_DTCC_EXCL_P_geom_parent (
    nodeno     INTEGER PRIMARY KEY,
    parentnode
);


-- Table: rtree_DTCC_EXCL_P_geom_rowid
CREATE TABLE rtree_DTCC_EXCL_P_geom_rowid (
    rowid  INTEGER PRIMARY KEY,
    nodeno
);


-- Table: rtree_DTCC_TIP_L_geom
CREATE VIRTUAL TABLE rtree_DTCC_TIP_L_geom USING rtree (
    id,
    minx,
    maxx,
    miny,
    maxy
);


-- Table: rtree_DTCC_TIP_L_geom_node
CREATE TABLE rtree_DTCC_TIP_L_geom_node (
    nodeno INTEGER PRIMARY KEY,
    data
);

INSERT INTO rtree_DTCC_TIP_L_geom_node (
                                           nodeno,
                                           data
                                       )
                                       VALUES (
                                           1,
                                           X'000000000000000000000049c4e5db3dc4e429d34835e5dc4835f2c00000000000000049c4e5db3dc4e429d34835e5dc4835f2c0000000000000004bc4d6e178c4d64262483599be4835a02f000000000000004bc4d6e178c4d64262483599be4835a02f000000000000004dc4c70833c4c61f8b48352d6b48352fe8000000000000004dc4c70833c4c61f8b48352d6b48352fe8000000000000004fc48e2111c48daadd48354cb14835510d000000000000004fc48e2111c48daadd48354cb14835510d000000000000004fc48e2111c48daadd48354cb14835510d000000000000004fc48e2111c48daadd48354cb14835510d0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea0000000000000043c51b875dc51b7acd483872ad483872ea000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
                                       );


-- Table: rtree_DTCC_TIP_L_geom_parent
CREATE TABLE rtree_DTCC_TIP_L_geom_parent (
    nodeno     INTEGER PRIMARY KEY,
    parentnode
);


-- Table: rtree_DTCC_TIP_L_geom_rowid
CREATE TABLE rtree_DTCC_TIP_L_geom_rowid (
    rowid  INTEGER PRIMARY KEY,
    nodeno
);


-- Table: rtree_DTCC_TIP_P_geom
CREATE VIRTUAL TABLE rtree_DTCC_TIP_P_geom USING rtree (
    id,
    minx,
    maxx,
    miny,
    maxy
);


-- Table: rtree_DTCC_TIP_P_geom_node
CREATE TABLE rtree_DTCC_TIP_P_geom_node (
    nodeno INTEGER PRIMARY KEY,
    data
);

INSERT INTO rtree_DTCC_TIP_P_geom_node (
                                           nodeno,
                                           data
                                       )
                                       VALUES (
                                           1,
                                           X'000000000000000000000267c4ca1fe8c4b5c03448331d8b48333cb80000000000000267c4ca1fe8c4b5c03448331d8b48333cb80000000000000279c547f9e5c53590b7483568184835b0290000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
                                       );


-- Table: rtree_DTCC_TIP_P_geom_parent
CREATE TABLE rtree_DTCC_TIP_P_geom_parent (
    nodeno     INTEGER PRIMARY KEY,
    parentnode
);


-- Table: rtree_DTCC_TIP_P_geom_rowid
CREATE TABLE rtree_DTCC_TIP_P_geom_rowid (
    rowid  INTEGER PRIMARY KEY,
    nodeno
);


-- Table: rtree_v_DTCC_TIP_P_geom
CREATE VIRTUAL TABLE rtree_v_DTCC_TIP_P_geom USING rtree (
    id,
    minx,
    maxx,
    miny,
    maxy
);


-- Table: rtree_v_DTCC_TIP_P_geom_node
CREATE TABLE rtree_v_DTCC_TIP_P_geom_node (
    nodeno INTEGER PRIMARY KEY,
    data
);

INSERT INTO rtree_v_DTCC_TIP_P_geom_node (
                                             nodeno,
                                             data
                                         )
                                         VALUES (
                                             1,
                                             X'000000000000000000000267c4ca1fe8c4b5c03448331d8b48333cb80000000000000267c4ca1fe8c4b5c03448331d8b48333cb80000000000000279c547f9e5c53590b7483568184835b0290000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000278c53f9938c52c2e454835381b483562480000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000273c54d9488c54107054834dbc84835034d0000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb30000000000000249c56cf4a0c565cb6c4835176948351bb3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
                                         );


-- Table: rtree_v_DTCC_TIP_P_geom_parent
CREATE TABLE rtree_v_DTCC_TIP_P_geom_parent (
    nodeno     INTEGER PRIMARY KEY,
    parentnode
);


-- Table: rtree_v_DTCC_TIP_P_geom_rowid
CREATE TABLE rtree_v_DTCC_TIP_P_geom_rowid (
    rowid  INTEGER PRIMARY KEY,
    nodeno
);


-- Trigger: gpkg_tile_matrix_matrix_height_insert
CREATE TRIGGER gpkg_tile_matrix_matrix_height_insert
        BEFORE INSERT
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "insert on table ''gpkg_tile_matrix'' violates constraint: matrix_height cannot be less than 1") 
     WHERE (NEW.matrix_height < 1);
END;


-- Trigger: gpkg_tile_matrix_matrix_height_update
CREATE TRIGGER gpkg_tile_matrix_matrix_height_update
        BEFORE UPDATE OF matrix_height
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "update on table ''gpkg_tile_matrix'' violates constraint: matrix_height cannot be less than 1") 
     WHERE (NEW.matrix_height < 1);
END;


-- Trigger: gpkg_tile_matrix_matrix_width_insert
CREATE TRIGGER gpkg_tile_matrix_matrix_width_insert
        BEFORE INSERT
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "insert on table ''gpkg_tile_matrix'' violates constraint: matrix_width cannot be less than 1") 
     WHERE (NEW.matrix_width < 1);
END;


-- Trigger: gpkg_tile_matrix_matrix_width_update
CREATE TRIGGER gpkg_tile_matrix_matrix_width_update
        BEFORE UPDATE OF matrix_width
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "update on table ''gpkg_tile_matrix'' violates constraint: matrix_width cannot be less than 1") 
     WHERE (NEW.matrix_width < 1);
END;


-- Trigger: gpkg_tile_matrix_pixel_x_size_insert
CREATE TRIGGER gpkg_tile_matrix_pixel_x_size_insert
        BEFORE INSERT
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "insert on table ''gpkg_tile_matrix'' violates constraint: pixel_x_size must be greater than 0") 
     WHERE NOT (NEW.pixel_x_size > 0);
END;


-- Trigger: gpkg_tile_matrix_pixel_x_size_update
CREATE TRIGGER gpkg_tile_matrix_pixel_x_size_update
        BEFORE UPDATE OF pixel_x_size
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "update on table ''gpkg_tile_matrix'' violates constraint: pixel_x_size must be greater than 0") 
     WHERE NOT (NEW.pixel_x_size > 0);
END;


-- Trigger: gpkg_tile_matrix_pixel_y_size_insert
CREATE TRIGGER gpkg_tile_matrix_pixel_y_size_insert
        BEFORE INSERT
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "insert on table ''gpkg_tile_matrix'' violates constraint: pixel_y_size must be greater than 0") 
     WHERE NOT (NEW.pixel_y_size > 0);
END;


-- Trigger: gpkg_tile_matrix_pixel_y_size_update
CREATE TRIGGER gpkg_tile_matrix_pixel_y_size_update
        BEFORE UPDATE OF pixel_y_size
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "update on table ''gpkg_tile_matrix'' violates constraint: pixel_y_size must be greater than 0") 
     WHERE NOT (NEW.pixel_y_size > 0);
END;


-- Trigger: gpkg_tile_matrix_zoom_level_insert
CREATE TRIGGER gpkg_tile_matrix_zoom_level_insert
        BEFORE INSERT
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "insert on table ''gpkg_tile_matrix'' violates constraint: zoom_level cannot be less than 0") 
     WHERE (NEW.zoom_level < 0);
END;


-- Trigger: gpkg_tile_matrix_zoom_level_update
CREATE TRIGGER gpkg_tile_matrix_zoom_level_update
        BEFORE UPDATE OF zoom_level
            ON gpkg_tile_matrix
      FOR EACH ROW
BEGIN
    SELECT RAISE(ABORT, "update on table ''gpkg_tile_matrix'' violates constraint: zoom_level cannot be less than 0") 
     WHERE (NEW.zoom_level < 0);
END;


-- Trigger: rtree_DTCC_EXCL_P_geom_delete
CREATE TRIGGER rtree_DTCC_EXCL_P_geom_delete
         AFTER DELETE
            ON DTCC_EXCL_P
          WHEN old.geom NOT NULL
BEGIN
    DELETE FROM rtree_DTCC_EXCL_P_geom
          WHERE id = OLD.fid;
END;


-- Trigger: rtree_DTCC_EXCL_P_geom_insert
CREATE TRIGGER rtree_DTCC_EXCL_P_geom_insert
         AFTER INSERT
            ON DTCC_EXCL_P
          WHEN (new.geom NOT NULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    INSERT OR REPLACE INTO rtree_DTCC_EXCL_P_geom VALUES (
                                                      NEW.fid,
                                                      ST_MinX(NEW.geom),
                                                      ST_MaxX(NEW.geom),
                                                      ST_MinY(NEW.geom),
                                                      ST_MaxY(NEW.geom) 
                                                  );
END;


-- Trigger: rtree_DTCC_EXCL_P_geom_update1
CREATE TRIGGER rtree_DTCC_EXCL_P_geom_update1
         AFTER UPDATE OF geom
            ON DTCC_EXCL_P
          WHEN OLD.fid = NEW.fid AND
               (NEW.geom NOTNULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    INSERT OR REPLACE INTO rtree_DTCC_EXCL_P_geom VALUES (
                                                      NEW.fid,
                                                      ST_MinX(NEW.geom),
                                                      ST_MaxX(NEW.geom),
                                                      ST_MinY(NEW.geom),
                                                      ST_MaxY(NEW.geom) 
                                                  );
END;


-- Trigger: rtree_DTCC_EXCL_P_geom_update2
CREATE TRIGGER rtree_DTCC_EXCL_P_geom_update2
         AFTER UPDATE OF geom
            ON DTCC_EXCL_P
          WHEN OLD.fid = NEW.fid AND
               (NEW.geom ISNULL OR
                ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_EXCL_P_geom
          WHERE id = OLD.fid;
END;


-- Trigger: rtree_DTCC_EXCL_P_geom_update3
CREATE TRIGGER rtree_DTCC_EXCL_P_geom_update3
         AFTER UPDATE
            ON DTCC_EXCL_P
          WHEN OLD.fid != NEW.fid AND
               (NEW.geom NOTNULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_EXCL_P_geom
          WHERE id = OLD.fid;
    INSERT OR REPLACE INTO rtree_DTCC_EXCL_P_geom VALUES (
                                                      NEW.fid,
                                                      ST_MinX(NEW.geom),
                                                      ST_MaxX(NEW.geom),
                                                      ST_MinY(NEW.geom),
                                                      ST_MaxY(NEW.geom) 
                                                  );
END;


-- Trigger: rtree_DTCC_EXCL_P_geom_update4
CREATE TRIGGER rtree_DTCC_EXCL_P_geom_update4
         AFTER UPDATE
            ON DTCC_EXCL_P
          WHEN OLD.fid != NEW.fid AND
               (NEW.geom ISNULL OR
                ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_EXCL_P_geom
          WHERE id IN (OLD.fid, NEW.fid);
END;


-- Trigger: rtree_DTCC_TIP_L_geom_delete
CREATE TRIGGER rtree_DTCC_TIP_L_geom_delete
         AFTER DELETE
            ON DTCC_TIP_L
          WHEN old.geom NOT NULL
BEGIN
    DELETE FROM rtree_DTCC_TIP_L_geom
          WHERE id = OLD.fid;
END;


-- Trigger: rtree_DTCC_TIP_L_geom_insert
CREATE TRIGGER rtree_DTCC_TIP_L_geom_insert
         AFTER INSERT
            ON DTCC_TIP_L
          WHEN (new.geom NOT NULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    INSERT OR REPLACE INTO rtree_DTCC_TIP_L_geom VALUES (
                                                     NEW.fid,
                                                     ST_MinX(NEW.geom),
                                                     ST_MaxX(NEW.geom),
                                                     ST_MinY(NEW.geom),
                                                     ST_MaxY(NEW.geom) 
                                                 );
END;


-- Trigger: rtree_DTCC_TIP_L_geom_update1
CREATE TRIGGER rtree_DTCC_TIP_L_geom_update1
         AFTER UPDATE OF geom
            ON DTCC_TIP_L
          WHEN OLD.fid = NEW.fid AND
               (NEW.geom NOTNULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    INSERT OR REPLACE INTO rtree_DTCC_TIP_L_geom VALUES (
                                                     NEW.fid,
                                                     ST_MinX(NEW.geom),
                                                     ST_MaxX(NEW.geom),
                                                     ST_MinY(NEW.geom),
                                                     ST_MaxY(NEW.geom) 
                                                 );
END;


-- Trigger: rtree_DTCC_TIP_L_geom_update2
CREATE TRIGGER rtree_DTCC_TIP_L_geom_update2
         AFTER UPDATE OF geom
            ON DTCC_TIP_L
          WHEN OLD.fid = NEW.fid AND
               (NEW.geom ISNULL OR
                ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_TIP_L_geom
          WHERE id = OLD.fid;
END;


-- Trigger: rtree_DTCC_TIP_L_geom_update3
CREATE TRIGGER rtree_DTCC_TIP_L_geom_update3
         AFTER UPDATE
            ON DTCC_TIP_L
          WHEN OLD.fid != NEW.fid AND
               (NEW.geom NOTNULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_TIP_L_geom
          WHERE id = OLD.fid;
    INSERT OR REPLACE INTO rtree_DTCC_TIP_L_geom VALUES (
                                                     NEW.fid,
                                                     ST_MinX(NEW.geom),
                                                     ST_MaxX(NEW.geom),
                                                     ST_MinY(NEW.geom),
                                                     ST_MaxY(NEW.geom) 
                                                 );
END;


-- Trigger: rtree_DTCC_TIP_L_geom_update4
CREATE TRIGGER rtree_DTCC_TIP_L_geom_update4
         AFTER UPDATE
            ON DTCC_TIP_L
          WHEN OLD.fid != NEW.fid AND
               (NEW.geom ISNULL OR
                ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_TIP_L_geom
          WHERE id IN (OLD.fid, NEW.fid);
END;


-- Trigger: rtree_DTCC_TIP_P_geom_delete
CREATE TRIGGER rtree_DTCC_TIP_P_geom_delete
         AFTER DELETE
            ON DTCC_TIP_P
          WHEN old.geom NOT NULL
BEGIN
    DELETE FROM rtree_DTCC_TIP_P_geom
          WHERE id = OLD.fid;
END;


-- Trigger: rtree_DTCC_TIP_P_geom_insert
CREATE TRIGGER rtree_DTCC_TIP_P_geom_insert
         AFTER INSERT
            ON DTCC_TIP_P
          WHEN (new.geom NOT NULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    INSERT OR REPLACE INTO rtree_DTCC_TIP_P_geom VALUES (
                                                     NEW.fid,
                                                     ST_MinX(NEW.geom),
                                                     ST_MaxX(NEW.geom),
                                                     ST_MinY(NEW.geom),
                                                     ST_MaxY(NEW.geom) 
                                                 );
END;


-- Trigger: rtree_DTCC_TIP_P_geom_update1
CREATE TRIGGER rtree_DTCC_TIP_P_geom_update1
         AFTER UPDATE OF geom
            ON DTCC_TIP_P
          WHEN OLD.fid = NEW.fid AND
               (NEW.geom NOTNULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    INSERT OR REPLACE INTO rtree_DTCC_TIP_P_geom VALUES (
                                                     NEW.fid,
                                                     ST_MinX(NEW.geom),
                                                     ST_MaxX(NEW.geom),
                                                     ST_MinY(NEW.geom),
                                                     ST_MaxY(NEW.geom) 
                                                 );
END;


-- Trigger: rtree_DTCC_TIP_P_geom_update2
CREATE TRIGGER rtree_DTCC_TIP_P_geom_update2
         AFTER UPDATE OF geom
            ON DTCC_TIP_P
          WHEN OLD.fid = NEW.fid AND
               (NEW.geom ISNULL OR
                ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_TIP_P_geom
          WHERE id = OLD.fid;
END;


-- Trigger: rtree_DTCC_TIP_P_geom_update3
CREATE TRIGGER rtree_DTCC_TIP_P_geom_update3
         AFTER UPDATE
            ON DTCC_TIP_P
          WHEN OLD.fid != NEW.fid AND
               (NEW.geom NOTNULL AND
                NOT ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_TIP_P_geom
          WHERE id = OLD.fid;
    INSERT OR REPLACE INTO rtree_DTCC_TIP_P_geom VALUES (
                                                     NEW.fid,
                                                     ST_MinX(NEW.geom),
                                                     ST_MaxX(NEW.geom),
                                                     ST_MinY(NEW.geom),
                                                     ST_MaxY(NEW.geom) 
                                                 );
END;


-- Trigger: rtree_DTCC_TIP_P_geom_update4
CREATE TRIGGER rtree_DTCC_TIP_P_geom_update4
         AFTER UPDATE
            ON DTCC_TIP_P
          WHEN OLD.fid != NEW.fid AND
               (NEW.geom ISNULL OR
                ST_IsEmpty(NEW.geom) ) 
BEGIN
    DELETE FROM rtree_DTCC_TIP_P_geom
          WHERE id IN (OLD.fid, NEW.fid);
END;


-- Trigger: trigger_delete_feature_count_CATALOGO
CREATE TRIGGER trigger_delete_feature_count_CATALOGO
         AFTER DELETE
            ON CATALOGO
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('CATALOGO');
END;


-- Trigger: trigger_delete_feature_count_DTCC_EXCL_P
CREATE TRIGGER trigger_delete_feature_count_DTCC_EXCL_P
         AFTER DELETE
            ON DTCC_EXCL_P
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('DTCC_EXCL_P');
END;


-- Trigger: trigger_delete_feature_count_DTCC_TIP_L
CREATE TRIGGER trigger_delete_feature_count_DTCC_TIP_L
         AFTER DELETE
            ON DTCC_TIP_L
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('DTCC_TIP_L');
END;


-- Trigger: trigger_delete_feature_count_DTCC_TIP_P
CREATE TRIGGER trigger_delete_feature_count_DTCC_TIP_P
         AFTER DELETE
            ON DTCC_TIP_P
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count - 1
     WHERE lower(table_name) = lower('DTCC_TIP_P');
END;


-- Trigger: trigger_insert_feature_count_CATALOGO
CREATE TRIGGER trigger_insert_feature_count_CATALOGO
         AFTER INSERT
            ON CATALOGO
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('CATALOGO');
END;


-- Trigger: trigger_insert_feature_count_DTCC_EXCL_P
CREATE TRIGGER trigger_insert_feature_count_DTCC_EXCL_P
         AFTER INSERT
            ON DTCC_EXCL_P
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('DTCC_EXCL_P');
END;


-- Trigger: trigger_insert_feature_count_DTCC_TIP_L
CREATE TRIGGER trigger_insert_feature_count_DTCC_TIP_L
         AFTER INSERT
            ON DTCC_TIP_L
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('DTCC_TIP_L');
END;


-- Trigger: trigger_insert_feature_count_DTCC_TIP_P
CREATE TRIGGER trigger_insert_feature_count_DTCC_TIP_P
         AFTER INSERT
            ON DTCC_TIP_P
BEGIN
    UPDATE gpkg_ogr_contents
       SET feature_count = feature_count + 1
     WHERE lower(table_name) = lower('DTCC_TIP_P');
END;


COMMIT TRANSACTION;
PRAGMA foreign_keys = on;
