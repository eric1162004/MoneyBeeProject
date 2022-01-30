//
//  AppImageSelector.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppRoundedImageView: View {
    
    var imageName: String?
    var iconName: String?
    
    var body: some View {
        ZStack{
            if let imageName = imageName {
                
                // return image
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                
            } else if let iconName = iconName {
                
                // return a icon image
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
                
            } else{
                // if both imageName and iconName are not provided, then return a placeholder image
                Image(systemName: "nosign")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
            }

        }
        .padding(Dm.medium)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
    }
}

struct AppImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        AppRoundedImageView()
    }
}
