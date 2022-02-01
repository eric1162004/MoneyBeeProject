//
//  AppSpendingCard.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import SwiftUI

struct SpendingCard: View {
    
    @State var spending: Spending
    @State var backgroundColor: Color = Color.primaryColor
    @State var swipeDeleteHandler: (() -> ())?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                // cardTitle
                AppText(text: spending.title, fontSize: FontSize.small, fontColor: .white)
                
                // cardSubtitle
                AppText(text: spending.date.dateToString(), fontSize: FontSize.tiny, fontColor: .white)
            }
            
            Spacer()
            
            // Money Amount
            AppMoneyAmountView(amount: spending.amount)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, Dm.small)
        .padding(.vertical, Dm.medium)
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.large))
        
        // swipe delete gesture
        .swipeActions(edge: .leading) {
            Button(role: .destructive) {
                guard let swipeDeleteHandler = swipeDeleteHandler else {
                    return
                }
                
                swipeDeleteHandler()
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
        }

    }
}
