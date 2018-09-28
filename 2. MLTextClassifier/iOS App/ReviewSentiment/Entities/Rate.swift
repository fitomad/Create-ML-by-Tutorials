//
//  Rate.swift
//  ReviewSentiment
//
//  Created by Adolfo Vera Blasco on 26/09/2018.
//  Copyright © 2018 desappstre {estudio}. All rights reserved.
//

import Foundation

internal enum Rate: String
{
    case excelente = "5"
    case buena = "4"
    case normal = "3"
    case mala = "2"
    case nefasta = "1"
}

//
// MARK: - CustomStringConvertible Protocol
//

extension Rate: CustomStringConvertible
{
    var description: String
    {
        switch self
        {
            case .excelente:
                return "😍"
            case .buena:
                return "🙂"
            case .normal:
                return "😐"
            case .mala:
                return "☹️"
            case .nefasta:
                return "😡"
        }
    }
}
