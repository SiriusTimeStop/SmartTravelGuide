//
//  PostCardView.swift
//  SmartTravel
//
//  Created by jackychoi on 3/2/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardView: View {
    var post: Post
    /// - Callbacks
    var onUpdate: (Post) -> ()
    var onDelete: () -> ()

    var body: some View {
        HStack(alignment: .top, spacing: 12){
            WebImage(url: post.userProfileURL)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 35, height: 35)
                .clipShape(Circle())
            
            VStack(alignment:.leading,spacing: 6){
                Text(post.userName)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                Text(post.publishedDate.formatted(date: .numeric, time: .shortened))
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text(post.location1)
                    .textSelection(.enabled)
                    .padding(.vertical,8)
                    .foregroundColor(.black)
                Image(post.location1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 300,height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                Text("Type of Travel: \(post.locationRandomType)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Text("Cost: $\(post.locationTotoalMoney)")
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
        }
        .hAlign(.leading)
    }
}
