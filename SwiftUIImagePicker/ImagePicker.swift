//
//  ImagePicker.swift
//  SwiftUIImagePicker2
//
//  Created by Carmen Morado on 11/19/21.
//  Copyright © 2021 AppCoda. All rights reserved.
//

import UIKit
import SwiftUI
import Photos

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var imageName: String
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self, $imageName)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var imageName: String
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker,_ imageName: Binding<String>) {
            
            self.parent = parent
            _imageName = imageName
            super.init()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            let status = PHPhotoLibrary.authorizationStatus()

            if status == .notDetermined  {
                PHPhotoLibrary.requestAuthorization({status in

                })
            }
            
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                    let assetResources = PHAssetResource.assetResources(for: asset)
                    imageName = assetResources.first!.originalFilename
                    print(imageName)
            }
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
