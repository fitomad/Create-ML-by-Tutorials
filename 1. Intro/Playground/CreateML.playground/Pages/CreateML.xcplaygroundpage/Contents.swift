import CreateML
import Foundation

let reviewsFile = URL(string: "/Users/adolfo/Desktop/reviews.json")!
let canadaFile = URL(string: "/Users/adolfo/Desktop/reviews_canada.json")!

if var reviewsDataset = try? MLDataTable(contentsOf: reviewsFile),
   var canadaDataset = try? MLDataTable(contentsOf: canadaFile)
{
    print("\nConjunto de datos mundial: \(reviewsDataset.size.rows) campos")
    print("Conjunto de datos de Canadá: \(canadaDataset.size.rows)  campos")
    
    if reviewsDataset.isValid && canadaDataset.isValid
    {
        print("\nLos dataset son válidos")
    }
    
    // Preparamos el conjunto de datos de Canada para que
    // coincida con el formato `json` que se espera.
    // Para ello debemos renombrar el campo `application_id`
    // que pasará a ser `appID`
    // También hay que eliminar la columna `created_at` que
    // no aparece.
    canadaDataset.renameColumn(named: "application_id", to: "appID")
    canadaDataset.removeColumn(named: "created_at")
    
    // Ahora el conjunto de datos de Canadá tiene el
    // mismo formato que el global por lo que ya podemos
    // añadirlo.
    reviewsDataset.append(contentsOf: canadaDataset)
    print("\nConjunto de datos mundial tras la unión: \(reviewsDataset.size.rows) campos")
    
    //
    // Ahora vamos a preparar los datos para los procesos de...
    //
    // * Training (70 %)
    // * Validation (20 %)
    // * Evaluation (10 %)
    //
    let (trainingSet, restSet) = reviewsDataset.randomSplit(by: 0.70, seed: 5)
    let (validationSet, evaluationSet) = restSet.randomSplit(by: 0.66, seed: 5)
    
    print("\nTraining: \(trainingSet.size.rows)")
    print("Validation: \(validationSet.size.rows)")
    print("Evaluation: \(evaluationSet.size.rows)")
}

//
// Ahora vamos a ver las operaciones de eliminación
// de duplicados y de registros que no tienen los campos
// esperados
//
// Vamos a usar un archivo `json` con sólo 8 registros
// para que puedas abrirlo y ver de un vistazo los duplicaos
// y los errores en el formato.
//
// En este caso el archivo está incluido como *resource*
// del playground.
//


let fileApps = Bundle.main.url(forResource: "apps", withExtension: "json")!
if var appsDataset = try? MLDataTable(contentsOf: fileApps), appsDataset.isValid
{
    print("\nApps disponibles: \(appsDataset.size.rows)")
    
    //
    // Aunque también podemos rellenar los campos
    // que faltan con un valor por defecto.
    //
    // A algunos registros les falta el campo `desc`
    //
    
    appsDataset = appsDataset.fillMissing(columnNamed: "desc", with: MLDataValue.string("The Unknown App"))
    
    //
    // He incluido a **Facebook** dos veces
    //
    appsDataset = appsDataset.dropDuplicates()
    print("Apps disponibles tras eliminar duplicados: \(appsDataset.size.rows)")
    
    //
    // He incluido 2 registos a los que les faltan campos
    // A uno le falta el campo `name` y al otro el `appID`
    //
    appsDataset = appsDataset.dropMissing()
    print("Apps disponibles tras eliminar registros incompletos: \(appsDataset.size.rows)")
    
    print(appsDataset.description)
    
    //
    // Podemos coger los N primeros registros
    // de la tabla...
    //
    let prefixDataset = appsDataset.prefix(2)
    print(prefixDataset.description)
    
    //
    // ... o los N últimos registros.
    //
    let suffixDataset = appsDataset.suffix(2)
    print(suffixDataset.description)
    
}
