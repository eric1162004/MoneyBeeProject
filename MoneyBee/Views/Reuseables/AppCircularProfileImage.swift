//
//  AppCircularProfileImage.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppCircularProfileImage: View {
    
    @State var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150, alignment: .center)
            .padding()
            .background(.white)
            .clipShape(Circle())
            .padding(.bottom)
    }
}

struct AppCircularProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        AppCircularProfileImage(imageName: "honeyBeeLogo")
    }
}
