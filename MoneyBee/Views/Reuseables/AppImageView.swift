//
//  AppImageSelector.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppImageView: View {
    
    var uiImage: UIImage?
    var imageUrl: String?
    var imageName: String?
    var iconName: String?
    
    var body: some View {
            if let uiImage = uiImage {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
            else if let imageUrl = imageUrl {
                
                AysncImageLoader(imageUrl: imageUrl)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))

            }
            else if let imageName = imageName {
                
                // return image
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                
            }
            else if let iconName = iconName {
                
                // return a icon image
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                
            }
            else {
                // if both imageName and iconName are not provided, then return a placeholder image
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .padding()
            }
        
    }
}

struct AppImageSelector_Previews: PreviewProvider {
    static var previews: some View {
        AppImageView(imageUrl: "https://i.guim.co.uk/img/media/c5e73ed8e8325d7e79babf8f1ebbd9adc0d95409/2_5_1754_1053/master/1754.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=b6ba011b74a9f7a5c8322fe75478d9df")
    }
}
