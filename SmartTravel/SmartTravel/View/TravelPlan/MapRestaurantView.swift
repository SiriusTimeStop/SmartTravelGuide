//
//  MapRestaurantView.swift
//  SmartTravel
//
//  Created by jackychoi on 17/2/2024.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapRestaurantView: View {
    let post: Post
    
    @Namespace private var locationSpace
    //search Properties
    @State private var searchText: String = ""
    @State private var showSearch: Bool = false
    @State private var showLocation: Bool = true
    @State private var searchResults: [MKMapItem] = []
    @State private var number = 0
    
    var body: some View {
        if number == 0{
            NavigationStack{
                Map(initialPosition: .region(region)){
                    Marker(post.location1, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0))
                    
                    ForEach(searchResults,id:\.self){ mapItem in
                        
                        let placemark = mapItem.placemark
                        Marker(placemark.name ?? "Place",coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                    
                    /// to show user current location
                    UserAnnotation()
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack(spacing:15){
                        MapCompass(scope: locationSpace)
                        MapUserLocationButton(scope: locationSpace)
                    }
                    .buttonBorderShape(.circle)
                    .padding()
                }
                .mapScope(locationSpace)
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText,isPresented: $showSearch)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            }
            .navigationBarItems(trailing: HStack(spacing:15){
                Button(action: {
                    if number < 2{
                        number = number + 1
                    }else{
                        number = 0
                    }
                    
                }, label: {
                    Image(systemName: "arrow.left.arrow.right")
                })
            })
            .onSubmit(of: .search) {
                Task{
                    guard !searchText.isEmpty else {return}
                    await searchPlaces()
                }
            }
        }
        else if number == 1{
            NavigationStack{
                Map(initialPosition: .region(region2)){
                    Marker(post.location2, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0))
                    
                    ForEach(searchResults,id:\.self){ mapItem in
                        
                        let placemark = mapItem.placemark
                        Marker(placemark.name ?? "Place",coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                    
                    /// to show user current location
                    UserAnnotation()
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack(spacing:15){
                        MapCompass(scope: locationSpace)
                        MapUserLocationButton(scope: locationSpace)
                    }
                    .buttonBorderShape(.circle)
                    .padding()
                }
                .mapScope(locationSpace)
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText,isPresented: $showSearch)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            }
            .navigationBarItems(trailing: HStack(spacing:15){
                Button(action: {
                    if number < 2{
                        number = number + 1
                    }else{
                        number = 0
                    }
                    
                }, label: {
                    Image(systemName: "arrow.left.arrow.right")
                })
            })
            .onSubmit(of: .search) {
                Task{
                    guard !searchText.isEmpty else {return}
                    await searchPlaces()
                }
            }
            Button(action: {
                if number < 2{
                    number = number + 1
                }else{
                    number = 0
                }

            }, label: {
                Image(systemName: "swift")
            })
        }
        else if number == 2{
            NavigationStack{
                Map(initialPosition: .region(region3)){
                    Marker(post.location3, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0))
                    
                    ForEach(searchResults,id:\.self){ mapItem in
                        
                        let placemark = mapItem.placemark
                        Marker(placemark.name ?? "Place",coordinate: placemark.coordinate)
                            .tint(.blue)
                    }
                    
                    /// to show user current location
                    UserAnnotation()
                }
                .overlay(alignment: .bottomTrailing) {
                    VStack(spacing:15){
                        MapCompass(scope: locationSpace)
                        MapUserLocationButton(scope: locationSpace)
                    }
                    .buttonBorderShape(.circle)
                    .padding()
                }
                .mapScope(locationSpace)
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText,isPresented: $showSearch)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            }
            .navigationBarItems(trailing: HStack(spacing:15){
                Button(action: {
                    if number < 2{
                        number = number + 1
                    }else{
                        number = 0
                    }
                    
                }, label: {
                    Image(systemName: "arrow.left.arrow.right")
                })
            })
            .onSubmit(of: .search) {
                Task{
                    guard !searchText.isEmpty else {return}
                    await searchPlaces()
                }
            }
        }
    }
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        
        //change 2
        if number  == 0{
            request.naturalLanguageQuery = searchText
            request.region = region
            
        }else if number == 1{
            request.naturalLanguageQuery = searchText
            request.region = region2
        }else if number == 2{
            request.naturalLanguageQuery = searchText
            request.region = region3
        }
        
        //change 1
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    private var region: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    private var region2: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
    private var region3: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
}
