//
//  AppFloatingButton.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppFloatingButton: View {
    
    let iconName: String
    var iconBackgroundColor: Color = Color.primaryColor
    var pressHandler: (() -> ())?
    
    var body: some View {
        
        Button {
            
            guard let pressHandler = pressHandler else {
                return
            }
            
            // hanlder floating action press
            print("pressed")
            pressHandler()
    
            
        } label: {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding()
                .foregroundColor(.white)
                .background(iconBackgroundColor)
                .clipShape(Circle())
        }
        .overlay(Circle().stroke(.white, lineWidth: 2))
        .shadow(color: .gray, radius: 5, x: 0, y: 2)
        .zIndex(1)
    }
}

struct AppFloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        AppFloatingButton(iconName: "plus")
    }
}
