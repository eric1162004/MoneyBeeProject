//
//  RootScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//
//  This is our application entry screen.

import SwiftUI

struct RootScreen: View {
    var body: some View {
        NavigationView{
            SplashScreen()
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
