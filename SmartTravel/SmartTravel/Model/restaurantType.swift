//
//  restaurantType.swift
//  MapRoutes
//
//  Created by jackychoi on 21/10/2023.
//

import Foundation

enum RestaurantType: Int, CaseIterable, Identifiable{
    case Starbucks
    case Ramen
    case Rice
    
    var id: Int {return rawValue}
    
    var description: String {
        switch self{
        case .Starbucks: return "Starbucks"
        case .Ramen: return "Ajisen Ramen"
        case .Rice: return "Moon Thai Express"
        }
    }
    
    var imageName: String {
        switch self{
        case .Starbucks: return "Starbucks"
        case .Ramen: return "Ajisen Ramen"
        case .Rice: return "Moon Thai Express"
        }
    }
}
