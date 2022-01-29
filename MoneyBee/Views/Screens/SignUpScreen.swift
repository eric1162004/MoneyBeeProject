//
//  SignUpScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct SignUpScreen: View {
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    
    @State var errorMsg : String?
    
    // allow us to pop the current view off the navigation stack
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        
        ScrollView {
            VStack{
                // top banner
                SignInAndSignUpTopBanner()
//                    .padding(.top, Dm.xlarge)
                
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
                        
                        // TODO: Sign up user
                        print("\(name) \(email) \(password) \(confirmPassword)")
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
