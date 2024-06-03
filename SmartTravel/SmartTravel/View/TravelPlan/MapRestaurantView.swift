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
    @State private var mapSelection: MKMapItem?
    @State private var viewingRegion: MKCoordinateRegion?
    ///Map selection detail properties
    @State private var showDetails: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?
    /// Route Properties
    @State private var routeDisplaying: Bool = false
    @State private var route: MKRoute?
    @State private var routeDestination: MKMapItem?
    
    var body: some View {
        if number == 0{
            NavigationStack{
                Map(initialPosition: .region(region),selection: $mapSelection){
                    Marker(post.location1, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0))
                    
                    ForEach(searchResults,id:\.self){ mapItem in
                        if routeDisplaying{
                            if mapItem == routeDestination {
                                let placemark = mapItem.placemark
                                Marker(placemark.name ?? "Place",systemImage:"fork.knife.circle.fill",coordinate: placemark.coordinate)
                                    .tint(Color(hex:"#57BFD2"))
                            }
                        }else{
                            let placemark = mapItem.placemark
                            Marker(placemark.name ?? "Place",systemImage:"fork.knife.circle.fill",coordinate: placemark.coordinate)
                                .tint(Color(hex:"#57BFD2"))
                        }
                    }
                    /// Display Route using Polyline
                    if let route {
                        MapPolyline(route.polyline)
                            .stroke(Color(hex:"#57BFD2"), lineWidth: 7)
                    }
                    
                    /// to show user current location
                    UserAnnotation()
                }
                .onMapCameraChange({ ctx in
                    viewingRegion = ctx.region
                })
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
                .toolbar(routeDisplaying ? .hidden : .visible , for: .navigationBar)
                .sheet(isPresented: $showDetails, content: {
                    MapDetails()
                        .presentationDetents([.height(300)])
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                        .presentationCornerRadius(25)
                        .interactiveDismissDisabled(true)
                })
                .safeAreaInset(edge: .bottom) {
                    if routeDisplaying{
                        Button("End Route"){
                            routeDisplaying = false
                            showDetails = true
                            mapSelection = routeDestination
                            routeDestination = nil
                            route = nil
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,12)
                        .background(.red.gradient, in: .rect(cornerRadius:15))
                        .padding()
                        .background(.ultraThinMaterial)
                    }
                }
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
            .onChange(of: showSearch, initial: false){
                if !showSearch{
                    /// Clearing search results
                    searchResults.removeAll(keepingCapacity: false)
                    showDetails = false
                }
            }
            .onChange(of: mapSelection) { oldValue, newValue in
                /// DIsplay details about the selected place
                showDetails = newValue != nil
                /// Fetching look around preview
                fetchLookAroundPreview()
            }
        }
        else if number == 1{
            NavigationStack{
                Map(initialPosition: .region(region2),selection: $mapSelection){
                    Marker(post.location2, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0))
                    
                    ForEach(searchResults,id:\.self){ mapItem in
                        if routeDisplaying{
                            if mapItem == routeDestination {
                                let placemark = mapItem.placemark
                                Marker(placemark.name ?? "Place",systemImage:"fork.knife.circle.fill",coordinate: placemark.coordinate)
                                    .tint(Color(hex:"#57BFD2"))
                            }
                        }else{
                            let placemark = mapItem.placemark
                            Marker(placemark.name ?? "Place",systemImage:"fork.knife.circle.fill",coordinate: placemark.coordinate)
                                .tint(Color(hex:"#57BFD2"))
                        }
                    }
                    /// Display Route using Polyline
                    if let route {
                        MapPolyline(route.polyline)
                            .stroke(Color(hex:"#57BFD2"), lineWidth: 7)
                    }
                    
                    /// to show user current location
                    UserAnnotation()
                }
                .onMapCameraChange({ ctx in
                    viewingRegion = ctx.region
                })
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
                .toolbar(routeDisplaying ? .hidden : .visible , for: .navigationBar)
                .sheet(isPresented: $showDetails, content: {
                    MapDetails()
                        .presentationDetents([.height(300)])
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                        .presentationCornerRadius(25)
                        .interactiveDismissDisabled(true)
                })
                .safeAreaInset(edge: .bottom) {
                    if routeDisplaying{
                        Button("End Route"){
                            routeDisplaying = false
                            showDetails = true
                            mapSelection = routeDestination
                            routeDestination = nil
                            route = nil
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,12)
                        .background(.red.gradient, in: .rect(cornerRadius:15))
                        .padding()
                        .background(.ultraThinMaterial)
                    }
                }
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
            .onChange(of: showSearch, initial: false){
                if !showSearch{
                    searchResults.removeAll(keepingCapacity: false)
                    showDetails = false
                }
            }
            .onChange(of: mapSelection) { oldValue, newValue in
                /// DIsplay details about the selected place
                showDetails = newValue != nil
                /// Fetching look around preview
                fetchLookAroundPreview()
            }
        }
        else if number == 2{
            NavigationStack{
                Map(initialPosition: .region(region3),selection: $mapSelection){
                    Marker(post.location3, coordinate: CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0))
                    
                    ForEach(searchResults,id:\.self){ mapItem in
                        if routeDisplaying{
                            if mapItem == routeDestination {
                                let placemark = mapItem.placemark
                                Marker(placemark.name ?? "Place",systemImage:"fork.knife.circle.fill",coordinate: placemark.coordinate)
                                    .tint(Color(hex:"#57BFD2"))
                            }
                        }else{
                            let placemark = mapItem.placemark
                            Marker(placemark.name ?? "Place",systemImage:"fork.knife.circle.fill",coordinate: placemark.coordinate)
                                .tint(Color(hex:"#57BFD2"))
                        }
                    }
                    /// Display Route using Polyline
                    if let route {
                        MapPolyline(route.polyline)
                            .stroke(Color(hex:"#57BFD2"), lineWidth: 7)
                    }
                    
                    /// to show user current location
                    UserAnnotation()
                }
                .onMapCameraChange({ ctx in
                    viewingRegion = ctx.region
                })
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
                .toolbar(routeDisplaying ? .hidden : .visible , for: .navigationBar)
                .sheet(isPresented: $showDetails, content: {
                    MapDetails()
                        .presentationDetents([.height(300)])
                        .presentationBackgroundInteraction(.enabled(upThrough: .height(300)))
                        .presentationCornerRadius(25)
                        .interactiveDismissDisabled(true)
                })
                .safeAreaInset(edge: .bottom) {
                    if routeDisplaying{
                        Button("End Route"){
                            routeDisplaying = false
                            showDetails = true
                            mapSelection = routeDestination
                            routeDestination = nil
                            route = nil
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical,12)
                        .background(.red.gradient, in: .rect(cornerRadius:15))
                        .padding()
                        .background(.ultraThinMaterial)
                    }
                }
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
            .onChange(of: showSearch, initial: false){
                if !showSearch{
                    searchResults.removeAll(keepingCapacity: false)
                    showDetails = false
                }
            }
            .onChange(of: mapSelection) { oldValue, newValue in
                /// DIsplay details about the selected place
                showDetails = newValue != nil
                /// Fetching look around preview
                fetchLookAroundPreview()
            }
        }
    }
    
    ///  Map Details view
    @ViewBuilder
    func MapDetails() -> some View{
        VStack(spacing: 15){
            /// New Look Around API
            ZStack{
                if lookAroundScene == nil{
                    ContentUnavailableView("No Preview Available", systemImage: "eye.slash")
                }else{
                    LookAroundPreview(scene: $lookAroundScene)
                }
            }
            .frame(height: 200)
            .clipShape(.rect(cornerRadius: 15))
            /// Close Button
            .overlay(alignment: .topTrailing) {
                Button(action: {
                    /// CLosing view
                    showDetails = false
                    withAnimation(.snappy){
                        mapSelection = nil
                    }
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .background(.white,in:.circle)
                })
                .padding(10)
            }
            
            if number == 0{
                Button("Get Directions",action: fetchRoute)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical,12)
                .background(Color(hex:"#57BFD2"),in: .rect(cornerRadius: 15))
            }else if number == 1{
                Button("Get Directions",action: fetchRoute2)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical,12)
                .background(Color(hex:"#57BFD2"),in: .rect(cornerRadius: 15))
            }else if number == 2{
                Button("Get Directions",action: fetchRoute3)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical,12)
                .background(Color(hex:"#57BFD2"),in: .rect(cornerRadius: 15))
            }
        }
        .padding(15)
    }
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        
        //change 2
        if number  == 0{
            request.naturalLanguageQuery = searchText
            request.region = viewingRegion ?? region
            
        }else if number == 1{
            request.naturalLanguageQuery = searchText
            request.region = viewingRegion ?? region2
            
        }else if number == 2{
            request.naturalLanguageQuery = searchText
            request.region = viewingRegion ?? region3
        }
        
        //change 1
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
    /// Fetching Location Preview
    func fetchLookAroundPreview(){
        if let mapSelection{
            lookAroundScene = nil
            Task{
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
    
    /// Fetching Route
    func fetchRoute(){
        let sourceCoordinate = CLLocationCoordinate2D(latitude: Double(post.locationLot1) ?? 0, longitude: Double(post.locationLon1) ?? 0)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        request.destination = mapSelection
        
        Task{
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            /// Saving Route Destination
            routeDestination = mapSelection
            
            routeDisplaying = true
            showDetails = false
        }
    }
    
    func fetchRoute2(){
        let sourceCoordinate = CLLocationCoordinate2D(latitude: Double(post.locationLot2) ?? 0, longitude: Double(post.locationLon2) ?? 0)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        request.destination = mapSelection
        
        Task{
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            /// Saving Route Destination
            routeDestination = mapSelection
            
            routeDisplaying = true
            showDetails = false
        }
    }
    
    func fetchRoute3(){
        let sourceCoordinate = CLLocationCoordinate2D(latitude: Double(post.locationLot3) ?? 0, longitude: Double(post.locationLon3) ?? 0)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        request.destination = mapSelection
        
        Task{
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            /// Saving Route Destination
            routeDestination = mapSelection
            
            routeDisplaying = true
            showDetails = false
        }
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
