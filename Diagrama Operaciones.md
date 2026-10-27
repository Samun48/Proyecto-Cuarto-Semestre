```mermaid

flowchart TD
    %% Inicio y Carga de Datos
    Inicio([Inicio]) --> CargarCat[/"Consultar Catálogo de Operaciones desde la BD"/]
    CargarCat --> MostrarCat[/Mostrar Operaciones Disponibles/]
    MostrarCat --> SeleccionarOp[/Leer Selección de Operación del Usuario/]
    
    %% Validar Existencia de Operación
    SeleccionarOp --> ValidarOp{"¿Operación<br/>Existe en Catálogo?"}
    ValidarOp -- No --> MostrarErrOp[/Mostrar 'Operación Inexistente'/] --> Fin0([Fin])
    
    %% Lectura de Datos de Entrada
    ValidarOp -- Sí --> DeterminarAridad{"¿Es de<br/>Aridad 2?"}
    DeterminarAridad -- Sí --> LeerOpDos[/Leer Operando A y Operando B/]
    DeterminarAridad -- No --> LeerOpUno[/Leer Operando A únicamente/]
    
    LeerOpDos --> ChequearTrig{"¿Es de Tipo<br/>TRIGONOMETRICA?"}
    LeerOpUno --> ChequearTrig
    
    ChequearTrig -- Sí --> LeerModo[/Leer Modo de Ángulo: Grados o Radianes/]
    ChequearTrig -- No --> ValidarJava
    
    %% Ruta Java (Operaciones Básicas)
    LeerModo --> ValidarPython
    
    ValidarJava -- "No (Div por 0)" --> MarcarErrorJava[Registrar Mensaje de Error]
    ValidarJava -- Sí --> EjecutarJava[Procesar Operación en Java]
    
    MarcarErrorJava --> GuardarBD
    EjecutarJava --> SetExitoJava[Registrar Resultado Exitoso] --> GuardarBD
    
    %% Ruta Python (Operaciones Trigonométricas via ProcessBuilder)
    ValidarPython["Java Invoca Python mediante ProcessBuilder"] --> EvaluarPython{"¿Respuesta<br/>de Python?"}
    
    EvaluarPython -- "ERROR;mensaje<br/>(ej: tan 90°, asin 2)" --> MarcarErrorPy[Registrar Mensaje de Error]
    EvaluarPython -- "OK;resultado" --> SetExitoPy[Registrar Resultado Exitoso]
    
    MarcarErrorPy --> GuardarBD
    SetExitoPy --> GuardarBD
    
    %% Registro en BD y Salida
    GuardarBD[("Insertar Registro en Tabla 'calculo'<br/>(Guardar Éxito o Fallo)")] --> MostrarSalida[/Mostrar Resultado o Mensaje de Error/]
    MostrarSalida --> Fin([Fin del Programa])

    %% Estilos en Blanco y Negro
    classDef bw fill:#fff,stroke:#000,color:#000,stroke-width:1.5px;

    class Inicio,CargarCat,MostrarCat,SeleccionarOp,ValidarOp,MostrarErrOp,Fin0,DeterminarAridad,LeerOpDos,LeerOpUno,ChequearTrig,LeerModo,ValidarJava,MarcarErrorJava,EjecutarJava,SetExitoJava,ValidarPython,EvaluarPython,MarcarErrorPy,SetExitoPy,GuardarBD,MostrarSalida,Fin bw;
