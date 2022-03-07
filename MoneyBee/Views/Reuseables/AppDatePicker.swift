//
//  AppDatePicker.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import SwiftUI

struct AppDatePicker: View {
    
    @Binding var selectedDate: Date
    
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startDate = Calendar.current.date(byAdding: .year, value: -5, to: Date())!
        let endDate = Calendar.current.date(byAdding: .day, value: 0, to: Date())!
        return startDate...endDate
    }()

    var body: some View {
        DatePicker(
            "Date",
             selection: $selectedDate,
             in: dateRange,
             displayedComponents: [.date]
        )
            .foregroundColor(Color.appLightGray)
            .font(Font.custom(Fonts.bubbleGum, size: FontSize.small))
            .accentColor(Color.primaryColor)
            .padding(Dm.small)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.separator), lineWidth: 4))
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
    }
}

struct AppDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        AppDatePicker(selectedDate: .constant(Date()))
    }
}
