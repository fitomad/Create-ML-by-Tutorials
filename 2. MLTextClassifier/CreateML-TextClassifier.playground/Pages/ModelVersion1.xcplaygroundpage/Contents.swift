import CreateML
import Foundation

if let reviewsFile = URL(string: "/Users/adolfo/Desktop/reviews.json"),
   let dataset = try? MLDataTable(contentsOf: reviewsFile)
{
    print("Reseñas cargadas.\r\nRegistros. \(dataset.size.rows)\r\n")
    
    let (trainingSet, otherSet) = dataset.randomSplit(by: 0.70, seed: 5)
    let (validationSet, evaluationSet) = otherSet.randomSplit(by: 0.66, seed: 5)
    
    if let classifier = try? MLTextClassifier(trainingData: trainingSet, textColumn: "title", labelColumn: "rating")
    {
        let trainigAccuracy = (1 - classifier.trainingMetrics.classificationError) * 100
        let classificationAccuracy = (1 - classifier.validationMetrics.classificationError) * 100
        
        print("\r\nTraining (%): \(trainigAccuracy)")
        print("Validation (%): \(classificationAccuracy)")
        
        do
        {
            try classifier.write(toFile: "/Users/adolfo/Desktop/SentimentReview.mlmodel")
        }
        catch 
        {
            print("No se puede guarda el modelo")
        }
        
    }
}
