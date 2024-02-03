//
//  travalLocation.swift
//  SmartTravel
//
//  Created by jackychoi on 29/1/2024.
//

import Foundation
struct TravelLocation{
        var location = ["Hong Kong Museum of Art","Hong Kong Palace Museum","K11 MUSEA","M+","Tai Kwun","The Mills","Lam Tsuen Wishing Trees","Hong Kong Railway Museum","Che Kung Temple","Wong Tai Sin Temple","Hong Kong Museum of History","Hong Kong Museum of Coastal Defence","Tai O Fishing Village","Po Lin Monastery","Hong Kong Heritage Museum","Mai Po Nature Reserve","Shek O Country Park","Sunset Peak","Tai Lam Country Park","High Island Geo Trail","Tai Mo Shan","High Junk Peak Country Trail","Tai To Yan","Hok Tau Reservoirs","Tai Tam Reservoirs","Ma On Shan Country Park","Plover Cove Country Park","Shing Mun Reservoir","Wilson Trail","Ng Tung Chai","Disneyland Hong Kong","Ocean Park","Ngong Ping 360","Avenue of Stars","Star Ferry","Lan Kwai Fong","The Peak","Temple Street Night Market","Hong Kong Park","Cheung Chau","The Hong Kong Observation Wheel","Hong Kong Space Museum","Hong Kong Palace Museum","M+","Hong Kong Science Museum","Flyboarding","Rock Climbing","Discover Scuba Diving","Canyoning","Trampolines & Indoor Rock Climbing","Super Sports Park","Dirt Bike","Wakesurf","Kayaking","Paragliding","Skatepark","Ice Skating","Mountain Bike","Challenge Karting","AME Stadium"]
        
        var locationType = ["Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Cultural Tourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Ecotourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism","Sightseeing Tourism"," Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel","Extreme Travel"]
        
        var locationMoney = ["30","240","520","120","0","0","0","0","0","0","0","10","0","0","20","70","0","0","0","0","0","0","0","0","0","0","0","0","0","0","640","500","300","0","7","0","148","0","0","0","20","10","240","120","20","717","2000","1200","680","180","200","1500","320","150","2500","0","60","0","720","300"]
        
        var locationDistrict = ["Kowloon","Kowloon","Kowloon","Kowloon","Hong Kong Island","Hong Kong Island","New Territories","New Territories","New Territories","Kowloon","Kowloon","Hong Kong Island","New Territories","New Territories","New Territories","New Territories","Hong Kong Island","New Territories","New Territories","New Territories","New Territories","New Territories","New Territories","New Territories","Hong Kong Island","New Territories","New Territories","New Territories","New Territories","New Territories","New Territories","Hong Kong Island","New Territories","Kowloon","Kowloon","Hong Kong Island","Hong Kong Island","Kowloon","Hong Kong Island","Hong Kong Island","Hong Kong Island","Kowloon","Kowloon","Kowloon","Kowloon","Hong Kong Island","Kowloon","New Territories","New Territories","Hong Kong Island","Kowloon","New Territories","New Territories","New Territories","New Territories","Kowloon","Kowloon","New Territories","Kowloon","Kowloon"]
    
    func travelPlan() -> [String]{
        var travelLocation : [String] = []
        var number = Int.random(in: 1..<10)
        let randomName = location[number]
        travelLocation.append(randomName)
        let randomType = locationType[number]
        travelLocation.append(randomType)
        let randomMoney = locationMoney[number]
        travelLocation.append(randomMoney)
        let randomDistrict = locationDistrict[number]
        travelLocation.append(randomDistrict)
        
        return travelLocation
    }
}

