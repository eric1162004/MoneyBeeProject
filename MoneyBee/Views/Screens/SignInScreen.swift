//
//  SignInScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct SignInScreen: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        
        VStack{
            // top banner
            TopBanner()
                .padding(.top, Dm.xlarge)
            
            // title
            AppText(text: "Sign In", fontSize: FontSize.xlarge, fontColor: .black)
            
            // form fields
            VStack(spacing: Dm.medium){
                // email text field
                AppTextField(text: $email, placeholder: "email", leadingIcon: "envelope")
                
                AppSecureField(password: $password)
                
                // sign in button
                AppCapsuleButton(label: "Sign In", backgroundColor: Color.appGreen){
                    print("pressed")
                }
                
                // go to sign Up screen
                AppHyperLink(label: "Don't have an account?"){
                    print("pressed")
                }
                
            }.padding(.horizontal, Dm.medium)

            Spacer()
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
    }
}


private struct TopBanner: View {
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
        SignInScreen()
    }
}
