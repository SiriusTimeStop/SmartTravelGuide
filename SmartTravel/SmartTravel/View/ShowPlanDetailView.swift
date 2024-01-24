//
//  ShowPlanDetailView.swift
//  MapRoutes
//
//  Created by jackychoi on 2/12/2023.
//

import SwiftUI

struct ShowPlanDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var plan: FetchedResults<Attraction>.Element
    
    @State private var attraction1 = ""
    @State private var attraction2 = ""
    @State private var attraction3 = ""
    @State private var attraction4 = ""
    @State private var level = ""
    @State private var cost = ""
    var destinationPlace = locationShow()
    
    var body: some View {
        ScrollView{
            Group{
                if plan.attraction1 == "Ngong Ping 360" {
                    Image("NgongPing360")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 370)
                        .cornerRadius(20)
                        .padding(.horizontal,30)
                        .padding(.bottom,10)
                    
                    Text(plan.attraction1!)
                        .font(.system(size: 20,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal,30)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    HStack{
                       Image(systemName: "mappin.and.ellipse")
                            .frame(width: 9, height: 12)
                            
                        Text("Hong kong")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom)
                    
                    Text(destinationPlace.nameDetail[0][0])
                        .padding(.horizontal,30)
                        .padding(.bottom)
                    
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                    
                    Image("BigBuddha")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 370)
                        .cornerRadius(20)
                        .padding(.horizontal,30)
                        .padding(.bottom,10)
                    
                    Text(plan.attraction2!)
                        .font(.system(size: 20,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal,30)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    HStack{
                       Image(systemName: "mappin.and.ellipse")
                            .frame(width: 9, height: 12)
                            
                        Text("Hong kong")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom)
                    
                    Text(destinationPlace.nameDetail[0][1])
                        .padding(.horizontal,30)
                        .padding(.bottom)
                    
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                    
                    Image("HongKongDisneyland1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 370)
                        .cornerRadius(20)
                        .padding(.horizontal,30)
                        .padding(.bottom,10)
                    
                    Text(plan.attraction3!)
                        .font(.system(size: 20,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal,30)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    HStack{
                       Image(systemName: "mappin.and.ellipse")
                            .frame(width: 9, height: 12)
                            
                        Text("Hong kong")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom)
                    
                    Text(destinationPlace.nameDetail[0][2])
                        .padding(.horizontal,30)
                        .padding(.bottom)
                    
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                    
                    Image("VictoriaPeak")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 344, height: 370)
                        .cornerRadius(20)
                        .padding(.horizontal,30)
                        .padding(.bottom,10)
                    
                    Text(plan.attraction4!)
                        .font(.system(size: 20,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal,30)
                        .frame(maxWidth: .infinity,alignment: .leading)
                    
                    HStack{
                       Image(systemName: "mappin.and.ellipse")
                            .frame(width: 9, height: 12)
                            
                        Text("Hong kong")
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding(.bottom)
                    
                    Text(destinationPlace.nameDetail[0][3])
                        .padding(.horizontal,30)
                        .padding(.bottom)
                }
            }
            
            Group{
                if plan.attraction1 == "Tian Tan Buddha"{
                    Image("BigBuddha")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 344, height: 370)
                         .cornerRadius(20)
                         .padding(.horizontal,10)
                         .padding(.bottom,10)
                     
                    Text(plan.attraction1!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[1][0])
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                     
                     Image("OceanPark")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 344, height: 370)
                          .cornerRadius(20)
                          .padding(.horizontal,10)
                          .padding(.bottom,10)
                      
                    Text(plan.attraction2!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[1][1])
                        .padding(.horizontal)
                        .padding(.bottom)
                      
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                     
                     Image("StarFerry")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 344, height: 370)
                          .cornerRadius(20)
                          .padding(.horizontal,10)
                          .padding(.bottom,10)
                      
                    Text(plan.attraction3!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[1][2])
                        .padding(.horizontal)
                        .padding(.bottom)
                      
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                     
                     Image("AvenueOfTheStars")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 344, height: 370)
                          .cornerRadius(20)
                          .padding(.horizontal,10)
                          .padding(.bottom,10)
                      
                    Text(plan.attraction4!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[1][3])
                        .padding(.horizontal)
                        .padding(.bottom)
                    
                }
            }
            
            Group{
                if plan.attraction1 == "Hong Kong Park"{
                    Image("HongKongPark")
                         .resizable()
                         .aspectRatio(contentMode: .fill)
                         .frame(width: 344, height: 370)
                         .cornerRadius(20)
                         .padding(.horizontal,10)
                         .padding(.bottom,10)
                     
                    Text(plan.attraction1!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[2][0])
                        .padding(.horizontal)
                        .padding(.bottom)
                     
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                     
                     Image("StarFerry")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 344, height: 370)
                          .cornerRadius(20)
                          .padding(.horizontal,10)
                          .padding(.bottom,10)
                      
                    Text(plan.attraction2!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[2][1])
                        .padding(.horizontal)
                        .padding(.bottom)
                      
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                     
                     Image("HongKongMuseumOfHistory")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 344, height: 370)
                          .cornerRadius(20)
                          .padding(.horizontal,10)
                          .padding(.bottom,10)
                      
                    Text(plan.attraction3!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[2][2])
                        .padding(.horizontal)
                        .padding(.bottom)
                      
                    VStack{
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                        
                        Rectangle()
                            .fill(.gray)
                            .frame(width: 3,height: 100)
                        
                        Circle()
                            .fill(.gray)
                            .frame(width: 18,height: 18)
                    }
                    .padding(.bottom)
                     
                     Image("AvenueOfTheStars")
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          .frame(width: 344, height: 370)
                          .cornerRadius(20)
                          .padding(.horizontal,10)
                          .padding(.bottom,10)
                      
                    Text(plan.attraction4!)
                        .font(.system(size: 16,weight: .bold))
                        .foregroundColor(.black)
                        .padding(.horizontal)
                    
                    Text(destinationPlace.nameDetail[2][3])
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
        }
    }
}
