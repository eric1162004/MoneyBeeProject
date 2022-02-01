//
//  Array.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import Foundation

// remove duplicated element in an array, in which the elements are hashable
extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
