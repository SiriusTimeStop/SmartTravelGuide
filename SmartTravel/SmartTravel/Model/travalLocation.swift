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
    
    var locationMoney = ["30","240","520","120","0","0","0","0","0","0","0","10","0","0","20","80","0","0","0","0","0","0","0","0","0","0","0","0","0","0","640","500","300","0","7","0","148","0","0","0","20","10","240","120","20","717","2000","1200","680","180","200","1500","320","150","2500","0","60","0","720","300"]
    
    var locationDistrict = ["Kowloon","Kowloon","Kowloon","Kowloon","Hong Kong Island","Hong Kong Island","New Territories","New Territories","New Territories","Kowloon","Kowloon","Hong Kong Island","New Territories","New Territories","New Territories","New Territories","Hong Kong Island","New Territories","New Territories","New Territories","New Territories","New Territories","New Territories","New Territories","Hong Kong Island","New Territories","New Territories","New Territories","New Territories","New Territories","New Territories","Hong Kong Island","New Territories","Kowloon","Kowloon","Hong Kong Island","Hong Kong Island","Kowloon","Hong Kong Island","Hong Kong Island","Hong Kong Island","Kowloon","Kowloon","Kowloon","Kowloon","Hong Kong Island","Kowloon","New Territories","New Territories","Hong Kong Island","Kowloon","New Territories","New Territories","New Territories","New Territories","New Territories","Kowloon","New Territories","Kowloon","Kowloon"]
    
    var locationLatitude = [
        "22.29360","22.30169","22.29415","22.30093","22.28139","22.37536","22.45629","22.44759","22.37339","22.34270","22.30185","22.28175","22.25232","22.25547","22.37663","22.49505","22.23606","22.25722","22.39297","22.36240","22.41666","22.29580","22.46634","22.49140","22.25790","22.40464","22.51267","22.38499","22.25782","22.43333","22.312771","22.24666","22.29010","22.293028","22.28703","22.28104","22.27015","22.30648","22.27692","22.20166","22.28526","22.29424","22.30169","22.30093","22.30100","22.24379","22.34949","22.38205","22.51288","22.29242","22.31786","22.47673","22.38165","22.38888","22.37275","22.31440","22.31945","22.25663","22.31152","22.29741"]
    
    var locationLongitude = [
        "114.17211","114.15527","114.17392","114.15938","114.15397","114.11017","114.14270","114.16434","114.18285","114.19325","114.17725","114.23566","113.86611","113.90809","114.18562","114.03393","114.23982","113.95278","114.04926","114.37175","114.11666","114.28583","114.13333","114.18140","114.21165","114.25021","114.25209","114.14166","114.19744","114.13333","114.041931","114.17572","113.93891","114.174042","114.16116","114.15549","114.14967","114.16999","114.16082","114.02716","114.16165","114.17191","114.15527","114.15938","114.17769","114.18294","114.16921","114.27526","114.20759","114.20691","114.15555","114.09591","114.27573","114.28053","114.37748","114.26024","114.20855","113.98442","114.17883","114.17376"]
    
}

enum ProductType: String,CaseIterable{
    case iphone = "iPhone"
    case ipad = "iPad"
    case macbook = "MacBook"
    case desktop = "Mac Desktop"
    case appleWatch = "Apple Watch"
    case airpods = "Airpods"
}

