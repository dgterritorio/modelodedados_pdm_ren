## PDM - Correspondência de campos entre modelo de dados em vigor e proposta de melhoria

### Simbologia

Explicação da simbologia presente nas tabelas comparativas.

| Símbolo | Significado                                                                                 |
|---------|---------------------------------------------------------------------------------------------|
| **=**   | O campo manteve o nome no modelo anterior.                                                  |
| **≠**   | O campo apresenta nome ou tipo diferente entre os modelos.                                  |
| `NULL`  | Os campos acrescentados ou retirados na proposta sem correspondência com a versão anterior. |

---

### Comparação dos nomes das tabelas

| **Tabelas** | **Relação** | **Tabelas anteriores** |
|---------------------|:-------:|------------------|
| catalogo            |    ≠    | OBJETO_TIPO      |
| objeto_ponto        |    ≠    | OBJETOS_PONTO    |
| objeto_linha        |    ≠    | OBJETOS_LINHA    |
| objeto_poligono     |    ≠    | OBJETOS_LINHA    |
| ato_especifico      |    =    | ATO_ESPECIFICO   |
| codigo_ine          |    ≠    | `NULL`           |
| atribuir_concelho   |    ≠    | `NULL`           |
| objeto_planta       |    ≠    | `NULL`           |

---

### Tabela: OBJETO_TIPO

| **Campos [objeto_ponto]** | **Relação** | **Campos anteriores [OBJETO_TIPO]** |
|----------------------------------|:-------:|-------------------------------|
| fid                              |    ≠    | ID                            |
| codigo                           |    =    | CODIGO                        |
| planta_o                         |    ≠    | PLANTA                        |
| tema_o                           |    ≠    | TEMA                          |
| subtema_o                        |    ≠    | SUBTEMA                       |
| planta_c                         |    ≠    | PLANTA                        |
| tema_c                           |    ≠    | TEMA                          |
| subtema_c                        |    ≠    | SUBTEMA                       |
| designacao                       |    =    | DESIGNACAO                    |
| geometria                        |    ≠    | `NULL`                        |

---

### Tabela: OBJETO_PONTO

| **Campos [objeto_ponto]** | **Relação** | **Campos anteriores [OBJETOS_PONTO]** |
|-----------------------------------|:-------:|---------------------------------|
| fid                               |    ≠    | ID                              |
| geom                              |    =    | GEOM                            |
| uuid                              |    ≠    | IDENTIFICA                      |
| dtcc                              |    ≠    | `NULL`                          |
| planta                            |    ≠    | `NULL`                          |
| codigo                            |    ≠    | `NULL`                          |
| legenda                           |    ≠    | ESPECIFICA                      |
| etiqueta                          |    =    | ETIQUETA                        |
| `NULL`                            |    ≠    | FONTE_INF                       |
| `NULL`                            |    ≠    | DATA_INF                        |
| id_ato_especifico                 |    ≠    | `NULL`                          |

---

### Tabela: OBJETO_LINHA

| **Campos [objeto_linha]** | **Relação** | **Campos anteriores [OBJETOS_LINHA]** |
|-----------------------------------|:-------:|---------------------------------|
| fid                               |    ≠    | ID                              |
| geom                              |    =    | GEOM                            |
| uuid                              |    ≠    | IDENTIFICA                      |
| dtcc                              |    ≠    | `NULL`                          |
| planta                            |    ≠    | `NULL`                          |
| codigo                            |    ≠    | `NULL`                          |
| legenda                           |    ≠    | ESPECIFICA                      |
| etiqueta                          |    =    | ETIQUETA                        |
| `NULL`                            |    ≠    | FONTE_INF                       |
| `NULL`                            |    ≠    | DATA_INF                        |
| comp_m                            |    ≠    | MEDIDA                          |
| id_ato_especifico                 |    ≠    | `NULL`                          |

---

### Tabela: OBJETO_POLIGONO

| **Campos [objeto_poligono]** | **Relação** | **Campos anteriores [OBJETOS_LINHA]** |
|--------------------------------------|:-------:|---------------------------------|
| fid                                  |    ≠    | ID                              |
| geom                                 |    =    | GEOM                            |
| uuid                                 |    ≠    | IDENTIFICA                      |
| dtcc                                 |    ≠    | `NULL`                          |
| planta                               |    ≠    | `NULL`                          |
| codigo                               |    ≠    | `NULL`                          |
| legenda                              |    ≠    | ESPECIFICA                      |
| etiqueta                             |    =    | ETIQUETA                        |
| `NULL`                               |    ≠    | FONTE                           |
| `NULL`                               |    ≠    | DATA_INF                        |
| area_m2                              |    ≠    | MEDIDA                          |
| id_ato_especifico                    |    ≠    | `NULL`                          |

---

### Tabela: ATO_ESPECIFICO

| **Campos [ato_especifico]** | **Relação** | **Campos anteriores [ATO_ESPECIFICO]** |
|-------------------------------------|:-------:|----------------------------------|
| fid                                 |    ≠    | IDENTIFICA                       |
| id_ato_especifico                   |    ≠    | `NULL`                           |
| serie_dr                            |    ≠    | SERIE                            |
| numero_dr                           |    ≠    | NUM_DR                           |
| tipo_ato                            |    =    | TIPO_ATO                         |
| numero_ato                          |    ≠    | NUM_ATO                          |
| data_publicacao                     |    ≠    | DATA                             |
| dtcc                                |    ≠    | `NULL`                           |
| `NULL`                              |    ≠    | OBSERV                           |
