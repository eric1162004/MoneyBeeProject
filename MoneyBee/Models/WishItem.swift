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
    
    // indicate whether the user has purchased the wishItem or not
    // aid in total saving amount calculation
    var purchased: Bool = false
    
    // image UUID is needed to delete the image
    var imageUUID: String = ""
    // image URL to download the image
    var imageUrl: String = ""
    
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}
