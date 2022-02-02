//
//  SignInScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI
import Resolver

struct SignInScreen: View {
    
    // AuthenticationService is registered in Resolver.
    @ObservedObject var authService: AuthService = Resolver.resolve()
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var errorMsg : String?
    
    var body: some View {
        
        VStack{
            // top banner
            AppSignInAndSignUpTopBanner()
                .padding(.top, Dm.xlarge)
            
            // title
            AppText(text: "Sign In", fontSize: FontSize.xlarge, fontColor: .black)
            
            // form fields
            VStack(spacing: Dm.medium){
                // email text field
                AppTextField(text: $email, placeholder: "email", leadingIcon: "envelope")
                
                AppSecureField(password: $password)
                
                // error message
                if let errorMsg = errorMsg {
                    Text(errorMsg)
                        .bold()
                        .foregroundColor(.appRed)
                }
                
                // sign in button
                AppCapsuleButton(label: "Sign In", backgroundColor: Color.appGreen){
                    
                    errorMsg = nil
                    
                    guard !email.isEmpty, !password.isEmpty else{
                        errorMsg = "Fields cannot be empty."
                        return
                    }
                    
                    // TODO: Sign in user
                    authService.signIn(email: email, password: password, onError: {
                        error in print(error.localizedDescription)
                    }, onSuccess: {
                        print("user has signed in")
                    })
                    
                }
                
                // go to sign Up screen
                NavigationLink(destination: SignUpScreen()){
                    AppHyperLink(label: "Don't have an account?")
                }
                
            }.padding(.horizontal, Dm.medium)

            Spacer()
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
    }
}        

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}
