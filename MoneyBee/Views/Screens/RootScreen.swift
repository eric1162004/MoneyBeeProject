//
//  RootScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//
//  This is our application entry screen.

import SwiftUI
import Resolver

struct RootScreen: View {
    
    // AuthenticationService is registered in Resolver.
    @ObservedObject var authService: AuthService = Resolver.resolve()
    
//    @State var isAuthenticated: Bool = false
    
    var body: some View {
        NavigationView{

            if authService.user == nil {
                SignInScreen()
            } else {
                HomeScreen()
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
