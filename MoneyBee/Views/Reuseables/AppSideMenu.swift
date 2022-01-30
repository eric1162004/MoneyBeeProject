//
//  AppSideMenu.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppSideMenu: View {
    
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        VStack{
            TopBar(title: "")
            
            AppCircularProfileImage(imageName: "honeyBeeLogo")
            
            // User name
            AppText(text: "Justin", fontSize: FontSize.medium)
            
            // edit profile button
            VStack {
                
                NavigationLink {
                    EditProfileScreen()
                } label: {
                    AppRoundedCornerButton(label: "Edit Profile", backgroundColor:  Color.appBlue)
                }

                Spacer()
                
                //
                AppRoundedCornerButton(label: "Logout", backgroundColor:  Color.appRed) {
                    
                    // log out user
                    $isAuthenticated.wrappedValue.toggle()
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
        AppSideMenu(isAuthenticated: .constant(true))
    }
}
