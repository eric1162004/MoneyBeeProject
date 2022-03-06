//
//  AppSecureTextField.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppSecureField: View {
    
    @State var label: String = "password"
    @Binding var password: String
    @State private var isSecured: Bool = true
    var leadingIcon: String = "lock"
    
    var body: some View {
        
        if isSecured {
            
            HStack {
                // leading icon
                if(!leadingIcon.isEmpty){
                    Image(systemName: leadingIcon)
                        .foregroundColor(Color.appLightGray)
                }
        
                SecureField(label, text: $password)
                    .placeholder(when: password.isEmpty) {
                        Text(label).foregroundColor(Color.appLightGray)
                }
                    .foregroundColor(Color.appLightGray)
                    .font(Font.custom(Fonts.bubbleGum, size: FontSize.small))
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    
                
                // Button to toggle password field display
                Button(action: {
                    isSecured.toggle()
                }) {
                    Image(systemName: self.isSecured ? "eye.slash" : "eye")
                        .foregroundColor(Color.appLightGray)
                }
            }
            .padding(Dm.small) 
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.separator), lineWidth: 4))
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
            
        }else {
            AppTextField(text: $password, placeholder: "password", leadingIcon: "lock", trailingIcon: "eye", trailingIconHandler: { isSecured.toggle() })
        }

        
    }
}

struct AppSecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AppSecureField(password: .constant("123456"))
        }
    }
}
