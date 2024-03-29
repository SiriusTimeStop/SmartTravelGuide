//
//  MapViewActionButton.swift
//  UberSwiftUiTutorial
//
//  Created by jackychoi on 15/10/2023.
//

import SwiftUI

struct MapViewActionButton: View {
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(mapState)
            }
        }label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(.black)
                .padding()
                .background(.white)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState){
        switch state{
        case .noInput:
            print("Debug: No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected:
            mapState = .noInput
            viewModel.selectLocationCoordinate = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String{
        switch state{
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected:
            return "arrow.left"
        }
    }
}
