//
//  ResolverExtension.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
  public static func registerAllServices() {
      
      // provide a singleton of Repository
      register { FirestoreRepository<Earning>() }.scope(.application)
      register { FirestoreRepository<Spending>() }.scope(.application)
      
      // View Models
      register { EarningViewModel() }.scope(.application)
      register { SpendingViewModel() }.scope(.application)
      
      // provide a singleton of AuthService
      register { AuthService() }.scope(.application)
      
      // provide a singleton of ImageStorageService
      register { ImageStorageService() }.scope(.application)
  }
    
}
