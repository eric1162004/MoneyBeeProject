//
//  AppDelegate.swift
//  MoneyBee
//
//  Created by eric on 2022-03-15.
//
//  Set up Firebase when finish launch

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Initialize Firebase
        FirebaseApp.configure()
    
        return true
    }
}
