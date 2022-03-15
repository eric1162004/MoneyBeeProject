//
//  AppWishItemCard.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI
import Resolver

struct AppWishItemCard: View {

    @Binding var wishItem: WishItem
    @State var backgroundColor: Color = Color.primaryColor
    @State var buyButtonHandler: (() -> ())?
    @State var swipeDeleteHandler: (() -> ())?

    var body: some View {
        
        let isBought = wishItem.purchased
        
        HStack{
            VStack{
                
                // wish item image
                if !wishItem.imageUrl.isEmpty{
                    AysncImageLoader(imageUrl: wishItem.imageUrl)
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                }
                
                // wish item title
                AppText(text: wishItem.title, fontSize: FontSize.small, fontColor: .white)
            }
            .frame(maxWidth: .infinity)
            
            VStack{
                
                // wish item cost
                AppMoneyAmountView(amount: wishItem.cost)
                
                // wish item buy button
                AppRoundedCornerNonIconButton(
                    label: isBought ? "Bought" : "Buy" ,
                backgroundColor: isBought ? Color.gray : Color.appGreen) {

                    buyButtonHandler?()
                    
                }
            }
            .frame(maxWidth: 150)
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
