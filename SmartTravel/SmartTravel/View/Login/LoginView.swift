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

        VStack(spacing: 30){
            Text("SmartTravel")
                .font(.system(size: 46).bold())
                .hAlign(.center)
                
            
            Text("Sign In SmartTravel Account")
                .font(.system(size: 15))
                .hAlign(.center)
                

            VStack(spacing: 30){
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(15.0)
                        .shadow(color: Color.black.opacity(0.1),radius: 10,x: 0.0,y: 4.0)
                    HStack(spacing:5){
                        Image(systemName: "envelope.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.gray)
                            .frame(width: 35)
                        TextField("Email",text: $emailID)
                            .textContentType(.emailAddress)
                            .accentColor(.gray)
                    }
                    .padding()
                }
                .padding(.top,50)
                
                ZStack{
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(15.0)
                        .shadow(color: Color.black.opacity(0.1),radius: 10,x: 0.0,y: 4.0)
                    HStack(spacing:5){
                        Image(systemName: "lock.fill")
                            .font(.system(size: 22))
                            .foregroundColor(.gray)
                            .frame(width: 35)
                        
                       SecureField("Password",text: $password)
                            .textContentType(.emailAddress)
                    }
                    .padding()
                }
                
                Button("Reset password?",action: resetPassword)
                    .font(.callout)
                    .fontWeight(.medium)
                    .tint(.black)
                    .hAlign(.trailing)
                    .alert(isPresented: $showError) {
                        Alert(
                            title: Text("Error"),
                            message: Text(errorMessage),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                
                Button {
                    loginUser()
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .hAlign(.center)
                        .frame(height: 54)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(10)
                        .font(.title2)
                }
                .padding(.top,10)
            }
            
            //MARK: register button
            HStack{
                Text("Don't have an account?")
                    .foregroundColor(.secondary)
                
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
        .padding(40)
        .padding(.top,60)
        .background(Image("background")
            .resizable()
            .edgesIgnoringSafeArea(.all))
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
                await showAlert(title: "Password Reset", message: "A password reset link has been sent to your email.")
            }catch{
                await setError(error)
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        errorMessage = message
        showError = true
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

