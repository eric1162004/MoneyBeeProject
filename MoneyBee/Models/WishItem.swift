//
//  WishItem.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct WishItem: Identifiable, Codable, Reposable {
    
    @DocumentID var id: String?
    var title: String
    var cost: Float
    var purchased: Bool = false
    var imageUUID: String = ""
    var imageUrl: String = ""
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}
