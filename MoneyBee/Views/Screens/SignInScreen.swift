//
//  SignInScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct SignInScreen: View {
    
    @Binding var isAuthenticated: Bool
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var errorMsg : String?
    
    var body: some View {
        
        VStack{
            // top banner
            SignInAndSignUpTopBanner()
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
                    $isAuthenticated.wrappedValue.toggle()
                    print("\(email) \(password)")
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

struct SignInAndSignUpTopBanner: View {
    var body: some View {
        ZStack(alignment: .center){
            Image("honeyBeeLogo2")
                .resizable()
                .scaledToFit()
                .padding(.top, -Dm.medium)
            
            StrokeText(text: "Money Bee", width: 0.5, color: .black)
                .font(.custom(Fonts.bubbleGum, size: FontSize.xlarge))
                .foregroundColor(.white)
        }
        .background(Color.primaryColor)
    }
}
        

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen(isAuthenticated: .constant(false))
    }
}
