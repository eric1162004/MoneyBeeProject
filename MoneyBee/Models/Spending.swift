//
//  Spending.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Spending: Identifiable, Codable, Reposable {
    
    // populated by firebasefirestore
    @DocumentID var id: String?
    
    var title: String
    var amount: Float
    var date: Date
    var type: String // types: Food, School, Play, Others
    
    // populated by firebasefirestore
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}
