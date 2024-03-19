//
//  TravelType.swift
//  SmartTravel
//
//  Created by jackychoi on 28/2/2024.
//

import Foundation

enum TravelType: Int, CaseIterable, Identifiable{
    case Cultural
    case Ecotourism
    case Sightseeing
    case Extreme
    
    var id: Int {return rawValue}
    
    var description: String {
        switch self{
        case .Cultural: return "Cultural"
        case .Ecotourism: return "Ecology"
        case .Sightseeing: return "Sights"
        case .Extreme: return "Extreme"
        }
    }
    
    var imageName: String {
        switch self{
        case .Cultural: return "book.circle.fill"
        case .Ecotourism: return "mountain.2.circle.fill"
        case .Sightseeing: return "binoculars.circle.fill"
        case .Extreme: return "figure.run.circle.fill"
        }
    }
}
