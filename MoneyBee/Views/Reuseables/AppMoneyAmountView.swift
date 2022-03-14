//
//  AppMoneyAmountView.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppMoneyAmountView: View {
    
    var amount: Float = 0
    
    var body: some View {
        let formattedAmount = String(format: "%.2f", amount)
        
        Image("honeyJar")
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 90)
            .overlay {
                AppText(text:"$\(formattedAmount)", fontSize: FontSize.tiny, fontColor: .white)
                    .padding(.top)
                    .frame(width: 90, height: 75)
                    .padding(Dm.small)
            }
        
        
    }
}

struct AppMoneyAmountView_Previews: PreviewProvider {
    static var previews: some View {
        AppMoneyAmountView(amount: 12)
    }
}
