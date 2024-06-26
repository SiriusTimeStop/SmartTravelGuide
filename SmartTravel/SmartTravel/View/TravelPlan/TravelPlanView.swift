//
//  TravelPlanView.swift
//  SmartTravel
//
//  Created by jackychoi on 29/1/2024.
//

import SwiftUI

struct TravelPlanView: View {
    var onPost: (Post) -> ()
    /// - Post requires
    @State private var requireMoney: Double = 0
    @State private var requireType: String = ""
    @State private var requireDistrict: String = ""
    @State private var uploadResultLocation: [String] = []
    @State private var totalMoney: Int = 0
    
    /// - stored user data from userDefaults
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    
    /// - view properties
    @Environment(\.dismiss) private var dismiss
    @State private var isloading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
    /// - promptStatus
    @State var resultStatus : Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Menu{
                    Button("Cancel",role: .destructive){
                        dismiss()
                    }
                }label: {
                    Text("Cancel")
                        .font(.callout)
                        .foregroundColor(.black)
                }
                .hAlign(.leading)
                
                Button(action:promptResult){
                    Text("Travel")
                        .font(.callout)
                        .foregroundColor(.white)
                        .padding(.horizontal,20)
                        .padding(.vertical,6)
                        .background(.black,in: Capsule())
                }
                .disableWithOpacity(requireMoney <= 0)
                .disableWithOpacity(requireType == "")
                .disableWithOpacity(requireDistrict == "")
            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background{
                Rectangle()
                    .fill(.gray.opacity(0.05))
                    .ignoresSafeArea()
            }
            
            Text("Travel Selection")
                .font(.title2)
                .hAlign(.center)
                .padding()
                .fontWeight(.bold)
            Form{
                Section("Travel Type"){
                    Picker("Type",selection: $requireType){
                        Text("Cultural Tourism").tag("Cultural Tourism")
                        Text("Ecotourism").tag("Ecotourism")
                        Text("Sightseeing Tourism").tag("Sightseeing Tourism")
                        Text("Extreme Travel").tag("Extreme Travel")
                    }

                    .pickerStyle(.menu)
                }
                
                Section("Travel District"){
                    Picker("District",selection: $requireDistrict){
                        Text("Kowloon").tag("Kowloon")
                        Text("Hong Kong Island").tag("Hong Kong Island")
                        Text("New Territories").tag("New Territories")
                    }
                    .pickerStyle(.menu)
                }
                
                Section("Fee Range"){
                    Slider(value: $requireMoney,in: 0...10000,step:1)
                        .padding()
                    Text("$\(requireMoney.formatted())")
                        .font(.callout)
                        .hAlign(.center)
                }
            }
            .padding()
            .shadow(color: Color.secondary, radius: 3, x: 3, y: 3)
            .background(Color(UIColor.white).ignoresSafeArea())
            .accentColor(Color.init(hex: "#57BFD2",alpha: 1.0))
            .scrollContentBackground(.hidden)
            if resultStatus == true{
                TravelPlanResultView(onPost: onPost, resultStatus: $resultStatus, uploadResultLocation: $uploadResultLocation, requireType: $requireType, totalMoney: $totalMoney)
                    .transition(.move(edge: .bottom))
                    .shadow(color: Color.secondary, radius: 5, x: 5, y: 5)
                    .padding(.horizontal,10)
                    .vAlign(.top)
            }
        }
        .vAlign(.top)
    }
    
    func promptResult(){
        withAnimation(.easeInOut(duration: 1)){
            self.resultStatus.toggle()
            uploadResultLocation = []
            var travelPlanLocationArray = []
            var travelPlanLocationDistrict = []
            var travelPlanLocationMoney = []
            var travelPlanLocationType = []
            var travelPlanLocationLot = []
            var travelPlanlocationLon = []
            repeat{
                uploadResultLocation = []
                travelPlanLocationArray = []
                travelPlanLocationDistrict = []
                travelPlanLocationMoney = []
                travelPlanLocationType = []
                travelPlanLocationLot = []
                travelPlanlocationLon = []
                totalMoney = 0
                for c in 0...2{
                    for x in 0...TravelLocation().location.count-1{
                        
                        ///Array condition 3x
                        if requireType == TravelLocation().locationType[x] && requireDistrict == TravelLocation().locationDistrict[x]{
                            for a in 1...4{
                                travelPlanLocationArray.append(TravelLocation().location[x])
                                travelPlanLocationDistrict.append(TravelLocation().locationDistrict[x])
                                travelPlanLocationType.append(TravelLocation().locationType[x])
                                travelPlanLocationMoney.append(TravelLocation().locationMoney[x])
                                travelPlanLocationLot.append(TravelLocation().locationLatitude[x])
                                travelPlanlocationLon.append(TravelLocation().locationLongitude[x])
                                
                            }
                        }else if requireType == TravelLocation().locationType[x] && requireDistrict != TravelLocation().locationDistrict[x]{
                            for b in 1...2{
                                travelPlanLocationArray.append(TravelLocation().location[x])
                                travelPlanLocationDistrict.append(TravelLocation().locationDistrict[x])
                                travelPlanLocationType.append(TravelLocation().locationType[x])
                                travelPlanLocationMoney.append(TravelLocation().locationMoney[x])
                                travelPlanLocationLot.append(TravelLocation().locationLatitude[x])
                                travelPlanlocationLon.append(TravelLocation().locationLongitude[x])
                            }
                        }else{
                            travelPlanLocationArray.append(TravelLocation().location[x])
                            travelPlanLocationDistrict.append(TravelLocation().locationDistrict[x])
                            travelPlanLocationType.append(TravelLocation().locationType[x])
                            travelPlanLocationMoney.append(TravelLocation().locationMoney[x])
                            travelPlanLocationLot.append(TravelLocation().locationLatitude[x])
                            travelPlanlocationLon.append(TravelLocation().locationLongitude[x])
                        }
                    }
                    ///Random choose
                    var number = Int.random(in: 0...travelPlanLocationArray.count-1)
                    let randomLocation = travelPlanLocationArray[number]
                    if c != 0{
                        repeat{
                            if uploadResultLocation[0] == randomLocation as! String{
                                    number = Int.random(in: 0...travelPlanLocationArray.count-1)
                            }
                        }while (uploadResultLocation[0] == randomLocation as! String)
                    }
                    if c > 1{
                        repeat{
                            if uploadResultLocation[0] == randomLocation as! String || uploadResultLocation[6] == randomLocation as! String{
                                    number = Int.random(in: 0...travelPlanLocationArray.count-1)
                            }
                        }while (uploadResultLocation[0] == randomLocation as! String || uploadResultLocation[6] == randomLocation as! String)
                    }
                    let randomDistrict = travelPlanLocationDistrict[number]
                    let randomType = travelPlanLocationType[number]
                    let randomMoney = travelPlanLocationMoney[number]
                    let randomLot = travelPlanLocationLot[number]
                    let randomLon = travelPlanlocationLon[number]
                    uploadResultLocation.append(randomLocation as! String)
                    uploadResultLocation.append(randomDistrict as! String)
                    uploadResultLocation.append(randomType as! String)
                    uploadResultLocation.append(randomMoney as! String)
                    uploadResultLocation.append(randomLot as! String)
                    uploadResultLocation.append(randomLon as! String)
                }
                totalMoney = (Int(uploadResultLocation[3]) ?? 0)+(Int(uploadResultLocation[9]) ?? 0)+(Int(uploadResultLocation[15]) ?? 0)
            }while (Int(requireMoney) < totalMoney)
        }
    }
}


