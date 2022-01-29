//
//  HomeScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ScrollView {
            VStack{
                // Topbar
                TopBar(title: "Money Bee", leadingIcon: "line.3.horizontal", leadingIconHandler: { print("pressed")})
//                    .padding(.top, Dm.large)
                
                // Screen Content
                VStack{
                    // User Avatar image and Greeting
                    HStack(alignment: .center){
                        Image("honeyBeeLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
                            .clipShape(Circle())
                        
                        AppText(text: "Hello, Justin!", fontSize: FontSize.large)
                        
                        // push everything to the left
                        Spacer()
                    }
                    
                    // Display Saving Amount
                    VStack{
                        AppText(text: "Your Total Saving:", fontSize: FontSize.large, fontColor: .white)
                        AppText(text: "$100", fontSize: FontSize.large, fontColor: .white)
                    }
                    .frame(maxWidth: .infinity, minHeight: 200)
                    .background(Color.primaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                    .shadow(radius: Dm.tiny)
                    .padding(.top, -Dm.medium)
                    .padding(.bottom, Dm.small)
                    
                    
                    // Buttons
                    VStack(spacing: Dm.small){
                        AppRoundedCornerButton(label: "Earnings", backgroundColor: Color.appGreen){}
                        AppRoundedCornerButton(label: "Spendings", backgroundColor: Color.appRed){}
                        AppRoundedCornerButton(label: "Wish List", backgroundColor: Color.appBlue){}
                    }
                    
                }
                .padding(.horizontal, Dm.medium)
                
                Spacer()
            }
            
            
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
       
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
