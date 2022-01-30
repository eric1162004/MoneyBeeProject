//
//  AppWishItemCard.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppWishItemCard: View {
    
    @State var title:String
    @State var imageName: String
    @State var amount: Float
    @State var backgroundColor: Color = Color.primaryColor
    @State var buyButtonHandler: (() -> ())?
    @State var swipeDeleteHandler: (() -> ())?
    
    var body: some View {
        
        HStack{
            VStack{
                AppRoundedImageView(imageName: imageName)
                
                AppText(text: title, fontSize: FontSize.small, fontColor: .white)
            }
            .frame(maxWidth: .infinity)
            
            VStack{
                AppMoneyAmountView(amount: amount)
                
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
        AppWishItemCard(title: "Soft Panda", imageName: "honeyBeeLogo2", amount: 20)
    }
}
