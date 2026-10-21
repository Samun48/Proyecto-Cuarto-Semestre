```mermaid

flowchart TD
    %% Nodos de Inicio y Fin
    Inicio([Inicio]) --> Menu[/Mostrar Menú de Calculadora/]
    
    %% Bucle del Menú
    Menu --> LeerOpcion[/Leer opción del usuario/]
    LeerOpcion --> EvaluarOpcion{Evaluar Opción}

    %% Rama 1: Operaciones Básicas (Java)
    EvaluarOpcion -- "1 a 4: \n(Suma, Resta, Mult, Div)" --> PedirNum[/Pedir Número 1 y Número 2/]
    PedirNum --> ProcesoJava[Procesar en Java: \nMétodos nativos de Java]
    ProcesoJava --> MostrarResJava[/Mostrar Resultado/]

    %% Rama 2: Funciones Trigonométricas (Python)
    EvaluarOpcion -- "5 a 7: \n(Sen, Cos, Tan)" --> PedirAngulo[/Pedir Ángulo en Grados/]
    PedirAngulo --> LlamadaPython[Java invoca script Python \nvía ProcessBuilder]
    LlamadaPython --> ProcesoPython[Python calcula función \ntrigonométrica]
    ProcesoPython --> LeerSalida[Java lee la salida \nestándar de Python]
    LeerSalida --> MostrarResPython[/Mostrar Resultado/]

    %% Rama 3: Salir
    EvaluarOpcion -- "8: Salir" --> Fin([Fin del Programa])

    %% Decisión para continuar o terminar
    MostrarResJava --> Continuar{¿Desea realizar \notra operación?}
    MostrarResPython --> Continuar
    
    Continuar -- "Sí" --> Menu
    Continuar -- "No" --> Fin

    %% Estilos para mejorar la visualización
    classDef startEnd fill:#f9d0c4,stroke:#333,stroke-width:2px;
    classDef io fill:#d4e6f1,stroke:#333,stroke-width:1px;
    classDef process fill:#d5f5e3,stroke:#333,stroke-width:1px;
    classDef decision fill:#fcf3cf,stroke:#333,stroke-width:2px;

    class Inicio,Fin startEnd;
    class Menu,LeerOpcion,PedirNum,PedirAngulo,MostrarResJava,MostrarResPython io;
    class ProcesoJava,LlamadaPython,ProcesoPython,LeerSalida process;
    class EvaluarOpcion,Continuar decision;
