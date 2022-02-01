//
//  AppEarningsOrSpendingCard.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct EarningCard: View {
    
    @State var earning: Earning
    @State var backgroundColor: Color = Color.primaryColor
    @State var swipeDeleteHandler: (() -> ())?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                // cardTitle
                AppText(text: earning.title, fontSize: FontSize.small, fontColor: .white)
                
                // cardSubtitle
                AppText(text: earning.date.dateToString(), fontSize: FontSize.tiny, fontColor: .white)
            }
            
            Spacer()
            
            // Money Amount
            AppMoneyAmountView(amount: earning.amount)
            
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

struct AppEarningsOrSpendingCard_Previews: PreviewProvider {
    static var previews: some View {
        EarningCard(earning: Earning(title: "hello", amount: 34, date: Date()))
    }
}
