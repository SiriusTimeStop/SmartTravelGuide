//
//  LoginView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

struct LoginView: View {
    
    //MARK: user information
    @State var emailID: String = ""
    @State var password: String = ""
    //MARK: View Properties
    @State var createAccount: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    // MARK: UserDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    var body: some View {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            verticalLayout
        } else {
            horizontalLayout
        }
    }
    
    @ViewBuilder
    private var horizontalLayout: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("SmartTravel")
                    .font(.largeTitle.bold())
                
                Text("Sign In SmartTravel Account")
                    .font(.title3)
                
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
            }
            
            VStack(spacing: 12) {
                TextField("Email",text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1,.gray.opacity(0.5))
                    .padding(.top,25)
                
                SecureField("Password",text: $password)
                    .textContentType(.emailAddress)
                    .border(1,.gray.opacity(0.5))
                
                Button("Reset password?",action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                
                Button {
                    loginUser()
                } label: {
                    Text("Sign in")
                        .foregroundColor(.black)
                        .hAlign(.center)
                        .frame(height: 54)
                        .foregroundColor(.white)
                        .background(.brown)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .padding(.top,10)
                
                //MARK: register button
                HStack{
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Register Now"){
                        createAccount.toggle()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
                .font(.callout)
                .vAlign(.bottom)
            }
        }
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        //MARK: register view via sheets
        .fullScreenCover(isPresented: $createAccount){
            RegisterView()
        }
        //MARK: Display alert
        .alert(errorMessage,isPresented: $showError, actions: {})
    }
    
    @ViewBuilder
    private var verticalLayout: some View {
        VStack(spacing: 10){
            Text("SmartTravel")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Sign In SmartTravel Account")
                .font(.title3)
                .hAlign(.leading)
            
            Image("AppLogo")
                .resizable()
                .scaledToFit()
                .padding(.top,25)
            
            VStack(spacing: 12){
                TextField("Email",text: $emailID)
                    .textContentType(.emailAddress)
                    .border(1,.gray.opacity(0.5))
                    .padding(.top,25)
                
               SecureField("Password",text: $password)
                    .textContentType(.emailAddress)
                    .border(1,.gray.opacity(0.5))
                
                Button("Reset password?",action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                
                Button {
                    loginUser()
                } label: {
                    Text("Sign in")
                        .foregroundColor(.black)
                        .hAlign(.center)
                        .frame(height: 54)
                        .foregroundColor(.white)
                        .background(.brown)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .padding(.top,10)
            }
            
            //MARK: register button
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(.gray)
                
                Button("Register Now"){
                    createAccount.toggle()
                }
                .fontWeight(.bold)
                .foregroundColor(.black)
            }
            .font(.callout)
            .vAlign(.bottom)
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        //MARK: register view via sheets
        .fullScreenCover(isPresented: $createAccount){
            RegisterView()
        }
        //MARK: Display alert
        .alert(errorMessage,isPresented: $showError, actions: {})
    }
    
    func loginUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                try await Auth.auth().signIn(withEmail: emailID, password: password)
                print("User Found")
                try await fetchUser()
            }catch{
                await setError(error)
            }
        }
    }
    
    func resetPassword(){
        Task{
            do{
                try await Auth.auth().sendPasswordReset(withEmail: emailID)
                print("Link Sent")
            }catch{
                await setError(error)
            }
        }
    }
    
    //MARK: if user if found then fetching user data from firestore
    func fetchUser()async throws{
        guard let userID = Auth.auth().currentUser?.uid else{return}
        let user = try await Firestore.firestore().collection("Users").document(userID).getDocument(as: User.self)
        
        await MainActor.run(body: {
            userUID = userID
            userNameStored = user.username
            profileURL = user.userProfileURL
            logStatus = true
        })
    }
    
    //MARK: display errors
    func setError(_ error: Error)async{
        //MARK: UI must be updated
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
}

#Preview {
    LoginView()
}

