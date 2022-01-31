//
//  AppSignInAndSignUpTopBanner.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import SwiftUI

struct AppSignInAndSignUpTopBanner: View {
    var body: some View {
        ZStack(alignment: .center){
            Image("honeyBeeLogo2")
                .resizable()
                .scaledToFit()
                .padding(.top, -Dm.medium)
            
            StrokeText(text: "Money Bee", width: 0.5, color: .black)
                .font(.custom(Fonts.bubbleGum, size: FontSize.xlarge))
                .foregroundColor(.white)
        }
        .background(Color.primaryColor)
    }
}

struct AppSignInAndSignUpTopBanner_Previews: PreviewProvider {
    static var previews: some View {
        AppSignInAndSignUpTopBanner()
    }
}
