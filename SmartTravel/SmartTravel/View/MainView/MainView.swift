//
//  MainView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI
import MapKit

struct MainView: View {
    var body: some View {
        //MARK: TabView
        TabView{
            Home()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            TravelGuide()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Plan")
                }
        }
        .onAppear(){
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

#Preview {
    ContentView()
}
