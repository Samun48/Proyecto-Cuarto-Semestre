```mermaid

flowchart TD
    %% Entrada de Datos y Parámetros
    Inicio([Inicio]) --> SeleccionarFn[/Seleccionar Función a Graficar/]
    SeleccionarFn --> LeerParam[/Leer Parámetros de la Serie:<br/>x_min, x_max, paso y modo_angulo/]
    
    %% Validación de Rango
    LeerParam --> ValidarRango{"¿Rango Válido?<br/>(x_min < x_max y paso > 0)"}
    ValidarRango -- No --> MostrarErrParam[/Mostrar 'Parámetros Inválidos'/] --> FinErr([Fin])
    
    %% Generación de Puntos
    ValidarRango -- Sí --> SolicitarPuntos[Generar Serie de Puntos x, y]
    SolicitarPuntos --> RecibirPuntos[Recibir Conjunto de Puntos]
    
    %% Persistencia en Base de Datos (Transacción)
    RecibirPuntos --> IniciarTransaccion[("Iniciar Transacción BD<br/>Crear Registro de 'serie'")]
    IniciarTransaccion --> GuardarPuntos[("Guardar Puntos (x, y) en 'punto'<br/>(y = NULL si es indeterminado)")]
    GuardarPuntos --> CommitTransaccion[("Confirmar Transacción (Commit)")]
    
    %% Renderizado y Salida
    CommitTransaccion --> GenerarImagen[Generar Imagen PNG de la Gráfica<br/>desde los Datos de la BD]
    GenerarImagen --> MostrarResultado[/Mostrar o Guardar Archivo PNG/]
    MostrarResultado --> Fin([Fin del Programa])

    %% Estilos en Blanco y Negro (Bordes negros, fondo blanco, texto negro)
    classDef bw fill:#fff,stroke:#000,color:#000,stroke-width:1.5px;

    class Inicio,SeleccionarFn,LeerParam,ValidarRango,MostrarErrParam,FinErr,SolicitarPuntos,RecibirPuntos,IniciarTransaccion,GuardarPuntos,CommitTransaccion,GenerarImagen,MostrarResultado,Fin bw;
