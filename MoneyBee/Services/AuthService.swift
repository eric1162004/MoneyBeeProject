//
//  AuthService.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import Firebase

class AuthService: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var user: User?
    
    init() {
        self.registerStateListener()
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // Success
            print("User has signed in.")
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) { result, error in
            guard result != nil, error == nil else { return }
            
            // sucess
            print("User has signed up.")
        }
    }
    
    func signOut(){
        try? auth.signOut()
    }
    
    private func registerStateListener(){
        Auth.auth().addStateDidChangeListener { auth, user in
            print("Sign in state has changed.")
            self.user = user
            
            if let user = user{
                let anonymous = user.isAnonymous ? "anonymously" : ""
                print("User signed in \(anonymous) with user ID \(user.uid)")
            }
            else {
                print("User signed out.")
            }
        }
    }
    
}

