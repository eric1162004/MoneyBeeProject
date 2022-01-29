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
    var leadingIcon: String = ""
    var trailingIcon: String = ""
    var trailingIconHandler: (() -> ())?
    
    var body: some View {
        HStack{
            
            // leading icon
            if(!leadingIcon.isEmpty){
                Image(systemName: leadingIcon)
                    .foregroundColor(Color.secondary)
            }

            // text field
            TextField(placeholder, text: $text)
                .font(Font.custom(Fonts.bubbleGum, size: FontSize.small))
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
            
            // trailing icon
            if(!leadingIcon.isEmpty){
                if let handler = trailingIconHandler {
                    Button {
                        handler()
                    } label: {
                        Image(systemName: trailingIcon)
                    }
                } else {
                    Image(systemName: trailingIcon)
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
                leadingIcon: "person"
            )
        }
    }
}
