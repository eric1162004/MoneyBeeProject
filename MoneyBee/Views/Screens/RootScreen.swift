//
//  RootScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//
//  This is our application entry screen.

import SwiftUI

struct RootScreen: View {
    
    @State var isAuthenticated: Bool = false
    
    var body: some View {
        NavigationView{

            if !isAuthenticated {
                SignInScreen(isAuthenticated: $isAuthenticated)
            } else {
                HomeScreen(isAuthenticated: $isAuthenticated)
            }
            
//            SplashScreen()
//            SignInScreen()
//            HomeScreen()
//            EarningScreen()
//            SpendingScreen()
                
        }
    }
}

struct RootScreen_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
