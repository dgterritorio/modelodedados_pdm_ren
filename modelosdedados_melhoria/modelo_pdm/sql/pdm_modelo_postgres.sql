-- Ativar extensões necessárias
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Criar o schema
CREATE SCHEMA IF NOT EXISTS dgt_pdm;


-- ==========================================================
-- Tabela com objeto_tipo
-- ==========================================================

-- Table: dgt_pdm.objeto_tipo
-- DROP TABLE IF EXISTS dgt_pdm.objeto_tipo;
CREATE TABLE IF NOT EXISTS dgt_pdm.objeto_tipo
(
    id SERIAL,
    codigo integer NOT NULL UNIQUE,
    planta text NOT NULL,
    tema text NOT NULL,
    subtema text NOT NULL,
    designacao text NOT NULL,
    CONSTRAINT objeto_tipo_pkey PRIMARY KEY (id),
	UNIQUE(planta, tema, subtema, designacao)
);


COMMENT ON TABLE dgt_pdm.objeto_tipo
    IS 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf
Tabela auxiliar "OBJETO_TIPO"';

COMMENT ON COLUMN dgt_pdm.objeto_tipo.id
    IS 'ID – campo de numeração automática, do tipo número inteiro, único e irrepetível que identifica de forma unívoca cada par constituído por objeto do catálogo e planta em que este pode ser representado. É chave primária da tabela auxiliar e funciona como chave estrangeira para as tabelas gráficas;';

COMMENT ON COLUMN dgt_pdm.objeto_tipo.codigo
    IS 'CODIGO – campo do tipo número inteiro que correspondendo ao código utilizado no catálogo de objetos (Anexo I) para permitir a sua articulação com o catálogo de simbologia (Anexo III).';

COMMENT ON COLUMN dgt_pdm.objeto_tipo.planta
    IS 'PLANTA – campo do tipo texto que identifica a planta em que o objeto pode ser representado, podendo ter como domínio do atributo as seguintes opções: “Ordenamento” para planta de ordenamento; “Condicionantes” para planta de condicionantes;';

COMMENT ON COLUMN dgt_pdm.objeto_tipo.tema
    IS 'Os campos “TEMA”, “SUBTEMA” e “DESIGNACAO”, do tipo texto, devem ser preenchidos conforme o exposto no Anexo I;';

COMMENT ON COLUMN dgt_pdm.objeto_tipo.subtema
    IS 'Os campos “TEMA”, “SUBTEMA” e “DESIGNACAO”, do tipo texto, devem ser preenchidos conforme o exposto no Anexo I;';

COMMENT ON COLUMN dgt_pdm.objeto_tipo.designacao
    IS 'Os campos “TEMA”, “SUBTEMA” e “DESIGNACAO”, do tipo texto, devem ser preenchidos conforme o exposto no Anexo I;';

-- ==========================================================
-- Tabelas espaciais SEPARADAS por tipo de geometria
-- ==========================================================

-- Table: dgt_pdm.objeto_ponto
-- DROP TABLE IF EXISTS dgt_pdm.objeto_ponto;
CREATE TABLE IF NOT EXISTS dgt_pdm.objeto_ponto
(
    id SERIAL PRIMARY KEY,
    geom geometry(MultiPoint,3763) NOT NULL,
	identifica uuid NOT NULL DEFAULT uuid_generate_v4(),
	-- id_ato integer REFERENCES dgt_pdm.ato_especifico(id), -- proposta de nova coluna para relacionar com o ato_especifico
    especifica integer NOT NULL REFERENCES dgt_pdm.objeto_tipo(codigo),
    -- codigo_obj integer NOT NULL REFERENCES dgt_pdm.objeto_tipo(codigo),  -- sugestão de mudar para o nome da coluna para codigo_obj, talvez fique mais intuitivo
	legenda text, -- nova coluna para criar objectos especificos para álem dos que existem na tabela 
    etiqueta text,
    fonte_inf text,
    data_inf date
);

