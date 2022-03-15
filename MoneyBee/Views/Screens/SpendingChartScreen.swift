//
//  SpendingChartScreen.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//
//  A piechart view

import SwiftUI
import Resolver

struct SpendingChartView: View {
    
    // required to query all spendings
    @ObservedObject var spendingVM : SpendingViewModel = Resolver.resolve()
    
    // used to dismiss the sheetview: dismiss()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        GeometryReader { geometry in
            VStack(){
                // Spending Pie Chart
                if let totalAmount = spendingVM.spendingChartTotalAmounts {
                    
                    // if a specific monthyear is not selected, the piechart will show all spendings
                    AppText(text: spendingVM.selectedMonthYear?.value ?? "Overall Spending", fontSize: FontSize.medium)
                    
                    PieChartView(
                        values: totalAmount,
                        colors: spendingVM.spendingChartTypeColors,
                        backgroundColor: Color.clear)
                        .frame(maxHeight: geometry.size.height * 0.4)
                        .scaledToFit()
                    
                    Spacer()
                    
                    // show spending type color and spending cost
                    SpendingTable()
                        .frame(maxHeight: geometry.size.height * 0.4)
                        .padding(.bottom)
                    
                    Spacer()
                    
                } else {
                    // if not spending data, ask user to select a month
                    AppText(text: "Please select a month.", fontSize: FontSize.large)
                }
            }
        }
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
                    // show a spending type row in the table
                    HStack{
                        // spending color
                        Circle()
                            .fill(SpendingType.color)
                            .frame(width: geometry.size.width * 0.1)
                        
                        AppText(text: SpendingType.name, fontSize: FontSize.small)
                            .frame(width: geometry.size.width * 0.3)
                        
                        // convent cost from float to string
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
