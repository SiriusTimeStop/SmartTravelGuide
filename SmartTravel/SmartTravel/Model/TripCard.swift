//
//  TripCard.swift
//  CarouselScroll
//
//  Created by jackychoi on 2/12/2023.
//

import SwiftUI

struct TripCard: Identifiable, Hashable {
    var id: UUID = .init()
    var image: String
}

var tripCards1: [TripCard] = [
    .init(image: "HongKongDisneyland1"),
    .init(image: "HongKongDisneyland2"),
    .init(image: "HongKongDisneyland3"),
    .init(image: "HongKongDisneyland4")
]

