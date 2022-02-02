//
//  PhotoPicker.swift
//  TestingFirebase
//
//  Created by Eric Cheung on 2022-01-31.
//
//  integrate with UIKit and the UIImagePickerController
//  using UIViewControllerRepresentable in SwiftU

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?

    // create the UIViewController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        
        // IMPORTANT - set the UIIMagePickerController's delegate to the coordinator of this photopicker
        picker.delegate = context.coordinator
        
        // configurate image picker
        // allow user cropping image
        picker.allowsEditing = true
        
        return picker
    }
    
    // use this if we need to make changes to the UIViewController
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    // this get called automatically when the PhotoPicker is constructed
    func makeCoordinator() -> Coordinator {
        // pass self reference to the Coordinator
        return Coordinator(photoPicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        
        // the Coordinator holds a reference of the PhotoPicker
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker){
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // using .editedImage because we use allowsEditing
            if let image = info[.editedImage] as? UIImage {
                
                // apply compression here 0.1 - 1 (no compression)
                guard let data = image.jpegData(compressionQuality: 0.1),
                        let compressedImage =  UIImage(data: data) else { return }
                
                photoPicker.image = compressedImage

            } else {
                // return an error or do nothing
            }
            
            // You have to dimiss the image picker after finishing the picking
            picker.dismiss(animated: true)
        }
    }
        
}