COMMENT ON TABLE dgt_pdm.objeto_ponto
    IS 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.id
    IS 'ID – campo do tipo número inteiro que é chave primária da tabela auxiliar e funciona como chave estrangeira para as tabelas gráficas. Este ID permite identificar de forma unívoca cada par constituído por objeto do catálogo e planta em que este é representado;';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.identifica
    IS 'IDENTIFICA – campo do tipo texto que identifica inequivocamente cada registo em qualquer tabela gráfica, devendo ser único e não podendo ser nulo. É chave primária das tabelas gráficas e chave estrangeira para a tabela secundária “ATO_ESPECIFICO”. Deve ser utilizado preferencialmente um Identificador Global Exclusivo (GUID - Globally Unique Identifier) para cada registo. A geração de GUID é possível obter, por exemplo, no seguinte endereço: https://www.guidgenerator.com/;';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.especifica
    IS 'ESPECIFICA – campo do tipo texto, utilizável quando se desagrega ou especifica o objeto. Aplica-se às seguintes situações:
a) Aos objetos cuja desagregação é opcional, que podem ser:
i) Objetos do tema “Classificação e Qualificação do Solo”, de modo a desagregar as categorias de solo em subcategorias;
ii) Objetos do tema “Sistemas Estruturantes”, de modo a identificar a sua especificidade;
iii) Objetos da planta de condicionantes que se pretendam especificar individualmente, como por exemplo, os imóveis classificados, as áreas protegidas ou as captações de água.
b) Aos objetos da planta de ordenamento cuja especificação é obrigatória, que são
i) Objetos do tema “Programação da Execução do Plano” em que é obrigatória a identificação das UOPG e UE estabelecidas no plano;
ii) Objetos dos temas “Programas territoriais” e “Planos territoriais” em que é obrigatória a identificação das áreas do PDM abrangidas por programas setoriais, especiais ou intermunicipais e por planos territoriais de âmbito intermunicipal ou municipal, em vigor;
iii) Objetos do tema “Áreas de Intervenção de outros Instrumentos ou Entidades” bem como, AUGI e ARU representadas na planta de ordenamento.';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.legenda
    IS 'Nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.etiqueta
    IS 'ETIQUETA - campo do tipo texto, permite introduzir na simbologia uma etiqueta com uma sigla que identifique na planta o objeto em questão, indicando-se no título 3.1.2 (parágrafos 3.1.2.6 e 3.1.2.7) um exemplo da utilização deste campo.';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.fonte_inf
    IS 'FONTE_INF - campo do tipo texto, para indicação da fonte/entidade de origem da informação representada (Por exemplo na planta de condicionantes, o objeto pode ter sido fornecido pela entidade que tutela a respetiva servidão).';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.data_inf
    IS 'DATA_INF – campo do tipo data, para indicação da data a que se reporta o objeto ou a data em que a câmara municipal obteve o objeto da fonte referida no campo FONTE_INF.';

COMMENT ON COLUMN dgt_pdm.objeto_ponto.geom
    IS 'GEOM – campo do tipo geométrico que se destina ao registo da informação da geometria do objeto, variando o tipo de campo consoante a tabela gráfica respetiva, nomeadamente, ponto, linha ou polígono. A designação deste campo pode ser diferente de “GEOM”, dependendo do software utilizado.';

-- ==========================================================
CREATE INDEX IF NOT EXISTS objeto_ponto_geom_idx
    ON dgt_pdm.objeto_ponto 
	USING gist(geom);

-- Table: dgt_pdm.objeto_linha
-- DROP TABLE IF EXISTS dgt_pdm.objeto_linha;
CREATE TABLE IF NOT EXISTS dgt_pdm.objeto_linha
(
    id SERIAL PRIMARY KEY,
    geom geometry(MultiLineString,3763) NOT NULL,
	identifica uuid NOT NULL DEFAULT uuid_generate_v4(),
	-- id_ato integer REFERENCES dgt_pdm.ato_especifico(id), -- proposta de nova coluna para relacionar com o ato_especifico
    especifica integer NOT NULL REFERENCES dgt_pdm.objeto_tipo(codigo),
    -- codigo_obj integer NOT NULL REFERENCES dgt_pdm.objeto_tipo(codigo),  -- sugestão de mudar para o nome da coluna para codigo_obj, talvez fique mais intuitivo
	legenda text, -- nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo
    etiqueta text,
    fonte_inf text,
    data_inf date,
    medida numeric(15,2) -- km
	-- medida numeric(15,2) GENERATED ALWAYS AS (ST_Length(geom) / 1000.0) STORED -- km (GENERATED ALWAYS só disponível em PostgreSQL ≥ 12)
);

CREATE INDEX IF NOT EXISTS objeto_linha_geom_idx
    ON dgt_pdm.objeto_linha 
	USING gist(geom);

