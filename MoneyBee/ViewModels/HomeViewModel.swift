//
//  HomeViewModel.swift
//  MoneyBee
//
//  Created by eric on 2022-02-21.
//

import Foundation
import Combine
import Resolver

class HomeViewModel: ObservableObject {
        
    @Published var earningRepo: FirestoreRepository<Earning> = Resolver.resolve()
    
    @Published var spendingRepo: FirestoreRepository<Spending> = Resolver.resolve()
    
    @Published var wishItemRepo: FirestoreRepository<WishItem> = Resolver.resolve()
    
    @Published var totalEarning: Float = 0.0
    @Published var totalSpending: Float = 0.0
    @Published var totalBoughtWishItem: Float = 0.0
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        // Calculate total 'bought' wish item cost
        wishItemRepo.$items
            .map{ wishItems in
                // only map the wish item that has been brought
                wishItems.map { wishItem in
                    if wishItem.purchased {
                        return wishItem.cost
                    }
                    return 0.0
                }
            }
            .map { wishItemCosts in
                wishItemCosts.reduce(0.0, +)
            }
            .assign(to: \.totalBoughtWishItem, on: self)
            .store(in: &cancellables)
        
        // Calculate total earning
        earningRepo.$items
            .map{ earnings in
                earnings.map { earning in
                    earning.amount
                }
            }
            .map { earnings in
                earnings.reduce(0.0, +)
            }
            .assign(to: \.totalEarning, on: self)
            .store(in: &cancellables)
            
        // calculate total spending
        spendingRepo.$items
            .map{ spendings in
                spendings.map { spending in
                    spending.amount
                }
            }
            .map { spendings in
                spendings.reduce(0.0, +)
            }
            .assign(to: \.totalSpending, on: self)
            .store(in: &cancellables)

    }
    
}
