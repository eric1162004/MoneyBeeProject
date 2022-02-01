//
//  EarningViewModal.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import Combine
import Resolver

class EarningViewModel: ObservableObject {
    
    @Published var earningRepo: FirestoreRepository<Earning> = Resolver.resolve()
    
    @Published var earnings: [Earning] = [Earning]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        earningRepo.$items
            .assign(to: \.earnings, on: self)
            .store(in: &cancellables)
    }
    
    func remove(_ earning: Earning){
        earningRepo.remove(earning)
    }
    
    func add(_ earning: Earning){
        earningRepo.add(earning)
    }
    
}