COMMENT ON TABLE dgt_pdm.objeto_linha
    IS 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf';

COMMENT ON COLUMN dgt_pdm.objeto_linha.id
    IS 'ID – campo do tipo número inteiro que é chave primária da tabela auxiliar e funciona como chave estrangeira para as tabelas gráficas. Este ID permite identificar de forma unívoca cada par constituído por objeto do catálogo e planta em que este é representado;';

COMMENT ON COLUMN dgt_pdm.objeto_linha.identifica
    IS 'IDENTIFICA – campo do tipo texto que identifica inequivocamente cada registo em qualquer tabela gráfica, devendo ser único e não podendo ser nulo. É chave primária das tabelas gráficas e chave estrangeira para a tabela secundária “ATO_ESPECIFICO”. Deve ser utilizado preferencialmente um Identificador Global Exclusivo (GUID - Globally Unique Identifier) para cada registo. A geração de GUID é possível obter, por exemplo, no seguinte endereço: https://www.guidgenerator.com/;';

COMMENT ON COLUMN dgt_pdm.objeto_linha.especifica
    IS 'ESPECIFICA – campo do tipo texto, utilizável quando se desagrega ou especifica o objeto. Aplica-se às seguintes situações:
a) Aos objetos cuja desagregação é opcional, que podem ser:
i) Objetos do tema “Classificação e Qualificação do Solo”, de modo a desagregar as categorias de solo em subcategorias;
ii) Objetos do tema “Sistemas Estruturantes”, de modo a identificar a sua especificidade;
iii) Objetos da planta de condicionantes que se pretendam especificar individualmente, como por exemplo, os imóveis classificados, as áreas protegidas ou as captações de água.
b) Aos objetos da planta de ordenamento cuja especificação é obrigatória, que são
i) Objetos do tema “Programação da Execução do Plano” em que é obrigatória a identificação das UOPG e UE estabelecidas no plano;
ii) Objetos dos temas “Programas territoriais” e “Planos territoriais” em que é obrigatória a identificação das áreas do PDM abrangidas por programas setoriais, especiais ou intermunicipais e por planos territoriais de âmbito intermunicipal ou municipal, em vigor;
iii) Objetos do tema “Áreas de Intervenção de outros Instrumentos ou Entidades” bem como, AUGI e ARU representadas na planta de ordenamento.';

COMMENT ON COLUMN dgt_pdm.objeto_linha.legenda
    IS 'Nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo';

COMMENT ON COLUMN dgt_pdm.objeto_linha.etiqueta
    IS 'ETIQUETA - campo do tipo texto, permite introduzir na simbologia uma etiqueta com uma sigla que identifique na planta o objeto em questão, indicando-se no título 3.1.2 (parágrafos 3.1.2.6 e 3.1.2.7) um exemplo da utilização deste campo.';

COMMENT ON COLUMN dgt_pdm.objeto_linha.fonte_inf
    IS 'FONTE_INF - campo do tipo texto, para indicação da fonte/entidade de origem da informação representada (Por exemplo na planta de condicionantes, o objeto pode ter sido fornecido pela entidade que tutela a respetiva servidão).';

COMMENT ON COLUMN dgt_pdm.objeto_linha.data_inf
    IS 'DATA_INF – campo do tipo data, para indicação da data a que se reporta o objeto ou a data em que a câmara municipal obteve o objeto da fonte referida no campo FONTE_INF.';

COMMENT ON COLUMN dgt_pdm.objeto_linha.medida
    IS 'MEDIDA – campo de tipo número decimal que se destina a registar a área dos polígonos em hectares (ha) ou o comprimento das linhas em quilómetros (km).
NOVO - Cálculo automático';
	
-- ==========================================================
-- Compatível com qualquer versão de PostgreSQL que suporte PostGIS
CREATE OR REPLACE FUNCTION dgt_pdm.calc_medida_linha()
RETURNS trigger AS $$
BEGIN
    NEW.medida := ROUND(ST_Length(NEW.geom)::numeric / 1000.0, 2);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calc_medida_linha
BEFORE INSERT OR UPDATE ON dgt_pdm.objeto_linha
FOR EACH ROW EXECUTE FUNCTION dgt_pdm.calc_medida_linha();


