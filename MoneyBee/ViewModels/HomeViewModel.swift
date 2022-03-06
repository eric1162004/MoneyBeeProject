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
    @Published var totalSavingAmount: Float = 0.0
    
    @Published var honeyJarImage = "emptyHoneyJar"
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        // Calculate total 'bought' wish item cost
        wishItemRepo.$items
            .map{ wishItems in
                // only map the wish item that has been brought
                wishItems.map { wishItem in
                    if wishItem.purchased {
                        return Double(wishItem.cost)
                    }
                    return 0.0
                }
            }
            .map { wishItemCosts in
                // summing each cost
                wishItemCosts.reduce(0.0, +)
            }
            .sink { [weak self] value in
                // update total
                 self!.totalBoughtWishItem = Float(value)
                 self!.updateSavingAmount()
             }
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
            .sink { [weak self] value in
                 self!.totalEarning = Float(value)
                 self!.updateSavingAmount()
             }
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
            .sink { [weak self] value in
                 self!.totalSpending = Float(value)
                 self!.updateSavingAmount()
             }
            .store(in: &cancellables)

    }
    
    private func updateSavingAmount() {
        totalSavingAmount = totalEarning - totalSpending - totalBoughtWishItem
        
        // update honey jar image
        updateHoneyJarimage()
    }
    
    private func updateHoneyJarimage(){
        if totalSavingAmount >= 500 {
            honeyJarImage = "fullHoneyJar"
        } else if totalSavingAmount > 0 {
            honeyJarImage = "halfFullHoneyJar"
        } else {
            honeyJarImage = "emptyHoneyJar"
        }
    }
    
}
