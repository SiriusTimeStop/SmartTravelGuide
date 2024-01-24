//
//  RidesType.swift
//  MapRoutes
//
//  Created by jackychoi on 22/10/2023.
//

import Foundation

enum RidesType: Int, CaseIterable, Identifiable{
    case luxury
    case normal
    case poor
    
    var id: Int {return rawValue}
    
    var description: String {
        switch self{
        case .luxury: return "Luxury"
        case .normal: return "Normal"
        case .poor: return "Poor"
        }
    }
    
    var imageName: String {
        switch self{
        case .luxury: return "HongKongDisneyland1"
        case .normal: return "OceanPark"
        case .poor: return "StarFerry"
        }
    }
    
    var routePrice: String{
        switch self{
        case .luxury: return "2700.0"
        case .normal: return "1000.0"
        case .poor: return "600.0"
        }
    }
}


