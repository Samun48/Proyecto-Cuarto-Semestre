classDiagram
    %% ==========================================
    %% MODELOS DE DATOS (Entidades de SQLite)
    %% ==========================================
    class OperacionInfo {
        +int id
        +String simbolo
        +String tipo
        +int aridad
    }

    class Calculo {
        +double operandoA
        +Double operandoB
        +String modoAngulo
        +Double resultado
        +boolean exito
        +String mensajeError
    }

    class Serie {
        +int operacionId
        +double xMin
        +double xMax
        +double paso
        +String modoAngulo
    }

    class Punto {
        +double x
        +Double y
    }

    %% ==========================================
    %% JERARQUÍA DE OPERACIONES (POO2)
    %% ==========================================
    class IOperacion {
        <<interface>>
        +calcular(double a, double b) double
    }

    class OperacionBasica {
        <<abstract>>
        #String simbolo
        +calcular(double a, double b) double
    }

    class Suma { +calcular(double a, double b) double }
    class Resta { +calcular(double a, double b) double }
    class Multiplicacion { +calcular(double a, double b) double }
    class Division { +calcular(double a, double b) double }

    IOperacion <|.. OperacionBasica
    OperacionBasica <|-- Suma
    OperacionBasica <|-- Resta
    OperacionBasica <|-- Multiplicacion
    OperacionBasica <|-- Division

    %% ==========================================
    %% EXCEPCIONES PROPIAS
    %% ==========================================
    class CalculadoraException { <<exception>> }
    class DivisionCeroException { <<exception>> }
    CalculadoraException <|-- DivisionCeroException

    %% ==========================================
    %% INTEGRACIÓN Y PERSISTENCIA
    %% ==========================================
    class PythonBridge {
        +ejecutarTrig(String fn, double val, String modo) String
        +ejecutarSerie(String fn, double min, double max, double paso) List~Punto~
        +generarGrafica(String dbPath, int serieId, String outPNG) boolean
    }

    class CalculadoraDAO {
        -Connection conexion
        +guardarCalculo(Calculo calc) boolean
        +guardarSerie(Serie serie, List~Punto~ puntos) int
        +obtenerHistorial() List~Calculo~
    }

    %% ==========================================
    %% CLASE PRINCIPAL / CONTROLADOR
    %% ==========================================
    class GestorCalculadora {
        -CalculadoraDAO dao
        -PythonBridge python
        +iniciarMenu()
        -procesarBasica(IOperacion op)
        -procesarTrigonometrica(String fn)
    }

    %% ==========================================
    %% RELACIONES CLAVE
    %% ==========================================
    GestorCalculadora --> IOperacion : "Ejecuta (Polimorfismo)"
    GestorCalculadora --> PythonBridge : "Delega a ProcessBuilder"
    GestorCalculadora --> CalculadoraDAO : "Persiste con JDBC"
    CalculadoraDAO ..> Calculo : "Inserta/Consulta"
    CalculadoraDAO ..> Serie : "Inserta (Transacción)"
    Serie "1" *-- "1..*" Punto : "Contiene"
    Division ..> DivisionCeroException : "Lanza"
