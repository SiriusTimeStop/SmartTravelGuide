//
//  ContentView.swift
//  SmartTravel
//
//  Created by jackychoi on 24/1/2024.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @AppStorage("log_status") var logStatus: Bool = false
    var body: some View {
        if logStatus{
            MainView()
        }else{
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}


