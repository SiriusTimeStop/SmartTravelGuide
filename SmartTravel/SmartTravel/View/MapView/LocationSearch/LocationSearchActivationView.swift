//
//  LocationSearchActivationView.swift
//  UberSwiftUiTutorial
//
//  Created by jackychoi on 15/10/2023.
//

import SwiftUI

struct LocationSearchActivationView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            Text("where to?")
                .foregroundColor(Color(.darkGray))
            
            Spacer()
        }
        
        .frame(width: UIScreen.main.bounds.width - 64,
        height: 50)
        .background(
        Rectangle()
            .fill(Color.white)
            .shadow(color: .black, radius: 6)
        )
    }
}

#Preview {
    LocationSearchActivationView()
}