-- ==========================================================
-- Table: dgt_pdm.objeto_poligono
-- DROP TABLE IF EXISTS dgt_pdm.objeto_poligono;
CREATE TABLE IF NOT EXISTS dgt_pdm.objeto_poligono
(
    id SERIAL PRIMARY KEY,
    geom geometry(MultiPolygon,3763) NOT NULL,
	identifica uuid NOT NULL DEFAULT uuid_generate_v4(),
	-- id_ato integer REFERENCES dgt_pdm.ato_especifico(id), -- proposta de nova coluna para relacionar com o ato_especifico
	especifica integer NOT NULL REFERENCES dgt_pdm.objeto_tipo(codigo),
    -- codigo_obj integer NOT NULL REFERENCES dgt_pdm.objeto_tipo(codigo),  -- sugestão de mudar para o nome da coluna para codigo_obj, talvez fique mais intuitivo
	legenda text, -- nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo.designacao
    etiqueta text,
    fonte_inf text,
    data_inf date,
	medida numeric(15,2) -- hectares
	-- medida numeric(15,2) GENERATED ALWAYS AS (ST_Area(geom) / 10000.0) STORED -- hectares (GENERATED ALWAYS só disponível em PostgreSQL ≥ 12)

);

CREATE INDEX IF NOT EXISTS objeto_poligono_geom_idx
    ON dgt_pdm.objeto_poligono 
	USING gist(geom);


COMMENT ON TABLE dgt_pdm.objeto_poligono
    IS 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.id
    IS 'ID – campo do tipo número inteiro que é chave primária da tabela auxiliar e funciona como chave estrangeira para as tabelas gráficas. Este ID permite identificar de forma unívoca cada par constituído por objeto do catálogo e planta em que este é representado;';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.identifica
    IS 'IDENTIFICA – campo do tipo texto que identifica inequivocamente cada registo em qualquer tabela gráfica, devendo ser único e não podendo ser nulo. É chave primária das tabelas gráficas e chave estrangeira para a tabela secundária “ATO_ESPECIFICO”. Deve ser utilizado preferencialmente um Identificador Global Exclusivo (GUID - Globally Unique Identifier) para cada registo. A geração de GUID é possível obter, por exemplo, no seguinte endereço: https://www.guidgenerator.com/;';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.especifica
    IS 'ESPECIFICA – campo do tipo texto, utilizável quando se desagrega ou especifica o objeto. Aplica-se às seguintes situações:
a) Aos objetos cuja desagregação é opcional, que podem ser:
i) Objetos do tema “Classificação e Qualificação do Solo”, de modo a desagregar as categorias de solo em subcategorias;
ii) Objetos do tema “Sistemas Estruturantes”, de modo a identificar a sua especificidade;
iii) Objetos da planta de condicionantes que se pretendam especificar individualmente, como por exemplo, os imóveis classificados, as áreas protegidas ou as captações de água.
b) Aos objetos da planta de ordenamento cuja especificação é obrigatória, que são
i) Objetos do tema “Programação da Execução do Plano” em que é obrigatória a identificação das UOPG e UE estabelecidas no plano;
ii) Objetos dos temas “Programas territoriais” e “Planos territoriais” em que é obrigatória a identificação das áreas do PDM abrangidas por programas setoriais, especiais ou intermunicipais e por planos territoriais de âmbito intermunicipal ou municipal, em vigor;
iii) Objetos do tema “Áreas de Intervenção de outros Instrumentos ou Entidades” bem como, AUGI e ARU representadas na planta de ordenamento.';

COMMENT ON COLUMN dgt_pdm.objeto_linha.legenda
    IS 'Nova coluna para criar objectos especificos para álem dos que existem na tabela objeto_tipo';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.etiqueta
    IS 'ETIQUETA - campo do tipo texto, permite introduzir na simbologia uma etiqueta com uma sigla que identifique na planta o objeto em questão, indicando-se no título 3.1.2 (parágrafos 3.1.2.6 e 3.1.2.7) um exemplo da utilização deste campo.';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.fonte_inf
    IS 'FONTE_INF - campo do tipo texto, para indicação da fonte/entidade de origem da informação representada (Por exemplo na planta de condicionantes, o objeto pode ter sido fornecido pela entidade que tutela a respetiva servidão).';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.data_inf
    IS 'DATA_INF – campo do tipo data, para indicação da data a que se reporta o objeto ou a data em que a câmara municipal obteve o objeto da fonte referida no campo FONTE_INF.';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.medida
    IS 'MEDIDA – campo de tipo número decimal que se destina a registar a área dos polígonos em hectares (ha) ou o comprimento das linhas em quilómetros (km).';

