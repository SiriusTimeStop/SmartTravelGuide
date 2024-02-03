//
//  post.swift
//  SmartTravel
//
//  Created by jackychoi on 29/1/2024.
//

import SwiftUI
import FirebaseFirestoreSwift

//MARK: post model
struct Post : Identifiable,Codable{
    @DocumentID var id: String?
    var location1: String
    var location2: String
    var location3: String
    var locationDistrict1: String
    var locationDistrict2: String
    var locationDistrict3: String
    var locationType1: String
    var locationType2: String
    var locationType3: String
    var locationRandomType: String
    var locationMoney1: String
    var locationMoney2: String
    var locationMoney3: String
    var locationTotoalMoney: String
    var publishedDate: Date = Date()
    var liskedIDs: [String] = []
    var dislikedIDs: [String] = []
    
    //MARK: Basic user info
    var userName: String
    var userUID: String
    var userProfileURL: URL
    
    enum CodingKeys: CodingKey{
        case id
        case location1
        case location2
        case location3
        case locationDistrict1
        case locationDistrict2
        case locationDistrict3
        case locationType1
        case locationType2
        case locationType3
        case locationRandomType
        case locationMoney1
        case locationMoney2
        case locationMoney3
        case locationTotoalMoney
        case publishedDate
        case liskedIDs
        case dislikedIDs
        case userName
        case userUID
        case userProfileURL
    }
}
