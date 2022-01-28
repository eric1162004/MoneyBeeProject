//
//  ContentView.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        Text("Hello, world!")
            .font(.custom(Fonts.bubbleGum, size: 36))
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
