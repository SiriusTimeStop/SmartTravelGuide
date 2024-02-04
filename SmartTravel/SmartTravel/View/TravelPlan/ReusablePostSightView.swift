//
//  ReusablePostSightView.swift
//  SmartTravel
//
//  Created by jackychoi on 4/2/2024.
//

import SwiftUI
import Firebase

struct ReusablePostSightView: View {
    @Binding var posts: [Post]
    
    /// - View properties
    @State var isFetching: Bool = true
    
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false){
            LazyVStack{
                if isFetching{
                    ProgressView()
                        .padding(.top,30)
                }else{
                    if posts.isEmpty{
                        /// No post's found on firebase
                        Text("No Post's Found")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.top,30)
                    }else{
                        /// Displaying post
                        HStack{
                            Posts()
                                .padding()
                        }
                    }
                }
            }
        }
        .vAlign(.top)
        .refreshable {
            isFetching = true
            posts = []
            await fetchPosts()
        }
        
        .task {
            guard posts.isEmpty else{return}
            await fetchPosts()
        }
    }
    
    /// Displaying fetched post
    @ViewBuilder
    func Posts() -> some View{
        ForEach(posts){post in
            NavigationLink(destination: TravelDetailView(post: post)){
                PostCardView(post: post) { updatedPost in
                    
                } onDelete: {
                    
                }
            }
        }
    }
    
    /// - Fetching Post's
    func fetchPosts() async{
        do{
            var query: Query!
            query = Firestore.firestore().collection("Sightseeing Routes")
                .order(by: "publishedDate",descending: true)
                .limit(to: 100)
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            await MainActor.run(body: {
                posts = fetchedPosts
                isFetching = false
            })
        }catch{
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}