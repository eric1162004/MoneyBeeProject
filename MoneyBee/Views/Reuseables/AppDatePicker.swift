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
        let startComponents = DateComponents(year: 2021, month: 1, day: 1)
        let endComponents = DateComponents(year: 2021, month: 12, day: 31)
        return calendar.date(from:startComponents)!
            ...
            calendar.date(from:endComponents)!
    }()
    
    
    var body: some View {
        DatePicker(
            "Date",
             selection: $selectedDate,
             in: dateRange,
             displayedComponents: [.date]
        )
            .font(Font.custom(Fonts.bubbleGum, size: FontSize.small))
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
