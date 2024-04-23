//
//  TravelPlanResultView.swift
//  SmartTravel
//
//  Created by jackychoi on 1/2/2024.
//

import SwiftUI
import Firebase

struct TravelPlanResultView: View {
    
    //MARK: travelPlanButton
    var onPost: (Post) -> ()
    
    // @Binding
    @Binding var resultStatus : Bool
    @Binding var uploadResultLocation: [String]
    @Binding var requireType: String
    @Binding var totalMoney: Int
    
    // State
    @State private var isDragging = false
    @State private var isLoading: Bool = false
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @StateObject var meterPrice = MapViewModel()
    
    /// - stored user data from userDefaults
    @AppStorage("user_profile_url") private var profileURL: URL?
    @AppStorage("user_name") private var userName: String = ""
    @AppStorage("user_UID") private var userUID: String = ""
    
    @State var destinationPlace : String = ""
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    //MARK: DATA CORE
    @State private var attraction1 = ""
    @State private var attraction2 = ""
    @State private var attraction3 = ""
    @State private var attraction4 = ""
    @State private var level = ""
    @State private var cost = ""
    
    var body: some View {
        
        VStack{
            //ride type selection view
            HStack{
                Text("SUGGESTED ROUTES")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .padding()
                    .padding(.top,10)
                Spacer()
                Button{
                    withAnimation(.easeInOut(duration: 1)){
                        resultStatus.toggle()
                    }
                }label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(Color(.systemGray3))
                        .padding()
                        
                        .background(.white)
                }
                .frame(width: 20, height: 20,alignment: .trailing)
            }
            ScrollView(.horizontal){
                HStack(spacing:10){
                        VStack(alignment:.center){
                            Image(uploadResultLocation[0])
                                .resizable()

                            Text(uploadResultLocation[0])
                                .font(.system(size: 13,weight: .semibold))
                                .frame(maxWidth: .infinity,alignment:.leading)
                                .padding(.leading,25)
                                .padding(.bottom,5)
                                .foregroundColor(.black)
                            
                            HStack{
                               Image(systemName: "mappin.and.ellipse")
                                    .frame(width: 5, height: 12)
                                    .foregroundColor(.black)
                                    .font(.system(size: 13,weight: .semibold))
                                Text(uploadResultLocation[1])
                                    .foregroundColor(.gray)
                                    .padding(.leading,1)
                                    .font(.system(size: 13,weight: .semibold))
                            }
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.leading,30)
                            .padding(.bottom,5)
                            Text("$\(uploadResultLocation[3])")
                                .font(.system(size: 13,weight: .semibold))
                                .padding(.bottom,18)
                                .frame(maxWidth: .infinity,alignment:.leading)
                                .padding(.leading,25)
                            
                        }
                        .frame(width: 180,height: 250)
                        .foregroundColor(.black)
                        .background(Color(.systemGroupedBackground))
                        .cornerRadius(20)
                    
                    VStack(alignment:.center){
                        Image(uploadResultLocation[6])
                            .resizable()
                        
                        Text(uploadResultLocation[6])
                            .font(.system(size: 13,weight: .semibold))
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.leading,25)
                            .padding(.bottom,5)
                            .foregroundColor(.black)
                        
                        HStack{
                           Image(systemName: "mappin.and.ellipse")
                                .frame(width: 5, height: 12)
                                .foregroundColor(.black)
                                .font(.system(size: 13,weight: .semibold))
                            Text(uploadResultLocation[7])
                                .foregroundColor(.gray)
                                .padding(.leading,1)
                                .font(.system(size: 13,weight: .semibold))
                        }
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.leading,30)
                        .padding(.bottom,5)
                        Text("$\(uploadResultLocation[9])")
                            .font(.system(size: 13,weight: .semibold))
                            .padding(.bottom,18)
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.leading,25)
                        
                    }
                    .frame(width: 180,height: 250)
                    .foregroundColor(.black)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(20)
                    
                    VStack(alignment:.center){
                        Image(uploadResultLocation[12])
                            .resizable()
                        
                        Text(uploadResultLocation[12])
                            .font(.system(size: 13,weight: .semibold))
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.leading,25)
                            .padding(.bottom,5)
                            .foregroundColor(.black)
                        
                        HStack{
                           Image(systemName: "mappin.and.ellipse")
                                .frame(width: 5, height: 12)
                                .foregroundColor(.black)
                                .font(.system(size: 13,weight: .semibold))
                            Text(uploadResultLocation[13])
                                .foregroundColor(.gray)
                                .padding(.leading,1)
                                .font(.system(size: 13,weight: .semibold))
                        }
                        .frame(maxWidth: .infinity,alignment:.leading)
                        .padding(.leading,30)
                        .padding(.bottom,5)
                        Text("$\(uploadResultLocation[15])")
                            .font(.system(size: 13,weight: .semibold))
                            .padding(.bottom,18)
                            .frame(maxWidth: .infinity,alignment:.leading)
                            .padding(.leading,25)
                        
                    }
                    .frame(width: 180,height: 250)
                    .foregroundColor(.black)
                    .background(Color(.systemGroupedBackground))
                    .cornerRadius(20)
                }
                .environmentObject(meterPrice)
            }
            .padding(.horizontal)
            .padding(.top,2)
            .padding(.bottom,30)

            //request ride button
            Button {
                createRoute()
            } label: {
                Text("CONFIRM ROUTES")
                    .fontWeight(.bold)
                    .frame(width: 289,height: 50)
                    .background(Color.init(hex: "#57BFD2",alpha: 1.0))
                    .cornerRadius(20)
                    .foregroundColor(.white)
            }
            .padding(.bottom,10)
            .refreshable {
                
            }
        }
        .padding(.bottom,35)
        .background(.white)
        .cornerRadius(20)
        .overlay {
            LoadingView(show: $isLoading)
        }
    }
    
    func createRoute(){
        isLoading = true
        Task{
            do{
                guard let profileURL = profileURL else{return}
                
                let post = Post(location1: uploadResultLocation[0], location2: uploadResultLocation[6], location3: uploadResultLocation[12], locationDistrict1: uploadResultLocation[1], locationDistrict2: uploadResultLocation[7], locationDistrict3: uploadResultLocation[13], locationType1: uploadResultLocation[2], locationType2: uploadResultLocation[8], locationType3: uploadResultLocation[14], locationRandomType: requireType, locationMoney1: uploadResultLocation[3], locationMoney2: uploadResultLocation[9], locationMoney3: uploadResultLocation[15], locationLot1: uploadResultLocation[4], locationLot2: uploadResultLocation[10], locationLot3: uploadResultLocation[16], locationLon1: uploadResultLocation[5], locationLon2: uploadResultLocation[11], locationLon3: uploadResultLocation[17], locationTotoalMoney: String(totalMoney), userName: userName, userUID: userUID, userProfileURL: profileURL)
                
                try await createDocumentAtFirebase(post)
            }catch{
                await setError(error)
            }
        }
    }
    
    func createDocumentAtFirebase(_ post: Post) async throws{
        /// - Writing document to firebase firestore
        var doc = Firestore.firestore().collection("Routes").document()
//        if requireType == "Cultural Tourism"{
//            doc = Firestore.firestore().collection("Cultural Routes").document()
//        }else if requireType == "Ecotourism"{
//            doc = Firestore.firestore().collection("Ecotourism Routes").document()
//        }else if requireType == "Sightseeing Tourism"{
//            doc = Firestore.firestore().collection("Sightseeing Routes").document()
//        }else{
//            doc = Firestore.firestore().collection("Extreme Routes").document()
//        }
        let _ = try doc.setData(from: post,completion: {
            error in
            if error == nil{
                isLoading = false
                var updatePost = post
                updatePost.id = doc.documentID
                onPost(updatePost)
                dismiss()
            }
        })
    }
    
    //MARK: Displaying errors as alert
    func setError(_ error: Error) async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

