//
//  ImageStorageService.swift
//  MoneyBee
//
//  Created by Eric Cheung on 2022-01-31.
//

import Foundation
import FirebaseStorage

public class ImageStorageService: ObservableObject {

    // initialize a firebase storage instance
    let storage = Storage.storage()
    
    // Storage reference prefixed with images
    var storageRef : StorageReference {
        storage.reference().child("images")
    }

    // take a UIIamge as argument
    // return success or error via a completionHandler
    // Result.success is (uuid, downloadUrl)
    func upload(image: UIImage, completionHandler: @escaping ((Result<(String, String), Error>) -> Void)){
        
        // Create a UUID for the upload image
        let uuid = UUID().uuidString
        
        // Create a storage reference
        let imageRef = storageRef.child(uuid + ".jpg")

        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 1)

        // Change the content type to jpg. If you don't, it'll be saved as application/octet-stream type
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        // Upload the image
        if let data = data {
            imageRef.putData(data, metadata: metadata) { (metadata, error) in
                
                // handle error for cannot upload the image
                if let error = error {
                    print("Error while uploading file: ", error)
                    completionHandler(.failure(error))
                    return
                }

                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
                
                imageRef.downloadURL { url, error in
                    
                    // handle error for cannot retrieve downloadURL
                    if let error = error {
                        print("Error while uploading file: ", error)
                        completionHandler(.failure(error))
                        return
                    }
                    
                    // handle success
                    // return a tuple of (uuid, downloadUrl)
                    completionHandler(.success((uuid, url!.absoluteString)))
                }
            
            }
        }
    }
    
    // delete an image by providing the uuid of the image
    func delete(uuid: String) {
        // Create a storage reference
        let imageRef = storageRef.child("\(uuid).jpg")
        
        imageRef.delete { error in
            if let error = error {
                print("Error deleting item", error)
            }
        }
    }

    // list all image objects in the storage
    // not used in this project
    func listAllFiles() {
        // Create a reference
        let storageRef = storage.reference().child("images")
        
        // List all items in the images folder
        storageRef.listAll { (result, error) in
            if let error = error {
                print("Error while listing all files: ", error)
            }
            
            for item in result.items {
                item.downloadURL { url, _ in
                    if let url = url {
                        
                        // do whatever you want with the url
                        print(url)
                    }
                }
            }
        }
    }
}

