//
//  LocationSearchView.swift
//  SmartTravel
//
//  Created by jackychoi on 19/3/2024.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel : LocationSearchViewModel
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6,height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 24)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6,height: 6)
                }
                
                VStack{
                    TextField("Current location",text: $startLocationText)
                        .frame(height: 32)
                        .padding(.leading,5)
                        .background(Color(
                            .systemGroupedBackground))
//                        .cornerRadius(5)
                        .padding(.trailing)
                        
                    
                    TextField("Where to?",text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .padding(.leading,5)
                        .background(Color(
                            .systemGray4))
                        .padding(.trailing)
                }
            }
            .padding(.horizontal)
            .padding(.top,72)
            
            Divider()
                .padding(.vertical)
            
            // list view
            ScrollView{
                VStack(alignment:.leading){
                    ForEach(viewModel.results,id: \.self){
                        result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                            .onTapGesture {
                                viewModel.selectLocaiton(result)
                                mapState = .locationSelected
                            }
                    }
                }
            }
        }
        .background(.white)
    }
}

