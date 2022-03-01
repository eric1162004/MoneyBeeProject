//
//  ContentView.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct SplashScreen: View {
    
    var body: some View {

        VStack{
            Spacer()
            
            // title
            StrokeText(text: "Money Bee", width: 0.5, color: .black)
                .foregroundColor(Color.primaryColor)
                .font(.custom(Fonts.bubbleGum, size: 60))
                .padding(.bottom, Dm.large)
            
            // App logo
            Image("honeyBeeLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 250, alignment: .center)
            
            // Subtitle
            AppText(text: "Money Tracker",
                    fontSize: FontSize.medium)
            AppText(text: "for kids",
                    fontSize: FontSize.small)
            
            Spacer()
            
        }.ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColor)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
