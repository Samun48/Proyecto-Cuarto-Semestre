```mermaid

erDiagram
    %% Relaciones no identificadoras
    OPERACION ||..o{ CALCULO : "registra"
    OPERACION ||..o{ SERIE : "origina"
    SERIE ||..|{ PUNTO : "contiene"

    OPERACION {
        INTEGER id_operacion PK "PRIMARY KEY"
        TEXT simbolo_op UK "NOT NULL UNIQUE"
        TEXT nombre_op "NOT NULL"
        TEXT tipo_op "NOT NULL"
        TEXT lenguaje_exec "NOT NULL"
        INTEGER num_operandos "NOT NULL"
    }

    CALCULO {
        INTEGER id_calculo PK "PRIMARY KEY"
        INTEGER operacion_id FK "NOT NULL"
        REAL operando_1 "NOT NULL"
        REAL operando_2 "NULL (si aridad es 1)"
        TEXT modo_angulo "NULL (si es básica)"
        REAL valor_resultado "NULL (si hubo fallo)"
        INTEGER es_exitoso "NOT NULL CHECK (0 o 1)"
        TEXT detalle_error "NULL (si fue exitoso)"
        TEXT registrado_en "NOT NULL DEFAULT CURRENT_TIMESTAMP"
    }

    SERIE {
        INTEGER id_serie PK "PRIMARY KEY"
        INTEGER operacion_id FK "NOT NULL"
        TEXT titulo_serie "NOT NULL"
        REAL x_inicio "NOT NULL"
        REAL x_fin "NOT NULL"
        REAL paso_incremento "NOT NULL"
        TEXT modo_angulo "NOT NULL"
        TEXT creado_el "NOT NULL DEFAULT CURRENT_TIMESTAMP"
    }

    PUNTO {
        INTEGER id_punto PK "PRIMARY KEY"
        INTEGER serie_id FK "NOT NULL"
        REAL valor_x "NOT NULL"
        REAL valor_y "NULL (si es indeterminado)"
    }
