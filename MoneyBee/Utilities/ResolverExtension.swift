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
//      register { FirestoreTaskRepository() as TaskRepository }.scope(.application)
      
      // provide a singleton of AuthService
      register { AuthService() }.scope(.application)
  }
}