COMMENT ON COLUMN dgt_pdm.objeto_poligono.geom
    IS 'GEOM – campo do tipo geométrico que se destina ao registo da informação da geometria do objeto, variando o tipo de campo consoante a tabela gráfica respetiva, nomeadamente, ponto, linha ou polígono. A designação deste campo pode ser diferente de “GEOM”, dependendo do software utilizado.';

-- ==========================================================
-- Compatível com qualquer versão de PostgreSQL que suporte PostGIS
CREATE OR REPLACE FUNCTION dgt_pdm.calc_area_poligono()
RETURNS trigger AS $$
BEGIN
    NEW.medida := ROUND(ST_Area(NEW.geom)::numeric / 10000.0, 2);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calc_area_poligono
BEFORE INSERT OR UPDATE ON dgt_pdm.objeto_poligono
FOR EACH ROW EXECUTE FUNCTION dgt_pdm.calc_area_poligono();

-- ==========================================================
-- Ato Específico (atos legais ligados a objetos condicionantes)
-- ==========================================================
-- Table: dgt_pdm.ato_especifico
-- DROP TABLE IF EXISTS dgt_pdm.ato_especifico;
CREATE TABLE IF NOT EXISTS dgt_pdm.ato_especifico
(
    id SERIAL,
    serie text,
    num_dr text,
    tipo_ato text NOT NULL,
    num_ato text,
    data_ato date,
    fonte_ato text,
    observ text,
    CONSTRAINT ato_especifico_pkey PRIMARY KEY (id)
);


COMMENT ON TABLE dgt_pdm.ato_especifico
    IS 'Norma Técnica sobre o Modelo de Dados e Sistematização da Informação Gráfica dos PDM (Vol I e Vol II)
https://www.dgterritorio.gov.pt/sites/default/files/publicacoes/Modelodados_PDM_18022021_Vol1_e_Vol2.pdf
Tabela secundária "ATO_ESPECIFICO"';

/* -- REMOVIDO
COMMENT ON COLUMN dgt_pdm.ato_especifico.identifica
    IS 'IDENTIFICA – campo do tipo texto que é chave primária das tabelas gráficas e chave estrangeira para a tabela secundária. Este campo identifica inequivocamente cada registo em qualquer tabela gráfica;';

COMMENT ON COLUMN dgt_pdm.ato_especifico.serie
    IS 'SERIE – campo do tipo texto que indica a série do Diário da República onde foi publicado o ato específico que constitui a servidão ou restrição de utilidade pública. Este campo tem como domínio do atributo as seguintes opções: “SERIE I” ou “SERIE II”;'; */

COMMENT ON COLUMN dgt_pdm.ato_especifico.tipo_ato
    IS 'TIPO_ATO – campo do tipo texto que indica o tipo de ato que constitui a servidão ou restrição de utilidade pública. Este campo tem como domínio do atributo as seguintes opções: “Lei”; “Decreto-Lei”; “Dec-Reg” caso se trate de Decreto-Regulamentar; “Decreto”; “RCM” caso se trate de Resolução do Conselho de Ministros”; “Portaria”; “Aviso”; “Decisao” caso se trate de Decisão; “Declaracao” caso se trate de Declaração; “Deliberacao” caso se trate de Deliberação; “Despacho”; “Desp-Conj” caso se trate de Despacho-Conjunto; e “Regulamento”;';

COMMENT ON COLUMN dgt_pdm.ato_especifico.num_ato
    IS 'NUM_ATO – campo do tipo texto que indica o número do ato específico que constitui a servidão ou restrição de utilidade pública;';

COMMENT ON COLUMN dgt_pdm.ato_especifico.data_ato
    IS 'DATA – campo do tipo data que indica a data do ato específico que constitui a servidão ou restrição de utilidade pública;';

COMMENT ON COLUMN dgt_pdm.ato_especifico.num_dr
    IS 'NUM_DR – campo do tipo texto que indica o número do Diário da República onde foi publicado o ato específico que constitui a servidão ou restrição de utilidade pública;';

COMMENT ON COLUMN dgt_pdm.ato_especifico.observ
    IS 'OBSERV – campo do tipo texto, de preenchimento não obrigatório, destinado à indicação de outras observações.';

