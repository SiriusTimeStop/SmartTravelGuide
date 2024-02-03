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
            ReusablePostView(posts: $recentsPosts)
                .hAlign(.center)
                .vAlign(.center)
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
                .navigationTitle("Routes")
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
