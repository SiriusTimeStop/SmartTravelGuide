//
//  Home.swift
//  MapRoutes
//
//  Created by itst on 16/10/2023.
//

import SwiftUI
import CoreLocation

struct Home: View {
    @StateObject var mapData = MapViewModel()
    //location manager...
    @State var locationManager = CLLocationManager()
    @State var searchPlace : String = ""
    @State var showSearchResult : Bool = false
    @State var searchBarStatus : Bool = false
    
    var body: some View {
        
        
        ZStack(alignment:.bottom){
            ZStack{
                
                // MapView...
                MapView()
                    .environmentObject(mapData)
                    .ignoresSafeArea(.all,edges: .all)
                VStack{
                    
                    VStack(spacing: 0){
                        if searchBarStatus == false{
                            HStack{
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                
                                TextField("Search",text: $mapData.searchTxt)
                                    .colorScheme(.light)
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.white)
                        }
                        
                        // displaying results..
                        if !mapData.places.isEmpty && mapData.searchTxt != ""{
                            ScrollView{
                                VStack(spacing: 15){
                                    ForEach(mapData.places){
                                        place in
                                        Text(place.place.name ?? "")
                                            .foregroundColor(.black)
                                            .frame(maxWidth:.infinity,alignment:.leading)
                                            .padding(.leading)
                                            .onTapGesture {
                                                self.showSearchResult.toggle()
                                                self.searchBarStatus.toggle()
                                                withAnimation(.spring()){
                                                    mapData.selectPlace(place: place)
                                                    self.searchPlace = place.place.name!
                                                }
                                            }
                                        Divider()
                                    }
                                }
                                .padding(.top)
                            }
                            .background(Color.white)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    VStack{
                        Button(action: mapData.updateMapType, label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                .font(.title2)
                                .padding(10)
                                .background(Color.primary)
                                .clipShape(Circle())
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                }
            }
            .onAppear(perform: {
                
                locationManager.delegate = mapData
                locationManager.requestWhenInUseAuthorization()
                
            })
            
            //Permission denied alert...
            .onChange(of: mapData.searchTxt, perform: {
                value in
                
                // searching places...
                
                // You can use your own delay
                let delay = 0.3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + delay){
                    
                    if value == mapData.searchTxt{
                        
                        // search...
                        self.mapData.searchQuery()
                    }
                }
            })
            
            if !searchPlace.isEmpty && self.showSearchResult == true{
                
                RideRequestView(searchPlace: $searchPlace,showSearchResult:$showSearchResult,searchBarStatus: $searchBarStatus)
                    .transition(.move(edge: .bottom))
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            
        }
//        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Home_Previews: PreviewProvider {
    
    static var previews: some View {
        Home()
    }
}