-- ==========================================================
-- ato_objeto
-- ==========================================================
-- Table: dgt_pdm.ato_objeto
-- DROP TABLE IF EXISTS dgt_pdm.ato_objeto;
CREATE TABLE IF NOT  TABLE dgt_pdm.ato_objeto (
    ato_id INTEGER NOT NULL REFERENCES dgt_pdm.ato_especifico(id) ON DELETE CASCADE,
    objeto_id UUID NOT NULL,
    tipo_geom TEXT NOT NULL CHECK (tipo_geom IN ('objeto_ponto', 'objeto_linha', 'objeto_poligono')),
    PRIMARY KEY (ato_id, objeto_id, tipo_geom)
);


CREATE OR REPLACE FUNCTION dgt_pdm.insert_tipo_geom()
RETURNS trigger AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM dgt_pdm.objeto_ponto WHERE identifica = NEW.objeto_id) THEN
        NEW.tipo_geom := 'objeto_ponto';
    ELSIF EXISTS (SELECT 1 FROM dgt_pdm.objeto_linha WHERE identifica = NEW.objeto_id) THEN
        NEW.tipo_geom := 'objeto_linha';
    ELSIF EXISTS (SELECT 1 FROM dgt_pdm.objeto_poligono WHERE identifica = NEW.objeto_id) THEN
        NEW.tipo_geom := 'objeto_poligono';
    ELSE
        RAISE EXCEPTION 'Objeto com id % não encontrado em nenhuma tabela', NEW.objeto_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER insert_tipo_geom
BEFORE INSERT ON dgt_pdm.ato_objeto
FOR EACH ROW
EXECUTE FUNCTION dgt_pdm.insert_tipo_geom();


-- ==========================================================
-- VIEW objetos - UNION ALL
-- ==========================================================
CREATE OR REPLACE VIEW dgt_pdm.objetos AS
SELECT 
    p.identifica AS id_unico,
    'ponto' AS tipo_geom,
    ot.planta,
    ot.tema,
    ot.subtema,
    ot.designacao,
    ot.codigo,
    p.especifica,
    p.legenda,
    p.etiqueta,
    NULL::numeric AS medida,
    p.fonte_inf,
    p.data_inf,
    p.geom
FROM dgt_pdm.objeto_ponto p
JOIN dgt_pdm.objeto_tipo ot ON p.especifica = ot.codigo

UNION ALL

SELECT 
    l.identifica AS id_unico,
    'linha' AS tipo_geom,
    ot.planta,
    ot.tema,
    ot.subtema,
    ot.designacao,
    ot.codigo,
    l.especifica,
    l.legenda,
    l.etiqueta,
    l.medida,
    l.fonte_inf,
    l.data_inf,
    l.geom
FROM dgt_pdm.objeto_linha l
JOIN dgt_pdm.objeto_tipo ot ON l.especifica = ot.codigo

UNION ALL

SELECT 
    g.identifica AS id_unico,
    'poligono' AS tipo_geom,
    ot.planta,
    ot.tema,
    ot.subtema,
    ot.designacao,
    ot.codigo,
    g.especifica,
    g.legenda,
    g.etiqueta,
    g.medida,
    g.fonte_inf,
    g.data_inf,
    g.geom
FROM dgt_pdm.objeto_poligono g
JOIN dgt_pdm.objeto_tipo ot ON g.especifica = ot.codigo;

-- ==========================================================
-- VIEW objetos - UNION ALL
-- ==========================================================
CREATE OR REPLACE VIEW dgt_pdm.atos_com_objetos AS
SELECT 
    ae.id AS ato_id,
    ae.tipo_ato,
    ae.num_ato,
    ae.data_ato,
    ae.fonte_ato,
    ae.observ,
    ao.tipo_geom,
    ao.objeto_id,
    ot.planta,
    ot.tema,
    ot.subtema,
    ot.designacao,
    ot.codigo,
    o.especifica,
    o.legenda,
    o.etiqueta,
    o.medida,
    o.fonte_inf,
    o.data_inf,
    o.geom
FROM dgt_pdm.ato_especifico ae
JOIN dgt_pdm.ato_objeto ao ON ao.ato_id = ae.id
JOIN dgt_pdm.objetos o ON o.id_unico = ao.objeto_id AND o.tipo_geom = ao.tipo_geom
JOIN dgt_pdm.objeto_tipo ot ON o.codigo = ot.codigo;
