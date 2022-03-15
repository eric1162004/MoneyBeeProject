//
//  SignUpScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI
import Resolver

struct SignUpScreen: View {
    
    // AuthenticationService is registered in Resolver.
    @ObservedObject var authService: AuthService = Resolver.resolve()
    
    @ObservedObject var appUserViewModel: AppUserViewModel = Resolver.resolve()
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isChecked: Bool = false
    
    @State var errorMsg : String?
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ScrollView {
            VStack{
                // top banner
                AppSignInAndSignUpTopBanner()
                
                // title
                AppText(text: "Sign Up", fontSize: FontSize.xlarge, fontColor: .black)
                
                // form fields
                VStack(spacing: Dm.medium){
                    // name text field
                    AppTextField(text: $name, placeholder: "name", leadingIcon: "person")
                    
                    // email text field
                    AppTextField(text: $email, placeholder: "email", leadingIcon: "envelope")
                    
                    // password field
                    AppSecureField(label: "password", password: $password)
                    
                    // confirm password
                    AppSecureField(label: "Confirm Password", password: $confirmPassword)
                    
                    // parent's consent checkbox
                    Button {
                        isChecked = !isChecked
                    } label: {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Image(systemName: isChecked ? "checkmark.square": "square")
                                AppText(text: "I have obtained parental consent to use this app")
                                
                            }.foregroundColor(.black)
                        }
                    }

                    // error message
                    if let errorMsg = errorMsg {
                        Text(errorMsg)
                            .bold()
                            .foregroundColor(.appRed)
                    }
                    
                    // sign in button
                    AppCapsuleButton(label: "Sign In", backgroundColor: Color.appBlue){
                        
                        errorMsg = nil
                        
                        // ensure all fields are not empty
                        guard !email.isEmpty, !password.isEmpty, !name.isEmpty, !confirmPassword.isEmpty else{
                            errorMsg = "Fields cannot be empty."
                            return
                        }
                        
                        // ensure passwords are matching
                        guard password == confirmPassword else {
                            errorMsg = "Passwords are not matching."
                            return
                        }
                        
                        // ensure checkbox is checked
                        guard isChecked else {
                            errorMsg = "Make sure have your parents consent."
                            return
                        }
                        
                        // TODO: Sign up user
                        print("\(name) \(email) \(password) \(confirmPassword)")
                        
                        authService.signUp(email: email, password: password, onError: { error in
                            print(error.localizedDescription)
                            errorMsg = "\(error.localizedDescription)"
                        }, onSuccess:{
                            appUserViewModel.add(AppUser(name: name, email: email))
                        })
                    }
                    
                    // back to sign Up screen
                    AppHyperLink(label: "Already have an account?"){
                        presentation.wrappedValue.dismiss()
                    }
                    
                }.padding(.horizontal, Dm.medium)

                Spacer()
            }
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct SignUpScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreen()
    }
}
