//
//  AppSideMenu.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppSideMenu: View {
    
    
    var body: some View {
        VStack{
            TopBar(title: "")
            
            AppCircularProfileImage(imageName: "honeyBeeLogo")
            
            // User name
            AppText(text: "Justin", fontSize: FontSize.medium)
            
            // edit profile button
            VStack {
                AppRoundedCornerButton(label: "Edit Profile", backgroundColor:  Color.appBlue) {
                    
                    // navigate to edit profile screen
                    print("pressed")
                }
                
                Spacer()
                
                //
                AppRoundedCornerButton(label: "Logout", backgroundColor:  Color.appRed) {
                    
                    // log out user
                    print("pressed")
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom, Dm.xlarge * 2)
            
        }
        .shadow(color: .gray, radius: 2, x: 1, y: 1)
        .ignoresSafeArea()

    }
}

struct AppSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        AppSideMenu()
    }
}
