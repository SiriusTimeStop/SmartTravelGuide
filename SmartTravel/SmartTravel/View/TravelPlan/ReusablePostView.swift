//
//  ReusablePostView.swift
//  SmartTravel
//
//  Created by jackychoi on 3/2/2024.
//

import SwiftUI
import Firebase

struct ReusablePostView: View {
    var basedOnUID: Bool = false
    var uid: String = ""
    @Binding var posts: [Post]
    
    /// - View properties
    @State private var isFetching: Bool = true
    
    @State private var paginationDoc: QueryDocumentSnapshot?
    
    var body: some View {
        /// - 1. horizontal
        ScrollView(.vertical,showsIndicators: false){
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
                            .padding()
                    }else{
                        /// 2. Displaying post HStack
                        
                            Posts()
                                .padding(5)
                        
                    }
                }
            }
        }
        .vAlign(.top)
        .refreshable {
            /// - Scroll to refresh
            guard !basedOnUID else{return}
            isFetching = true
            posts = []
            paginationDoc = nil
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
                    withAnimation(.easeInOut(duration: 0.25)){
                        posts.removeAll{post.id == $0.id}
                    }
                }
                .onAppear{
                    if post.id == posts.last?.id && paginationDoc != nil{
                        Task{await fetchPosts()}
                    }
                }
            }
            Divider()
                .padding(.horizontal,-15)
        }
    }
    
    /// - Fetching Post's
    func fetchPosts() async{
        do{
            var query: Query!
            if let paginationDoc{
                query = Firestore.firestore().collection("Routes")
                    .order(by: "publishedDate",descending: true)
                    .start(afterDocument: paginationDoc)
                    .limit(to: 100)
            }else{
                query = Firestore.firestore().collection("Routes")
                    .order(by: "publishedDate",descending: true)
                    .limit(to: 100)
            }
            
            /// - new query for uid based document fetch
            /// - simply filter
            if basedOnUID{
                query = query
                    .whereField("userUID", isEqualTo: uid)
            }
            let docs = try await query.getDocuments()
            let fetchedPosts = docs.documents.compactMap { doc -> Post? in
                try? doc.data(as: Post.self)
            }
            await MainActor.run(body: {
                posts.append(contentsOf: fetchedPosts)
                paginationDoc = docs.documents.last
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
