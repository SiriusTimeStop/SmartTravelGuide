//
//  locationShow.swift
//  MapRoutes
//
//  Created by jackychoi on 2/11/2023.
//

import Foundation
struct LocationShow{
    var latitude = [[22.289006,22.254188,22.312771,22.275822],[22.254188,22.234632,22.293771,22.293425],[22.277542,22.293771,22.301939,22.293425]]
    
    var longitude = [[113.940964,113.905016,114.041931,114.145523],[113.905016,114.17217,114.168748,114.175101],[114.161524,114.168748,114.177400,114.175101]]

    var nameForLocation = [["Ngong Ping 360","Tian Tan Buddha","Hong Kong Disneyland","Victoria Peak"],["Tian Tan Buddha","Ocean Park","Star Ferry","Avenue Of The Stars"],["Hong Kong Park","Star Ferry","Hong Kong Museum Of History","Avenue Of The Stars"]]
    
    var nameImage = [["NgongPing360","BigBuddha","HongKongDisneyland","VictoriaPeak"],["BigBuddha","OceanPark","StarFerry","AvenueOfTheStars"],["HongKongPark","StarFerry","HongKongMuseumOfHistory","AvenueOfTheStars"]]
    
    var nameDetail = [["The Ngong Ping Cable Car ride connects Tung Chung with Ngong Ping and offers the serene panorama of Lantau, Hong Kong. Ngong Ping Terminal is right next to Ngong Ping Village - the best starting point to reach other Hong Kong attractions such as the Big Buddha, Po Lin Monastery, Tai O fishing village, etc. Ngong Ping Village is the home to recreation, shopping, and four entertaining themed attractions loved by locals and tourists",
        "The Big Buddha, also known as Tian Tan Buddha, is famed as the most iconic attraction of Lantau. Sitting next to the Po Lin Monastery, it is only a 10-minute walk away from Ngong Ping Village.The majestic outdoor bronze Buddha statue sits solemnly atop the peak of Mount Muk Yue. It is seated south and facing North towards Beijing, the capital of China. Divided into two parts, the statue’s body is 26.4m tall and 34m in total measuring from the lotus throne and the base. It was cast with 250 tonnes of bronze and built over 12 years.",
        "Hong Kong Disneyland (Chinese: 香港迪士尼樂園) (abbreviated HKDL; also known as HK Disneyland) is a theme park located on reclaimed land in Penny's Bay, Lantau Island, Hong Kong. It is the first Disneyland in Asia outside of Japan.The Hong Kong Disneyland is located inside the Hong Kong Disneyland Resort and it is owned and managed by Hong Kong International Theme Parks. It is the largest theme park in Hong Kong.",
        "Victoria Peak, known simply as The Peak, is a must-see Hong Kong destination — both day and night — offering iconic views of skyscraper-flanked Victoria Harbour, Kowloon peninsula and craggy mountain peaks. Instagram buffs often visit at twilight to capture stunning images of the city's illuminated skyline, or photograph the area's rich flora and fauna and historic buildings while taking a relaxing hike along the tree-lined Peak Circle Walk."],
                      ["The Big Buddha, also known as Tian Tan Buddha, is famed as the most iconic attraction of Lantau. Sitting next to the Po Lin Monastery, it is only a 10-minute walk away from Ngong Ping Village.The majestic outdoor bronze Buddha statue sits solemnly atop the peak of Mount Muk Yue. It is seated south and facing North towards Beijing, the capital of China. Divided into two parts, the statue’s body is 26.4m tall and 34m in total measuring from the lotus throne and the base. It was cast with 250 tonnes of bronze and built over 12 years.",
                       "Ocean Park, situated on the southern side of Hong Kong Island, is Hong Kong's premier educational theme park. The current park covers more than 915,000 square metres of land and features a diverse selection of world-class animal attractions, thrill rides and shows divided between The Waterfront and The Summit. ",
                       "Throughout Hong Kong’s history, the city’s advance has been etched into the singular skylines that have grown on both sides of Victoria Harbour. As gleaming towers rose like phoenixes from the memories of historical architecture, there has been one constant – the Star Ferry – which has voyaged between the Kowloon Peninsula’s southern tip to Hong Kong Island for more than 120 years",
                       "The Avenue of Stars is the eastern node of several tourist attractions along the Tsim Sha Tsui waterfront. In addition to the promenade and New World Centre, a number of attractions exist including the Museum of Art, Space Museum, Cultural Centre and the Clock Tower."],
                      ["A hillside oasis squeezed between Central and Admiralty, Hong Kong Park was built in 1991 over part of the former Victoria Barracks. Terraced landscaping connects tree-lined pathways with various family-friendly attractions such as its fountain plaza, waterfall, playground, aviary and museum.",
                       "Throughout Hong Kong’s history, the city’s advance has been etched into the singular skylines that have grown on both sides of Victoria Harbour. As gleaming towers rose like phoenixes from the memories of historical architecture, there has been one constant – the Star Ferry – which has voyaged between the Kowloon Peninsula’s southern tip to Hong Kong Island for more than 120 years",
                       "The Hong Kong Museum of History is a public museum that preserves Hong Kong's historical and cultural heritage. It is located next to the Hong Kong Science Museum, in Tsim Sha Tsui East, Kowloon, Hong Kong. The collections of the museum encompass natural history, archaeology, ethnography and local history.",
                       "The Avenue of Stars is the eastern node of several tourist attractions along the Tsim Sha Tsui waterfront. In addition to the promenade and New World Centre, a number of attractions exist including the Museum of Art, Space Museum, Cultural Centre and the Clock Tower."]]
    
    
    func count() -> Int{
        return latitude[0].count
    }
}
