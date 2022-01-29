//
//  AppHyperLink.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppHyperLink: View {
    
    var label: String
    var color: Color = .black
    var handlePress: (() -> ())?
    
    var body: some View {
        if let handler = handlePress {
            Button {
                handler()
            } label: {
                Text(label)
                    .font(.custom(Fonts.bubbleGum, size: FontSize.tiny))
                    .underline()
                    .foregroundColor(color)
            }
        } else {
            Text(label)
                .font(.custom(Fonts.bubbleGum, size: FontSize.tiny))
                .underline()
                .foregroundColor(color)
        }
    }
}

struct AppHyperLink_Previews: PreviewProvider {
    static var previews: some View {
        AppHyperLink(label: "Click me")
    }
}
