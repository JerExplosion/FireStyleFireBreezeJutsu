//
//  RefreshingRefreshExtension.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/6/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth
import Firebase

extension XJViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let signedInUserUID = signedInUserUID else { return }
        
        profileImagery.contentMode = .scaleAspectFill
        
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImgForStorm = img
            profileImagery.image = img
        }
        
        if let profileImgForUpload = selectedImgForStorm, let imgUploadData = profileImgForUpload.jpegData(compressionQuality: 0.1) {
            
            let profileIDString = NSUUID().uuidString
            let fireBreezeProfileImageryStorageReference = Storage.storage().reference(forURL: "gs://fir-bniyon.appspot.com").child("ProfileImagery").child(profileIDString)
            
            fireBreezeProfileImageryStorageReference.putData(imgUploadData, metadata: nil) { (storageMetadata, erro) in
                
                let imgSize = storageMetadata?.size
                let imgContentType = storageMetadata?.contentType
                let imgTimeCreated = storageMetadata?.timeCreated
                print("img size & content type& time created are", imgSize, imgContentType, imgTimeCreated)
                  
                if erro != nil {
                    print("putData for uploadImg failed", erro?.localizedDescription)
                    return
                } else {
                    
                    fireBreezeProfileImageryStorageReference.downloadURL { (url, erro) in
                        guard let downloadURLString = url?.absoluteString else {
                            print("downloadURL getter failed")
                            return }
                        print("downloadURLString is", downloadURLString)
                        
                        // MARS: - 参 freshedKao
                        
                        let experimentalRef = Database.database().reference()
                        let ufoRef = experimentalRef.child("UFO")
                        let newUFORef = ufoRef.child(signedInUserUID)
                        newUFORef.updateChildValues(["ufoProfileURL": downloadURLString])
                        
                        // MARS: - freshedKao 参
                    }
                }
            }
        }
        
        print("did finish picking callled  eddeddedde")
        dismiss(animated: true, completion: nil)
    }
}



         
