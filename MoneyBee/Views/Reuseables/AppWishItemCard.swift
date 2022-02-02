//
//  AppWishItemCard.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppWishItemCard: View {

    @State var wishItem: WishItem
    @State var backgroundColor: Color = Color.primaryColor
    @State var buyButtonHandler: (() -> ())?
    @State var swipeDeleteHandler: (() -> ())?
    
    var body: some View {
        
        HStack{
            VStack{
                
                if !wishItem.imageUrl.isEmpty{
                    AysncImageLoader(imageUrl: wishItem.imageUrl)
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: CornerRadius.medium))
                }
                
                AppText(text: wishItem.title, fontSize: FontSize.small, fontColor: .white)
            }
            .frame(maxWidth: .infinity)
            
            VStack{
                AppMoneyAmountView(amount: wishItem.cost)
                
                AppRoundedCornerButton(label: "Buy!", backgroundColor: Color.appGreen) {
                    
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

struct AppWishItemCard_Previews: PreviewProvider {
    static var previews: some View {
        AppWishItemCard(wishItem: WishItem(title: "cat", cost: 20, imageUrl: "https://i.guim.co.uk/img/media/c5e73ed8e8325d7e79babf8f1ebbd9adc0d95409/2_5_1754_1053/master/1754.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=b6ba011b74a9f7a5c8322fe75478d9d"))
    }
}
