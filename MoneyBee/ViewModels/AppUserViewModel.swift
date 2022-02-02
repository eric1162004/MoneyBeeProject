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
    
    @Published var appUser: AppUser = AppUser(name: "", email: "")
    
    @Published var selectedImage: UIImage?
    
    private let imageStorageService: ImageStorageService = Resolver.resolve()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        
        appUserRepo.$items
            .map{ users in
                users.first ?? AppUser(name: "", email: "")
            }
            .assign(to: \.appUser, on: self)
            .store(in: &cancellables)
    
    }
    
    func update() {
        
        if let selectedImage = selectedImage {
            // upload image provided
            imageStorageService.upload(image: selectedImage) { [weak self] result in
                if case .success( let (uuid, downloadUrl)) = result {
                    let appUserToUpdate = self?.appUser
                    
                    if var appUserToUpdate = appUserToUpdate {
                        let oldUUID = appUserToUpdate.imageUUID
                        
                        appUserToUpdate.imageUUID = uuid
                        appUserToUpdate.imageUrl = downloadUrl
                        
                        // update the user profile
                        self?.appUserRepo.update(appUserToUpdate)
    
                        // delete the old image
                        self?.imageStorageService.delete(uuid: oldUUID)
                        
                    }
                }
            }
        }
        else {
            // upload wish item without image provided
            appUserRepo.update(appUser)
        }
    }
    
    func add(_ appUser: AppUser){
        appUserRepo.add(appUser)
    }
    
}
