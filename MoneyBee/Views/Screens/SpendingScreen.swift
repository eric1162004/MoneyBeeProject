//
//  SpendingScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct SpendingScreen: View {
    
    @State private var showChartSheet = true
    
    var body: some View {
        
        VStack {
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
                    showChartSheet.toggle()
                })
            
            // Screen Content
            ScrollView{
                
                
                
            }
        }
        .sheet(isPresented: $showChartSheet) {
            SpendingChartView()
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
        .navigationBarHidden(true)
    }
}

struct SpendingChartView: View {
    
    // used to dismiss the sheetview: dismiss()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(){
            
            AppText(text: "Dec 2020", fontSize: FontSize.medium)
            
            SpendingTable()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Dm.medium)
        .background(Color.backgroundColor)
    }
}

struct SpendingTable: View {
    
    var body: some View {
        
        VStack{
            
            ForEach(1...4, id:\.self) { _ in
                HStack{
                    Circle()
                        .fill(Color.appGreen)
                        .frame(width: 50)
                    
                    Spacer()
                    
                    AppText(text: "Food", fontSize: FontSize.small)
                    
                    Spacer()
                    
                    AppText(text: "$200.00", fontSize: FontSize.small)
                }
            }
            
        }
        .padding(Dm.medium)
        .background()
        .opacity(0.95)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
        
    }
    
}

struct SpendingScreen_Previews: PreviewProvider {
    static var previews: some View {
        SpendingScreen()
    }
}
