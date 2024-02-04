//
//  TravelDetailView.swift
//  SmartTravel
//
//  Created by jackychoi on 3/2/2024.
//

import SwiftUI

struct TravelDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView{
            Group{
                Image(post.location1)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 344, height: 370)
                    .cornerRadius(20)
                    .padding(.horizontal,30)
                    .padding(.bottom,10)
                
                Text(post.location1)
                    .font(.system(size: 20,weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Text(post.locationType1)
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 9, height: 12)
                    
                    Text(post.locationDistrict1)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal,30)
                .frame(maxWidth: .infinity,alignment: .leading)
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
                
                Image(post.location2)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 344, height: 370)
                    .cornerRadius(20)
                    .padding(.horizontal,30)
                    .padding(.bottom,10)
                
                Text(post.location2)
                    .font(.system(size: 20,weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Text(post.locationType2)
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 9, height: 12)
                    
                    Text(post.locationDistrict2)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal,30)
                .frame(maxWidth: .infinity,alignment: .leading)
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
                
                Image(post.location3)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 344, height: 370)
                    .cornerRadius(20)
                    .padding(.horizontal,30)
                    .padding(.bottom,10)
                
                Text(post.location3)
                    .font(.system(size: 20,weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                Text(post.locationType3)
                    .padding(.horizontal,30)
                    .frame(maxWidth: .infinity,alignment: .leading)
                
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 9, height: 12)
                    
                    Text(post.locationDistrict3)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal,30)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.bottom)
            }
        }
    }
}


