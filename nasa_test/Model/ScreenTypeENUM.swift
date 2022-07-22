//
//  ScreenTypeENUM.swift
//  nasa_test
//
//  Created by Dumitru Rahmaniuc on 22.07.2022.
//

import Foundation

enum ScreenType{
    case curiosity
    case opportunity
    case spirit
    
    var roverType: String{
        switch self {
        case .curiosity:
            return "Curiosity"
        case .opportunity:
            return "Opportunity"
        case .spirit:
            return "Spirit"
        }
    }
}
