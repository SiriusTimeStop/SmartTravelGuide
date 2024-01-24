//
//  ProfileView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore

struct ProfileView: View {
    //MARK: my profile data
    @State private var myProfile: User?
    @AppStorage("log_status") var logStatus: Bool = false
    
    @State var errorMessage: String = ""
    @State var showError: Bool = false
    @State var isloading: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                if let myProfile{
                    ReusableProfileContent(user: myProfile)
                        .refreshable {
                            //MARK: refresh user data
                            self.myProfile = nil
                            await fetchUserData()
                        }
                }else{
                    ProgressView()
                }
            }
            .navigationTitle("My Profile")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        //MARK: logout
                        Button("Logout",action: logOutUser)
                        
                        //MARK: delete account
                        Button("Delete Account",role: .destructive,action: deleteAccount)
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .rotationEffect(.init(degrees: 90))
                            .tint(.black)
                            .scaleEffect(0.8)
                    }
                }
            }
        }
        .overlay{
            LoadingView(show: $isloading)
        }
        .alert(errorMessage,isPresented: $showError){
        }
        .task {
            if myProfile != nil{return}
            //MARK: Initial Fetch
            await fetchUserData()
        }
    }
    //MARK: fetching user data
    func fetchUserData() async{
        guard let userUID = Auth.auth().currentUser?.uid else{return}
        guard let user = try? await Firestore.firestore().collection("Users").document(userUID).getDocument(as: User.self) else{return}
        await MainActor.run(body: {
            myProfile = user
        })
    }
    
    //MARK: logout
    func logOutUser(){
        try? Auth.auth().signOut()
        logStatus = false
    }
    
    // MARK: deleting user account
    func deleteAccount(){
        isloading = true
        Task{
            do{
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                
                let reference  = Storage.storage().reference().child("Profile_Images").child(userUID)
                try await reference.delete()
                
                try await Firestore.firestore().collection("Users").document(userUID).delete()
                
                try await Auth.auth().currentUser?.delete()
                logStatus = false
            }catch{
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error) async{
        await MainActor.run(body: {
            isloading = false
            errorMessage = error.localizedDescription
            showError.toggle()
        })
    }
}

#Preview {
    ProfileView()
}

