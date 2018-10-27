import Foundation
import CreateML

// Carpeta con las imágenes de entrenamiento
let trainingPath = "/Users/adolfo/Desktop/Data/Training"
// Carpeta con las imágenes de validación
let validationPath = "/Users/adolfo/Desktop/Data/Evaluation"

if let trainingURL = URL(string: trainingPath), let validationURL = URL(string: validationPath)
{
    // DataSource de entrenamiento
    let trainingDataSource = MLImageClassifier.DataSource.labeledDirectories(at: trainingURL)
    // DataSource de validación
    let validationDataSource = MLImageClassifier.DataSource.labeledDirectories(at: validationURL)

    // Parámetros para entrenar el modelo
    let parameter = MLImageClassifier.ModelParameters(featureExtractor: MLImageClassifier.FeatureExtractorType.scenePrint(revision: 1),
                                                      validationData: validationDataSource,
                                                      maxIterations: 10,
                                                      augmentationOptions: [ .flip, .rotation ])

    // Creamos el modelo...
    if let classifier = try? MLImageClassifier(trainingData: trainingDataSource, parameters: parameter)
    {
        // ...y sus metadatos
        var modelMetadata = MLModelMetadata()
        
        modelMetadata.author = "Adolfo"
        modelMetadata.shortDescription = "The Big Bang Theory Image Classifier"
        modelMetadata.license = "MIT"
        modelMetadata.version = "1"
        
        modelMetadata.additional = [
            "data_description" : "10 imágenes para cada personaje (Penny, Sheldon, Leonard y Raj)",
            "image_format" : "JPEG"
        ]
        
        // Exportamos el modelo
        do
        {
            try classifier.write(toFile: "/Users/adolfo/Desktop/TBBTImageClassifier", metadata: modelMetadata)
        }
        catch
        {
            print("No se puede guardar el modelo")
        }
    }
}

