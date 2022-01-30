//
//  Date.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import Foundation

extension Date {
    
    static func dateToString(_ date: Date, _ format: String = "dd/MMM/yyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func stringToDate(_ dateString: String, _ format: String = "dd/MMM/yyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
}

