//
//  PostTravelPlanView.swift
//  SmartTravel
//
//  Created by jackychoi on 2/2/2024.
//

import SwiftUI

struct PostTravelPlanView: View {
    @State private var recentsPosts: [Post] = []
    @State private var NewTravelPlan: Bool = false
    @State var selectTravelType: TravelType = .Cultural
    let roundRect = RoundedRectangle(cornerRadius: 25.0)
    
    var body: some View {
        NavigationStack{
            Text("Location")
                .font(.callout)
                .padding(.horizontal)
                .padding(.top,20)
                .hAlign(.leading)
            
                HStack{
                    Image(systemName: "mappin.and.ellipse.circle.fill")
                        .font(.title3)
                        .padding(.trailing,3)
                        .fontWeight(.bold)
                    
                    Text("Hong Kong, China")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding(.top,5)
                .padding(.horizontal)
                .hAlign(.leading)
                Text("Categories")
                    .font(.title3)
                    .padding(.horizontal)
                    .padding(.top)
                    .hAlign(.leading)
                ScrollView(.horizontal){
                    HStack{
                        ForEach(TravelType.allCases){
                            type in
                            VStack{
                                Button (action: {
                                    withAnimation (.spring()) {
                                        selectTravelType = type
                                    }
                                }, label: {
                                    Image(systemName: type.imageName)
                                        .padding(.leading,5)
                                    Text(type.description)
                                        .font(.system(size: 12,weight: .semibold))
                                        .padding(.trailing,5)
                                })
                            }
                            .frame(width: 100, height: 40)
                            .background(roundRect.fill(Color.white))
                            .overlay(roundRect.stroke(lineWidth: 1))
                            .cornerRadius(5)
                            .padding(.horizontal,3)
                            .foregroundColor(type == selectTravelType ? Color.init(hex: "#57BFD2",alpha: 1.0) : .gray)
                        }
                    }
                    .padding(.horizontal,12)
                    .padding(.bottom,10)
                }
                .scrollIndicators(.hidden)
                if selectTravelType == .Cultural{
//                    Text("Cultural Travel")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .hAlign(.leading)
//                        .padding(.leading,15)
//                        .padding(.top,15)
//                        .foregroundColor(.blue)
                    
                    CulturalReusablePostView()
                        .hAlign(.center)
                        .vAlign(.center)
                        .padding(10)
                }else if selectTravelType == .Ecotourism{
//                    Text("Ecotourism Travel")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .hAlign(.leading)
//                        .padding(.leading,15)
//                        .foregroundColor(.blue)
                    
                    EcotourismReusablePostView()
                        .hAlign(.center)
                        .vAlign(.center)
                        .padding(10)
                }else if selectTravelType == .Sightseeing{
//                    Text("Sightseeing Travel")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .hAlign(.leading)
//                        .padding(.leading,15)
//                        .foregroundColor(.blue)
                    
                    SightReusablePostView()
                        .hAlign(.center)
                        .vAlign(.center)
                        .padding(10)
                }else if selectTravelType == .Extreme{
//                    Text("Extreme Travel")
//                        .font(.callout)
//                        .fontWeight(.semibold)
//                        .hAlign(.leading)
//                        .padding(.leading,15)
//                        .foregroundColor(.blue)
                    
                    ExtremeReusablePostView()
                        .hAlign(.center)
                        .vAlign(.center)
                        .padding(10)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button{
                NewTravelPlan.toggle()
            }label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(13)
                    .background(.black,in: Circle())
            }
            .padding(15)
        }
        .fullScreenCover(isPresented: $NewTravelPlan){
            TravelPlanView{
                post in
                recentsPosts.insert(post, at: 0)
            }
        }
    }
}

#Preview {
    PostTravelPlanView()
}
