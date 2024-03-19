//
//  TravelGuide.swift
//  MapRoutes
//
//  Created by jackychoi on 5/11/2023.
//

import SwiftUI

struct TravelGuide: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date,order: .reverse)]) var attraction: FetchedResults<Attraction>
    var body: some View {
        NavigationView{
            VStack(alignment:.leading){
                Text("\(String(totalTravelPlan())) plan")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List{
                    ForEach(attraction) {attraction in
                        NavigationLink(destination: ShowPlanDetailView(plan: attraction)) {
                            
                            HStack{
                                if attraction.level == "Luxury"{
                                    Image("HongKongDisneyland1")
                                        .resizable()
                                        .frame(width: 140, height: 90)
                                        .cornerRadius(20.0)
                                }else if attraction.level == "Normal"{
                                    Image("OceanPark")
                                        .resizable()
                                        .frame(width: 140, height: 90)
                                        .cornerRadius(20.0)
                                }else if attraction.level == "Poor"{
                                    Image("StarFerry")
                                        .resizable()
                                        .frame(width: 140, height: 90)
                                        .cornerRadius(20.0)
                                }
                                
                                HStack{
                                    VStack(alignment:.leading,spacing: 7){
                                        Text(attraction.level!)
                                            .bold()
                                            .foregroundColor(.black)
                                            .fontWeight(.bold)
                                            .font(.title2)
                                        
                                        HStack{
                                           Image(systemName: "mappin.and.ellipse")
                                                .frame(width: 9, height: 12)
                                                
                                            Text("Hong kong")
                                                .foregroundColor(.gray)
                                        }
                                        HStack{
                                            Text("$\(attraction.cost!)")
                                                .foregroundColor(Color.init(hex: "#57BFD2",alpha: 1.0))
                                                .font(.footnote)
                                            Text("/ per day")
                                                .foregroundColor(.black)
                                                .font(.footnote)          
                                        }
                                    }
                                    Spacer()
//                                    Text(calcTimeSince(date:attraction.date!))
//                                        .foregroundColor(.gray)
//                                        .italic()
//                                        .frame(alignment: .leading)
                                }
                                .padding(.leading,10)
                            }
                        }
                    }
                    .onDelete(perform:deleteAttraction)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Travel Plan")
        }
    }
    private func deleteAttraction(offsets: IndexSet){
        withAnimation {
            offsets.map{attraction[$0]}.forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
    }
    
    private func totalTravelPlan() -> Int{
        var total = 0
        for item in attraction{
            total += 1
        }
        return total
    }
}

struct TravelGuide_Previews: PreviewProvider {
    
    static var previews: some View {
        TravelGuide()
    }
}

