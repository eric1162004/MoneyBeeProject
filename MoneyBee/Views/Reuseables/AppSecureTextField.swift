//
//  AppSecureTextField.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppSecureField: View {
    
    @Binding var password: String
    @State private var isSecured: Bool = true
    var leadingIcon: String = "lock"
    
    var body: some View {
        
        HStack {
            // leading icon
            if(!leadingIcon.isEmpty){
                Image(systemName: leadingIcon)
                    .foregroundColor(Color.secondary)
            }
            
            if isSecured {
                SecureField("password", text: $password)
                    .font(Font.custom(Fonts.bubbleGum, size: FontSize.small))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    
            } else {
                AppTextField(text: $password, placeholder: "password", leadingIcon: "lock")
            }
            
            // Button to toggle password field display
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .foregroundColor(Color.secondary)
            }
        }
        .padding(Dm.small)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.separator), lineWidth: 4))
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

struct AppSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppSecureField(password: .constant("123456"))
        }
    }
}
