//
//  TextFieldPlaceHolderExtension.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import Foundation
import SwiftUI

extension View {
    
    // allow us to change placeholder color by
    // exameple:
    //    TextField("", text: $text)
    //        .placeholder(when: text.isEmpty) {
    //            Text(placeholder).foregroundColor(.gray)
    //    }
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
