## REN - Correspondência de campos entre modelo de dados em vigor e proposta de melhoria

### Simbologia

Explicação da simbologia presente nas tabelas comparativas.

| Símbolo | Significado                                                                                 |
|---------|---------------------------------------------------------------------------------------------|
| **=**   | O campo manteve o nome no modelo em vigor.                                                  |
| **≠**   | O campo apresenta nome ou tipo diferente entre os modelos.                                  |
| `NULL`  | Os campos acrescentados ou retirados na proposta sem correspondência com a versão em vigor. |

---

### Comparação dos nomes das tabelas

| **Tabelas** | **Relação** | **Tabelas anteriores** |
|---------------------|:-------:|-------------------|
| catalogo            |    ≠    | CATALOGO          |
| tip_l               |    ≠    | DTCC_TIP_L        |
| `NULL`              |    ≠    | DTCC_DET_TIP_L    |
| tip_p               |    ≠    | DTCC_TIP_P        |
| `NULL`              |    ≠    | DTCC_DET_TIP_P    |
| excl_p              |    ≠    | DTCC_EXCL_P       |
| `NULL`              |    ≠    | DTCC_DET_EXCL_P   |
| excl_tip            |    ≠    | DTCC_EXCL_TIP     |
| `NULL`              |    ≠    | DTCC_DET_EXCL_TIP |
| codigo_ine          |    ≠    | `NULL`            |
| atribuir_concelho   |    ≠    | `NULL`            |

---

### **Tabela: CATALOGO**

| **Campos [catalogo]** | **Relação** | **Campos anteriores [CATALOGO]** |
|-------------------------------|:-------:|----------------------------|
| fid                           |    ≠    | `NULL`                     |
| tema                          |    =    | Tema                       |
| subtema                       |    =    | Subtema                    |
| objeto_designacao             |    ≠    | NomeObje                   |
| objeto_codigo                 |    ≠    | CodObje                    |
| legenda                       |    =    | Legenda                    |
| objeto_acronimo               |    ≠    | `NULL`                     |
| geometria                     |    ≠    | `NULL`                     |

---

### **Tabela: tip_l**

| **Campos [tip_l]** | **Relação** | **Campos anteriores [DTCC_TIP_L]** |
|----------------------------|:-------:|------------------------------|
| fid                        |    ≠    | ID_Tip_L                     |
| geom                       |    ≠    | `NULL`                       |
| uuid                       |    ≠    | `NULL`                       |
| dtcc                       |    ≠    | `NULL`                       |
| objeto_codigo              |    ≠    | CodObje                      |
| designacao                 |    ≠    | `NULL`                       |
| comp_m                     |    =    | Comp_m                       |

---

### **Tabela: tip_p**

| **Campos [tip_p]** | **Relação** | **Campos anteriores [DTCC_TIP_P]** |
|----------------------------|:-------:|------------------------------|
| fid                        |    ≠    | ID_Tip_P                     |
| geom                       |    ≠    | `NULL`                       |
| uuid                       |    ≠    | `NULL`                       |
| dtcc                       |    ≠    | `NULL`                       |
| objeto_codigo              |    ≠    | CodObje                      |
| area_m2                    |    =    | Area_m2                      |

---

### **Tabela: excl_p**

| **Campos [excl_p]** | **Relação** | **Campos anteriores [DTCC_EXCL_P]** |
|-----------------------------|:-------:|-------------------------------|
| fid                         |    ≠    | ID_Excl_P                     |
| geom                        |    ≠    | `NULL`                        |
| uuid                        |    ≠    | `NULL`                        |
| dtcc                        |    ≠    | `NULL`                        |
| exclusao                    |    ≠    | Exclusao                      |
| objeto_codigo               |    =    | CodObje                       |
| area_m2                     |    ≠    | Area_m2                       |
| escala                      |    ≠    | `NULL`                        |
| fundamento                  |    =    | Fundamento                    |
| fim_dest                    |    ≠    | FimDest                       |

---

### **Tabela: excl_tip** [Vista]

| **Campos [excl_tip]** | **Relação** | **Campos anteriores [DTCC_EXCL_TIP]** |
|-------------------------------|:-------:|---------------------------------|
| fid                           |    ≠    | ID_Excl_Tip                     |
| fid_tip_p                     |    ≠    | `NULL`                          |
| fid_excl_p                    |    ≠    | `NULL`                          |
| geom                          |    ≠    | `NULL`                          |
| dtcc                          |    ≠    | `NULL`                          |
| objeto_codigo                 |    ≠    | CodObje                         |
| objeto_designacao             |    ≠    | `NULL`                          |
| exclusao                      |    =    | Exclusao                        |
| `NULL`                        |    ≠    | Fundamento                      |
| `NULL`                        |    ≠    | FimDest                         |
| area_excl_tip                 |    ≠    | Area_m2                         |