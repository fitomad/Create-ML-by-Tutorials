//
//  ViewController.swift
//  ReviewSentiment
//
//  Created by Adolfo Vera Blasco on 26/09/2018.
//  Copyright © 2018 desappstre {estudio}. All rights reserved.
//

import UIKit
import NaturalLanguage

internal class ViewController: UIViewController 
{
    ///
    @IBOutlet private weak var labelTitle: UILabel!
    /// Donde escribimos la reseña
    @IBOutlet private weak var textviewReview: UITextView!
    /// Aquí mostramos la valoración predecida 
    /// por nuestro modelo
    @IBOutlet private weak var labelRating: UILabel!
    ///
    @IBOutlet private weak var buttonPredict: UIButton!

    //
    // MARK: - Life Cycle
    //

    override internal func viewDidLoad() 
    {
        super.viewDidLoad()
        
        self.applyTheme()
    }

    //
    // MARK: - Private Methods
    //

    /**
        Aspecto visual de la vista
    */
    private func applyTheme() -> Void
    {
        guard let textColor = UIColor(named: "TextColor"),
              let backgroundColor = UIColor(named: "BackgroundColor")
        else
        {
            return
        }
        
        self.labelTitle.textColor = textColor

        self.buttonPredict.backgroundColor = backgroundColor
        self.buttonPredict.tintColor = UIColor.white
        self.buttonPredict.layer.cornerRadius = 8.0
        self.buttonPredict.layer.masksToBounds = true
    }

    /**

    */

    //
    // MARK: - Actions
    //
    
    /**
        Al pulsar el botón instanciamos el modelo
        y le pedimos nos diga que valoración puede
        hacer el usuario en base a su reseña.
    */
    @IBAction private func handlePredictButtoTap(sender: UIButton) -> Void
    {
        self.labelRating.text = ""

        guard let model = try? NLModel(mlModel: SentimentReview().model),
              let review = self.textviewReview.text
        else
        {
            return
        }
        
        if let rating = model.predictedLabel(for: review), let rate = Rate(rawValue: rating)
        {
            self.labelRating.text = "(\(rating))\(rate)"
        }
    }
}

