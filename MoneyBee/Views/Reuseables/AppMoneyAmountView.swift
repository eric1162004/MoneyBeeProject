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
        
        AppText(text:"$\(formattedAmount)", fontSize: FontSize.small)
            .frame(width: 80, height: 80)
            .padding(Dm.small)
            .background(.white)
            .clipShape(Circle())
        
    }
}

struct AppMoneyAmountView_Previews: PreviewProvider {
    static var previews: some View {
        AppMoneyAmountView(amount: 12)
    }
}
