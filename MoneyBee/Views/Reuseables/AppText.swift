//
//  AppText.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppText: View {
    var text: String
    var fontSize: CGFloat = 18
    var fontColor: Color = .black
    
    var body: some View {
        Text(text)
            .font(.custom(Fonts.bubbleGum, size: fontSize))
            .foregroundColor(fontColor)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct AppText_Previews: PreviewProvider {
    static var previews: some View {
        AppText(text: "Hello Worldddddddddddddddddddddddddddddddddddddddddddd")
    }
}
