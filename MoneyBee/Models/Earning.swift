//
//  Earning.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// Earning encapsulates title, amount, date
struct Earning: Identifiable, Codable, Reposable {
    
    // document id is populated by firestoreswift at runtime
    @DocumentID var id: String?
    
    // earning details
    var title: String
    var amount: Float
    var date: Date
    
    // created time is set by firebase when the document initially create
    @ServerTimestamp var createdTime: Timestamp?
    
    // userId is populated by FirestoreRepository when the document initially create
    var userId: String?
}
