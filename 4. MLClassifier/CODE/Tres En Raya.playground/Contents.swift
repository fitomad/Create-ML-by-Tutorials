import Foundation
import CreateML

/**
 Creamos los metadatos del modelo
 
 - Returns: La estructura con toda la información del modelo
*/
func makeModelMetadata() -> MLModelMetadata
{
    var metadata = MLModelMetadata()
    
    metadata.author = "Adolfo"
    metadata.license = "MIT"
    metadata.version = "1.0"
    metadata.shortDescription = "Juego del 3 en Raya"
    metadata.additional = [
        "input" : "El estado del tablero",
        "output" : "Si X ganará con ese movimiento"
    ]
    
    return metadata
}

//
// Creación del modelo
//

let parsingOptions = MLDataTable.ParsingOptions(containsHeader: true, delimiter: ";")

if let datasetURL = URL(string: "/Users/adolfo/Desktop/TicTacToe.csv"),
    var dataTable = try? MLDataTable(contentsOf: datasetURL, options: parsingOptions)
{
    // Cambiamos el nombre de la columna de *resultados*
    dataTable.renameColumn(named: "classification", to: "X_Wins")
    
    // Creamos los juegos de datos para entrenamiento y evaluación
    let (trainingSet, evaluationSet) = dataTable.randomSplit(by: 0.70)
    
    // Creamos el modelo de clasificación
    if let classifier = try? MLClassifier(trainingData: trainingSet, targetColumn: "X_Wins")
    {
        // Probamos a evaluarlo...
        let evaluationMetricts = classifier.evaluation(on: evaluationSet)
        // ...y nos fijamos en la salida a ver qué tal ha ido.
        print(evaluationMetricts.debugDescription)
        
        // Guardamos el modelo en disco
        
        let modelInformation = makeModelMetadata()
        
        do
        {
            try classifier.write(toFile: "/Users/adolfo/Desktop/TicTac.mlmodel", metadata: modelInformation)
        }
        catch let error
        {
            print("No se ha podido guardar el modelo.\r\n\(error.localizedDescription)")
        }
    }
}
