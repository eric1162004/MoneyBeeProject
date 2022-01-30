//
//  AppRoundedCornerButton.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppRoundedCornerButton: View {
    
    var label: String
    var backgroundColor: Color = Color.primaryColor
    var height: CGFloat = Dm.xlarge
    var fontSize: CGFloat = FontSize.small
    var handlePress: () -> ()
    
    var body: some View {
        Button {
           handlePress()
        } label: {
            AppText(text: label, fontSize: fontSize, fontColor: .white)
                .frame(maxWidth: .infinity, minHeight: height)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
        }
    }
}

struct AppRoundedCornerButton_Previews: PreviewProvider {
    static var previews: some View {
        AppRoundedCornerButton(label: "click me"){}
    }
}