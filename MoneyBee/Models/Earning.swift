//
//  Earning.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol Reposable {
    var id: String? {get set}
    var createdTime: Timestamp? {get set}
    var userId: String? {get set}
}


struct Earning: Identifiable, Codable, Reposable {
    
    @DocumentID var id: String?
    var title: String
    var amount: Float
    var date: Date
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}
