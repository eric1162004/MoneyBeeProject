//
//  AppCapsuleButton.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct AppCapsuleButton: View {
    
    let label: String
    var backgroundColor: Color = Color.primaryColor
    let handlePressed: () -> Void
    
    var body: some View {
        Button(action: {
            handlePressed()
        }){
            Text(label)
                .font(.custom(Fonts.bubbleGum, size: FontSize.medium))
                .frame(maxWidth: .infinity, minHeight: Dm.medium, alignment: .center)
                .padding()
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(CornerRadius.xlarge)
        }
    }
}

struct AppCapsuleButton_Previews: PreviewProvider {
    static var previews: some View {
        AppCapsuleButton(label: "Click me", backgroundColor: Color.appGreen){
            print("pressed")
        }
    }
}
