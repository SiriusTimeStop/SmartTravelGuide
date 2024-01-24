//
//  RegisterView.swift
//  SmartPaint
//
//  Created by jackychoi on 4/1/2024.
//

import SwiftUI
import PhotosUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

//MARK: register view
struct RegisterView: View{
    
    @State var emailID: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var userBio: String = ""
    @State var userProfilePicData: Data?
    
    //MARK: view properties
    @Environment(\.dismiss) var dismiss
    @State var showImagePicker: Bool = false
    @State var photoItem: PhotosPickerItem?
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isLoading: Bool = false
    // MARK: UserDefaults
    @AppStorage("log_status") var logStatus: Bool = false
    @AppStorage("user_profile_url") var profileURL: URL?
    @AppStorage("user_name") var userNameStored: String = ""
    @AppStorage("user_UID") var userUID: String = ""
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View{
        
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            verticalLayout
        } else {
            horizontalLayout
        }
    }
    
    @ViewBuilder
    private var verticalLayout: some View {
        VStack(spacing: 10){
            Text("Register")
                .font(.largeTitle.bold())
                .hAlign(.leading)
            
            Text("Register SmartPaint Account")
                .font(.title3)
                .hAlign(.leading)
            
            // MARK: for smaller size optimization
            ViewThatFits{
                ScrollView(.vertical,showsIndicators: false){
                    HelperView()
                }
                HelperView()
            }
            
            //MARK: register button
            HStack{
                Text("Already have an account?")
                    .foregroundColor(.gray)
                
                Button("Login Now"){
                    dismiss()
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
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem){
            newValue in
            //MARK: Extracting UIImage form photoItem
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                        
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
        
        //MARK: Display alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    @ViewBuilder
    private var horizontalLayout: some View {
        HStack(spacing: 20){
            VStack(alignment: .leading,spacing: 10){
                Text("Register")
                    .font(.largeTitle.bold())
                    .hAlign(.leading)
                
                Text("Register SmartPaint Account")
                    .font(.title3)
                    .hAlign(.leading)
                
                //MARK: register button
                HStack{
                    Text("Already have an account?")
                        .foregroundColor(.gray)
                    
                    Button("Login Now"){
                        dismiss()
                    }
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                }
                .font(.callout)
                .hAlign(.leading)
            }
            VStack{
                // MARK: for smaller size optimization
                ViewThatFits{
                    ScrollView(.vertical,showsIndicators: false){
                        HelperView()
                    }
                    HelperView()
                }
            }
        }
        .vAlign(.top)
        .padding(15)
        .overlay(content: {
            LoadingView(show: $isLoading)
        })
        .photosPicker(isPresented: $showImagePicker, selection: $photoItem)
        .onChange(of: photoItem){
            newValue in
            //MARK: Extracting UIImage form photoItem
            if let newValue{
                Task{
                    do{
                        guard let imageData = try await newValue.loadTransferable(type: Data.self) else{return}
                        
                        await MainActor.run(body: {
                            userProfilePicData = imageData
                        })
                    }catch{}
                }
            }
        }
        
        //MARK: Display alert
        .alert(errorMessage, isPresented: $showError, actions: {})
    }
    
    @ViewBuilder
    func HelperView() -> some View{
        VStack(spacing: verticalSizeClass == .regular ? 12 : 5){
            ZStack{
                if let userProfilePicData, let image = UIImage(data: userProfilePicData){
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }else{
                    Image("NullProfile")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            .frame(width: 85, height: 85)
            .clipShape(Circle())
            .contentShape(Circle())
            .onTapGesture {
                showImagePicker.toggle()
            }
            .padding(.top, horizontalSizeClass == .compact ? 25 : 0)
            
            TextField("Username",text: $userName)
                .textContentType(.emailAddress)
                .border(1,.gray.opacity(0.5))
                .padding(.top, horizontalSizeClass == .compact ? 25 : 0)
                
            TextField("Email",text: $emailID)
                .textContentType(.emailAddress)
                .border(1,.gray.opacity(0.5))
            
           SecureField("Password",text: $password)
                .textContentType(.emailAddress)
                .border(1,.gray.opacity(0.5))
            
            TextField("About you (Optional)",text: $userBio)
                .textContentType(.emailAddress)
                .border(1,.gray.opacity(0.5))
            
            Button(action: registerUser) {
                Text("Sign up")
                    .foregroundColor(.black)
                    .hAlign(.center)
                    .frame(height: 54)
                    .foregroundColor(.white)
                    .background(.brown)
                    .cornerRadius(10)
                    .font(.title2)
            }
            .disableWithOpacity(userName == "" ||  emailID == "" || password == "" || userProfilePicData == nil)
            .padding(.top,verticalSizeClass == .regular ? 10 : 5)
        }
    }
    
    func registerUser(){
        isLoading = true
        closeKeyboard()
        Task{
            do{
                //create firebase account
                try await Auth.auth().createUser(withEmail: emailID, password: password)
                
                guard let userUID = Auth.auth().currentUser?.uid else{return}
                guard let imageData = userProfilePicData else{return}
                let storageRef  = Storage.storage().reference().child("Profile_Images").child(userUID)
                let _ = try await storageRef.putDataAsync(imageData)
                
                let downloadURL = try await storageRef.downloadURL()
                
                userBio = BioRule(userBio: userBio)
                
                let user = User(username: userName, userBio: userBio, userUID: userUID, userEmail: emailID, userProfileURL: downloadURL)
                
                let _ = try Firestore.firestore().collection("Users").document(userUID).setData(from: user,completion: {
                    error in
                    if error == nil{
                        print("save successful")
                        userNameStored = userName
                        self.userUID = userUID
                        profileURL = downloadURL
                        logStatus = true
                    }
                })
            }catch{
                //MARK: Deleting created account in case of failure
                try await Auth.auth().currentUser?.delete()
                await setError(error)
            }
        }
    }
    
    func setError(_ error: Error)async{
        await MainActor.run(body: {
            errorMessage = error.localizedDescription
            showError.toggle()
            isLoading = false
        })
    }
    
    func BioRule(userBio: String) -> String{
        if userBio.count <= 0{
            return "Welcome to SmartPaint"
        }else if userBio.count > 20{
            return "Over maximum limit"
        }
        else{
            return userBio
        }
    }
}

#Preview {
   RegisterView()
}
