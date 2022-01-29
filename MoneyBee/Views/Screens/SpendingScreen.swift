//
//  SpendingScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct SpendingScreen: View {
    var body: some View {
        ScrollView {
            VStack{
                // Topbar
                TopBar(
                    title: "Spendings",
                    leadingIcon: "chevron.left",
                    trailingIcon: "chart.pie.fill",
                    backgroundColor: Color.appRed,
                    leadingIconHandler: {
                        print("pressed")
                        
                    },
                    trailingIconHandler: {
                        print("pressed piechart")
                    })
                
                // Screen Content
                VStack{
                    
                    
                    Spacer()
                }
                
                
            }

        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct SpendingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SpendingScreen()
    }
}
