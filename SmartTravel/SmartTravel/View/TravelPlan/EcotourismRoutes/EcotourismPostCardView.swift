//
//  EcotourismPostCardView.swift
//  SmartTravel
//
//  Created by jackychoi on 12/2/2024.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseStorage

struct EcotourismPostCardView: View {
    var post: Post
    /// - Callbacks
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()
    
    //MARK: view properties
    @AppStorage("user_UID") private var userUID: String = ""
    @State private var docListner: ListenerRegistration?

    var body: some View {
        HStack(alignment: .top, spacing: 12){
//            WebImage(url: post.userProfileURL)
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 35, height: 35)
//                .clipShape(Circle())
            
            VStack(alignment:.leading,spacing: 6){
//                Text(post.userName)
//                    .font(.callout)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.black)
//                Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
//                    .font(.caption2)
//                    .foregroundColor(.gray)
//                Text(post.location1)
//                    .textSelection(.enabled)
//                    .padding(.vertical,8)
//                    .foregroundColor(.black)
                HStack{
                    Image(post.location1)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120,height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    VStack(spacing:10){
                        Text(post.location1)
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                            .hAlign(.leading)
                        Text("Cost: $\(post.locationTotoalMoney)")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .hAlign(.leading)
                        Text("Type: \(post.locationRandomType)")
                            .font(.caption2)
                            .foregroundColor(.gray)
                            .hAlign(.leading)
                        HStack{
                            Image(post.location2)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50,height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            Image(post.location3)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50,height: 30)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                        .hAlign(.leading)
                    }
                    .padding(.leading,5)
                }
            }
        }
        .hAlign(.leading)
        .overlay(alignment: .topTrailing, content: {
            //MARK: display delete button
            if post.userUID == userUID{
                Menu{
                    Button("Delete Post",role:.destructive,action: deletePost)
                }label: {
                    Image(systemName: "ellipsis")
                        .font(.caption)
                        .rotationEffect(.init(degrees: -90))
                        .foregroundColor(.black)
                        .padding(8)
                        .contentShape(Rectangle())
                }
                .offset(x:8)
            }
        })
        .onAppear{
            if docListner == nil{
                guard let postID = post.id else{return}
                docListner = Firestore.firestore().collection("Ecotourism Routes").document(postID).addSnapshotListener({
                    snapshot, error in
                    if let snapshot{
                        if snapshot.exists{
                            if let updatedPost = try? snapshot.data(as: Post.self){
                                onUpdate(updatedPost)
                            }
                        }else{
                            onDelete()
                        }
                    }
                })
            }
        }
        .onDisappear{
            if let docListner{
                docListner.remove()
                self.docListner = nil
            }
        }
    }
    //MARK: delete post
    func deletePost(){
        Task{
            
            do{
                guard let postID = post.id else{return}
                try await Firestore.firestore().collection("Ecotourism Routes").document(postID).delete()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

