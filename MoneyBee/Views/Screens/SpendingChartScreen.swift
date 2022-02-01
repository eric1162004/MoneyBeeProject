//
//  SpendingChartScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import SwiftUI

struct SpendingChartView: View {
    
    // used to dismiss the sheetview: dismiss()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(){
            
            AppText(text: "Dec 2020", fontSize: FontSize.medium)
            
            // Spending Pie Chart
            PieChartView(values: [200.0, 180.0, 180.0, 100.0], colors: [Color.appGreen, Color.appBlue, Color.primaryColor, Color.appRed], backgroundColor: Color.clear)
            
            Spacer()
            
            SpendingTable()
                .frame(maxHeight: 280)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Dm.medium)
        .background(Color.backgroundColor)
    }
}


struct SpendingTable: View {
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                
                ForEach(1...4, id:\.self) { _ in
                    HStack{
                        Circle()
                            .fill(Color.appGreen)
                            .frame(width: geometry.size.width * 0.1)
                        
                        AppText(text: "Food", fontSize: FontSize.small)
                            .frame(width: geometry.size.width * 0.3)
                        
                        
                        AppText(text: "$100.00", fontSize: FontSize.small)
                            .frame(width: geometry.size.width * 0.4)
                    }
                    
                }
                
            }
            .padding(Dm.medium)
            .background(.white)
            .opacity(0.95)
            .clipShape(RoundedRectangle(cornerRadius: CornerRadius.large))
        }
        
    }
}
