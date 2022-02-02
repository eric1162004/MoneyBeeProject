//
//  RepositoryProtocol.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation

// All repository must conform to this protocol: add, remove and update item
protocol Repository {
    associatedtype T
    
    func add(_ item: T)
    func remove(_ item: T)
    func update(_ item: T)
}
