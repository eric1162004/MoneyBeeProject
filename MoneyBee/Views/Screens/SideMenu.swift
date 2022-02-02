//
//  AppSideMenu.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct SideMenu: View {
    
    @ObservedObject var appUserViewModel: AppUserViewModel = Resolver.resolve()
    
    // AuthenticationService is registered in Resolver.
    @ObservedObject var authService: AuthService = Resolver.resolve()
    
    var body: some View {
        VStack{
            TopBar(title: "")
            
            if !appUserViewModel.appUser.imageUrl.isEmpty{
                AysncImageLoader(imageUrl: appUserViewModel.appUser.imageUrl)
                    .scaledToFit()
                    .frame(width: 150, height: 150, alignment: .center)
                    .background(.white)
                    .clipShape(Circle())
                    .padding(.bottom)
                
            } else {
                AppCircularProfileImage(imageName: "honeyBeeLogo")
            }
            
            // User name
            AppText(text: appUserViewModel.appUser.name, fontSize: FontSize.medium)
            
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
                    authService.signOut()
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
        SideMenu()
    }
}
