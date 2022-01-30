//
//  AppEarningsOrSpendingCard.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppEarningsOrSpendingCard: View {
    
    @State var title:String
    @State var subtitle: String
    @State var amount: Float
    @State var backgroundColor: Color = Color.primaryColor
    @State var swipeDeleteHandler: (() -> ())?
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                
                // cardTitle
                AppText(text: title, fontSize: FontSize.small, fontColor: .white)
                
                // cardSubtitle
                AppText(text: subtitle, fontSize: FontSize.tiny, fontColor: .white)
            }
            
            Spacer()
            
            // Money Amount
            AppMoneyAmountView(amount: amount)
            
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
        AppEarningsOrSpendingCard(title: "Making my own bed", subtitle: "Dec 16, 2021", amount: 2){}
    }
}
