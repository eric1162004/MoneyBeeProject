//
//  AppUser.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-02-01.
//

import Foundation
import Combine
import Resolver

class AppUserViewModel: ObservableObject {
    
    @Published var appUserRepo: FirestoreRepository<AppUser> = Resolver.resolve()
    
    @Published var appUsers: [AppUser] = [AppUser]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        appUserRepo.$items
            .assign(to: \.appUsers, on: self)
            .store(in: &cancellables)
    
    }
    
    func remove(_ appUser: AppUser){
        appUserRepo.remove(appUser)
    }
    
    func add(_ appUser: AppUser){
        appUserRepo.add(appUser)
    }
    
}
