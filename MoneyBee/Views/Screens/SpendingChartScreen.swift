//
//  SpendingChartScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import SwiftUI
import Resolver

struct SpendingChartView: View {
    
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    // used to dismiss the sheetview: dismiss()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(){
            // Spending Pie Chart
            if let totalAmount = spendingVM.spendingChartTotalAmounts {
                AppText(text: spendingVM.selectedMonthYear?.value ?? "Overall Spending", fontSize: FontSize.medium)
                
                PieChartView(values: totalAmount, colors: spendingVM.spendingChartTypeColors, backgroundColor: Color.clear)
                
                Spacer()
                
                SpendingTable()
                    .frame(maxHeight: 280)
                
            } else {
                AppText(text: "Please select a month.", fontSize: FontSize.large)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(Dm.medium)
        .background(Color.backgroundColor)
    }
}


struct SpendingTable: View {
    
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    var body: some View {
        
        GeometryReader{ geometry in
            VStack{
                
                ForEach(spendingVM.spendingTypes, id:\.name) { SpendingType in
                    HStack{
                        Circle()
                            .fill(SpendingType.color)
                            .frame(width: geometry.size.width * 0.1)
                        
                        AppText(text: SpendingType.name, fontSize: FontSize.small)
                            .frame(width: geometry.size.width * 0.3)
                        
                        let moneyAmount = String(format:"$%.2f", spendingVM.spendingChartTotalAmounts![spendingVM.getSpendingTypeIndex(SpendingType)])
                        
                        AppText(text: moneyAmount,
                                fontSize:FontSize.small)
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
