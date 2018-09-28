//: [Previous](@previous)

import CreateML
import NaturalLanguage
import Foundation

if let reviewsFile = URL(string: "/Users/adolfo/Desktop/reviews_prepared.json"),
    let dataset = try? MLDataTable(contentsOf: reviewsFile)
{
    print("Reseñas cargadas.\r\nRegistros. \(dataset.size.rows)\r\n")
    
    let (trainingSet, otherSet) = dataset.randomSplit(by: 0.70, seed: 5)
    let (validationSet, evaluationSet) = otherSet.randomSplit(by: 0.66, seed: 5)
    
    let modelParameters = MLTextClassifier.ModelParameters(validationData: validationSet, algorithm: .maxEnt(revision: 1), language: NLLanguage.english)
    
    if let classifier = try? MLTextClassifier(trainingData: trainingSet, textColumn: "content", labelColumn: "rating", parameters: modelParameters)
    {
        let trainigAccuracy = (1 - classifier.trainingMetrics.classificationError) * 100
        let classificationAccuracy = (1 - classifier.validationMetrics.classificationError) * 100
        
        print("\r\nTraining (%): \(trainigAccuracy)")
        print("Validation (%): \(classificationAccuracy)")
        /*
        let evaluationMetrics = classifier.evaluation(on: evaluationSet)
        let evaluationAccuracy = (1 - evaluationMetrics.classificationError) * 100
        
        print("Evaluation (%): \(evaluationAccuracy)")
        print("Precisión:\r\n\(evaluationMetrics.precisionRecall)")
        print("Confusion:\r\n\(evaluationMetrics.confusion)")
        */
        do
        {
            try classifier.write(toFile: "/Users/adolfo/Desktop/SentimentReview2.mlmodel")
        }
        catch
        {
            print("No se puede guarda el modelo")
        }
        
    }
}
//: [Next](@next)
