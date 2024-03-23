//
//  transportationView.swift
//  SmartTravel
//
//  Created by jackychoi on 23/3/2024.
//

import SwiftUI

struct transportationView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48,height: 6)
                .padding(.top,8)
            
            //info view
            HStack{
                VStack{
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8,height: 8)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1,height: 32)
                    
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8,height: 8)
                }
                
                VStack(alignment:.leading,spacing: 24){
                    HStack{
                        Text("Current location")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding(.bottom,10)
                    
                    HStack{
                        Text("Starbucks Coffee")
                            .font(.system(size: 16,weight: .semibold))
                        Spacer()
                    }
                }
                .padding(.leading,8)
            }
            .padding()
            
            Divider()
                .padding()
        }
        .padding(.bottom,66)
        .background(ignoresSafeAreaEdges: .all)
        .background(Color(.white))
        .cornerRadius(16)
    }
}

#Preview {
    transportationView()
}
