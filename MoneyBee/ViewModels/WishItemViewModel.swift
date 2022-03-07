//
//  WishItemViewModel.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import Foundation
import SwiftUI
import Combine
import Resolver

class WishItemViewModel: ObservableObject {
        
    @Published var wishItemRepo: FirestoreRepository<WishItem> = Resolver.resolve()
    
    @Published var wishItems: [WishItem] = [WishItem]()
    
    @Published var selectedImage: UIImage?
    
    @Published var showingAlert: Bool = false
    
    @Published var notEnoughMoneyError: String = ""
    
    // contain user's total amount of earning, spending and wishlist
    private var homeViewModel: HomeViewModel = Resolver.resolve()
    
    private let imageStorageService: ImageStorageService = Resolver.resolve()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        wishItemRepo.$items
            .assign(to: \.wishItems, on: self)
            .store(in: &cancellables)
    
    }
    
    func remove(_ wishItem: WishItem){
        
        let uuid = wishItem.imageUUID
        
        if !uuid.isEmpty {
            imageStorageService.delete(uuid: uuid)
        }
        
        wishItemRepo.remove(wishItem)
        
    }
    
    func add(_ wishItem: WishItem){
        
        if let selectedImage = selectedImage {
            // upload wish item with image provided
            imageStorageService.upload(image: selectedImage) { [weak self] result in
                if case .success(let (uuid, downloadUrl)) = result {
                    var wishItemWithImage = wishItem
                    wishItemWithImage.imageUrl = downloadUrl
                    wishItemWithImage.imageUUID = uuid
                    self?.wishItemRepo.add(wishItemWithImage)
                }
            }
        } else {
            // upload wish item without image provided
            wishItemRepo.add(wishItem)
        }
    }

    func buyItem(_ wishItem: WishItem){
        
        // check if the user has enough saving to buy the item
        guard homeViewModel.totalSavingAmount >= wishItem.cost else {
            
            // display "Not enough saving to buy" messahe to user
            showingAlert = true
            notEnoughMoneyError = "You don't have enough saving to buy this item."
            
            return
        }
        
        var wishItemUpdated = wishItem
        wishItemUpdated.purchased.toggle()
        wishItemRepo.update(wishItemUpdated)
        
    }

}
