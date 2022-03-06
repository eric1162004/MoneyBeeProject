//
//  AppTextField.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppTextField: View {
    
    @Binding var text: String
    var placeholder: String = ""
    var keyboardType: UIKeyboardType = .default
    var leadingIcon: String = ""
    var trailingIcon: String = ""
    var trailingIconHandler: (() -> ())?
    
    var body: some View {
        HStack{
            
            // leading icon
            if(!leadingIcon.isEmpty){
                Image(systemName: leadingIcon)
                    .foregroundColor(Color.appLightGray)
            }

            // text field
            TextField("", text: $text)
                .placeholder(when: text.isEmpty) {
                    Text(placeholder).foregroundColor(Color.appLightGray)
            }
                .foregroundColor(Color.appLightGray)
                .font(Font.custom(Fonts.bubbleGum, size: FontSize.small))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .keyboardType(keyboardType)
            
            // trailing icon
            if(!trailingIcon.isEmpty){
                if let handler = trailingIconHandler {
                    Button {
                        handler()
                    } label: {
                        Image(systemName: trailingIcon)
                            .foregroundColor(Color.appLightGray)
                    }
                } else {
                    Image(systemName: trailingIcon)
                        .foregroundColor(Color.appLightGray)
                }
            }

        }
        .padding(Dm.small)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.separator), lineWidth: 4))
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        
    }
}

struct AppTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AppTextField(
                text: .constant("email"),
                leadingIcon: "person",
                trailingIcon: "person"
            )
        }
    }
}
