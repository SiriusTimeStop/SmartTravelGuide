//
//  SearchPublicTransportView.swift
//  SmartTravel
//
//  Created by jackychoi on 11/5/2024.
//

import SwiftUI
import MapKit
import CoreLocation


struct SearchPublicTransportView: View {
    
    @State var models: [ResponseModel] = []
    @State var annotations: [mtrPlace] = []
    @StateObject private var viewModel = LocationGpsViewModel()
    @Environment(\.dismiss) var dismiss
    
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
        NavigationStack{
            Map(initialPosition: .region(region),selection:$mapSelection){
                
                
                ForEach(searchResults,id:\.self){ mapItem in
                    if routeDisplaying{
                        if mapItem == routeDestination {
                            let placemark = mapItem.placemark
                            if searchText == "Mtr" || searchText == "Train"{
                                Marker(placemark.name ?? "Place",systemImage: "train.side.rear.car",coordinate: placemark.coordinate)
                                    .tint(Color(hex:"#D2AC9C"))
                            }else if searchText == "Bus station" || searchText == "Bus"{
                                Marker(placemark.name ?? "Place",systemImage: "bus.fill",coordinate: placemark.coordinate)
                                    .tint(Color(hex:"#D2CD8B"))
                            }
                            else{
                                Marker(placemark.name ?? "Place",coordinate: placemark.coordinate)
                                    
                            }
                        }
                    }else{
                        let placemark = mapItem.placemark
                        if searchText == "Mtr" || searchText == "Train"{
                            Marker(placemark.name ?? "Place",systemImage: "train.side.rear.car",coordinate: placemark.coordinate)
                                .tint(Color(hex:"#D2AC9C"))
                        }else if searchText == "Bus station" || searchText == "Bus"{
                            Marker(placemark.name ?? "Place",systemImage: "bus.fill",coordinate: placemark.coordinate)
                                .tint(Color(hex:"#D2CD8B"))
                        }
                        else{
                            Marker(placemark.name ?? "Place",coordinate: placemark.coordinate)
                                
                        }
                    }
                }
                
                if let route {
                    MapPolyline(route.polyline)
                        .stroke(Color(hex:"#57BFD2"), lineWidth: 7)
                }
                
                UserAnnotation()
            }
            .onAppear{
                viewModel.checkIfLocationServicesIsEnabled()
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
            
            Button("Get Directions",action: fetchRoute)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical,12)
            .background(Color(hex:"#57BFD2"),in: .rect(cornerRadius: 15))
        }
        .padding(15)
    }
    
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchText
        request.region = viewingRegion ?? region
        
        //change 1
        let results = try? await MKLocalSearch(request: request).start()
        searchResults = results?.mapItems ?? []
    }
    
    func fetchRoute(){
        let sourceCoordinate = CLLocationCoordinate2D(latitude: viewModel.region.center.latitude, longitude: viewModel.region.center.longitude)
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
    
    func fetchLookAroundPreview(){
        if let mapSelection{
            lookAroundScene = nil
            Task{
                let request = MKLookAroundSceneRequest(mapItem: mapSelection)
                lookAroundScene = try? await request.scene
            }
        }
    }
    
    private var region: MKCoordinateRegion{
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: viewModel.region.center.latitude, longitude: viewModel.region.center.longitude), span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
    }
}

#Preview {
    SearchPublicTransportView()
}



