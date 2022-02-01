//
//  Float.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import Foundation

extension Float {
    
    func toStringWithDecimal(n: Int) ->  String {
        String(format: "%.\(n)f", self)
    }
    
}
