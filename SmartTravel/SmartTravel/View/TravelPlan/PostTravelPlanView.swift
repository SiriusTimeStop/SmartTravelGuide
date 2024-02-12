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
    
    var body: some View {
        NavigationStack{
            ScrollView{
                Text("Cultural Travel")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .hAlign(.leading)
                    .padding(.leading,15)
                    .padding(.top,15)
                    .foregroundColor(.blue)
                
                ReusablePostView()
                    .hAlign(.center)
                    .vAlign(.center)
                
                Text("Ecotourism Travel")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .hAlign(.leading)
                    .padding(.leading,15)
                    .foregroundColor(.blue)
                
                EcotourismReusablePostView()
                    .hAlign(.center)
                    .vAlign(.center)
                
                Text("Sightseeing Travel")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .hAlign(.leading)
                    .padding(.leading,15)
                    .foregroundColor(.blue)
                
                SightReusablePostView()
                    .hAlign(.center)
                    .vAlign(.center)
                
                Text("Extreme Travel")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .hAlign(.leading)
                    .padding(.leading,15)
                    .foregroundColor(.blue)
                
                ExtremeReusablePostView()
                    .hAlign(.center)
                    .vAlign(.center)
            }
            .navigationTitle("Routes")
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
