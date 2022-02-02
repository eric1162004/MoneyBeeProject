//
//  Reposable.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import FirebaseFirestore

// provides a interface for all itemtype used by FirestoreRepository,
// such as Earning, Spending, WishItem and AppUser
protocol Reposable {
    var id: String? {get set}
    var createdTime: Timestamp? {get set}
    var userId: String? {get set}
}
