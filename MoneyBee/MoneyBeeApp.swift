//
//  MoneyBeeApp.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI
import Firebase

@main
struct MoneyBeeApp: App {
    
    // Set up Firebase when finish launch, see appDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            RootScreen()
        }
    }
}


