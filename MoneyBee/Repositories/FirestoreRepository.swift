//
//  EarningRepository.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//
//  FirestoreResponsitory provides a generic interface to
//  communicate with Firestore

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import Resolver
import Combine

// itemType is a model
class FirestoreRepository<itemType: Codable & Identifiable & Reposable>: Repository, ObservableObject {
    
    // initialize db
    private var db = Firestore.firestore()
    
    private let collectionName: String
    private var collectionRef: CollectionReference {
        db.collection(collectionName)
    }
    
    // store and publish items
    @Published var items = [itemType]()

    // inject AuthService from Resolver
    @Injected private var authService: AuthService
    private var userId: String = "unknown"
    
    // to store cancellables
    private var cancellables = Set<AnyCancellable>()
    
    init() {

        // set the name of the collection: lowercased of the item type + s
        self.collectionName = String(describing: itemType.self).lowercased() + "s"
        
        // subscribe to the authentication service changes
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
        // query item that belongs to the current user id
        // order the item by createdTime in descending order
        collectionRef
            .whereField("userId", isEqualTo: self.userId)
            .order(by:"createdTime", descending: true)
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
    
    // get an item by id
    func getById(_ id: String, _ onCompleted: @escaping ((Result<itemType?, Error>) -> Void)) {
        let docRef = collectionRef.document(id)
        
        docRef.getDocument { (document, error) in
            
            let result = Result {
                try document?.data(as: itemType.self)
            }
            
            onCompleted(result)
        }
    }
    
}
