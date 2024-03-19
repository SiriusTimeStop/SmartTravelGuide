//
//  MapLocationView.swift
//  SmartTravel
//
//  Created by jackychoi on 17/3/2024.
//

import SwiftUI

struct MapLocationView: View {
//    @State private var showLocationSearchView = false
    @State private var mapState = MapViewState.noInput
    
    var body: some View {
        ZStack(alignment:.top){
            MapViewRepresentable(mapState: $mapState)
                .ignoresSafeArea()
            
            if mapState == .searchingForLocation {
                LocationSearchView(mapState: $mapState)
            }else if mapState == .noInput{
                LocationSearchActivationView()
                    .padding(.top,72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            mapState = .searchingForLocation
                        }
                    }
            }
            MapViewActionButton(mapState: $mapState)
                .padding(.leading)
                .padding(.top,4)
        }
    }
}

