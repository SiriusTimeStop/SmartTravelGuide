//
//  SmartTravelApp.swift
//  SmartTravel
//
//  Created by jackychoi on 24/1/2024.
//

import SwiftUI
import Firebase

@main
struct SmartTravelApp: App {
    @StateObject private var dataController = DataController()
    @StateObject var locationViewModel = LocationSearchViewModel()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,dataController.container.viewContext)
                .environmentObject(locationViewModel)
        }
    }
}
