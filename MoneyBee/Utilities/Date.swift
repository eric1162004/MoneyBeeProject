//
//  Date.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-29.
//

import Foundation

extension Date {
    
    func dateToString(_ format: String = "MMM dd yyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    static func stringToDate(_ dateString: String, _ format: String = "MMM dd yyy") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: dateString)
    }
    
}

