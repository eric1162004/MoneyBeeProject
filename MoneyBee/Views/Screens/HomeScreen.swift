//
//  HomeScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-28.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        VStack{
            // Topbar
            HStack{
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.horizontal)
                
                Spacer()
                
                AppText(text: "Money Bee", fontSize: FontSize.large, fontColor: Color.white)
                
                Spacer()
                
                Image(systemName: "line.3.horizontal")
                    .resizable()
                    .scaledToFit()
                    .frame(width:40, height: 40)
                    .padding(.horizontal)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, Dm.medium)
            .background(Color.primaryColor)
            
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
        .background(Color.backgroundColor)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
