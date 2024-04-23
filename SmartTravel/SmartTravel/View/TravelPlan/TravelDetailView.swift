//
//  TravelDetailView.swift
//  SmartTravel
//
//  Created by jackychoi on 3/2/2024.
//

import SwiftUI
import CoreLocation
import MapKit

struct TravelDetailView: View {
    let post: Post
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView{
            HStack{
                Text("Travel Guide")
                    .fontWeight(.bold)
                    .font(.title)
                    .hAlign(.leading)
                NavigationLink(destination: MapTransportView(post: post)){
                        Image(systemName: "bus.fill")
                        .foregroundColor(.black)
                    }
                .hAlign(.trailing)
                .frame(width: 40,height: 40)
        
                NavigationLink(destination: MapRestaurantView(post: post)){
                        Image(systemName: "mug.fill")
                        .foregroundColor(.black)
                    }
                .hAlign(.trailing)
                .frame(width: 40,height: 40)
            }
            .padding(.horizontal,30)
            .padding(.top,10)
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
                
                Map(initialPosition: .region(region)){
                    Marker(post.location1, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0))
                }
                .frame(height: 300)
                .cornerRadius(20)
                .padding(.horizontal,30)
                .padding(.bottom,10)
                
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
                
                Map(initialPosition: .region(region2)){
                    Marker(post.location2, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0))
                }
                .frame(height: 300)
                .cornerRadius(20)
                .padding(.horizontal,30)
                .padding(.bottom,10)
                
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
                
                Map(initialPosition: .region(region3)){
                    Marker(post.location3, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0))
                }
                .frame(height: 300)
                .cornerRadius(20)
                .padding(.horizontal,30)
                .padding(.bottom,10)
            }
        }
    }
    private var region: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    
    private var region2: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    
    private var region3: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
    
}


