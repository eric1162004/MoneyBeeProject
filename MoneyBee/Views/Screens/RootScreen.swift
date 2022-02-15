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
    @State var isActive : Bool = false
    var body: some View {
        NavigationView{
            if isActive {
                if authService.user == nil {
                    SignInScreen()
                } else {
                    HomeScreen()
                }
                    } else {
                        SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                withAnimation {
                                    self.isActive = true
                                }
                            }
                        }
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
