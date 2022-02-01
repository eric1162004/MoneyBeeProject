//
//  EarningRepository.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver
import Combine

class FirestoreRepository<itemType: Codable & Identifiable & Reposable>: Repository, ObservableObject {
    
    // initialize db
    private var db = Firestore.firestore()
    
    private let collectionName: String
    private var collectionRef: CollectionReference {
        db.collection(collectionName)
    }
    
    @Published var items = [itemType]()

    // inject authService from Resolver
    @Injected private var authService: AuthService
    private var userId: String = "unknown"
    
    // to store cancellables
    private var cancellables = Set<AnyCancellable>()
    
    init() {

        self.collectionName = String(describing: itemType.self).lowercased() + "s"
        
        // kicks in whenever the user property on the authentication service changes
        // extracts the user's ID
        authService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)
        
        // (re)load data if user changes
        authService.$user
        // It is essential to make sure any update to the UI is executed on the main thread.
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.loadData()
            }
            .store(in: &cancellables)
    }
    
    private func loadData(){
        collectionRef
            .whereField("userId", isEqualTo: self.userId)
            .order(by:"createdTime")
            .addSnapshotListener { querySnapshot, error in
                
            if let querySnapshot = querySnapshot {
                self.items = querySnapshot.documents.compactMap{ document -> itemType? in
                    try? document.data(as: itemType.self)
                }
            }
        }
    }
    
    func add(_ item: itemType) {
        do{
            var userItem = item
            userItem.userId = self.userId
            let _ = try collectionRef.addDocument(from: userItem)
        }
        catch {
            print("There was an error while trying to save a task \(error.localizedDescription)")
        }
    }
    
    func remove(_ item: itemType) {
        if let itemID = item.id {
            collectionRef.document(itemID).delete { error in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func update(_ item: itemType) {
        if let itemID = item.id {
            do {
                try collectionRef.document(itemID).setData(from: item)
            }
            catch{
                print("There was an error while trying to update a task \(error.localizedDescription)")
            }
        }
    }
    
}
