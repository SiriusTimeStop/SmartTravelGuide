//
//  LocationSearchResultCell.swift
//  UberSwiftUiTutorial
//
//  Created by jackychoi on 15/10/2023.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title: String
    let subtitle: String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundColor(Color(hex: "#57BFD2"))
                .accentColor(.white)
                .frame(width: 40, height: 40)
            
            VStack(alignment:.leading,spacing: 4){
                Text(title)
                    .font(.body)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
                Divider()
            }
            .padding(.leading,8)
            .padding(.vertical,8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultCell(title: "starbucks", subtitle: "123 main st")
}
