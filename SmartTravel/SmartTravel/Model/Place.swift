//
//  Place.swift
//  MapRoutes
//
//  Created by itst on 16/10/2023.
//

import SwiftUI
import MapKit

struct Place: Identifiable{
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
