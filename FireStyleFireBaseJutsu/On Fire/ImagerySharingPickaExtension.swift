//
//  ImagerySharingPickaExtension.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/8/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import FirebaseStorage
import FirebaseAuth
import UIKit
import FirebaseDatabase

extension ImagerySharingViewController: UINavigationControllerDelegate & UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let img = info[.originalImage] as? UIImage {
            shareableImagery.image = img
            selectedImgForStormy = img
        }
        
        print("did finish picking callled")
        dismiss(animated: true, completion: nil)
    }
    
}

extension ImagerySharingViewController {
    
    func upIntoTheStormyCloud() {
        
        guard let currentUserUID = currentUserUID else { return }
        
        if let imgForShare = selectedImgForStormy, let imgForShareUploadData = imgForShare.jpegData(compressionQuality: 0.1) {
            
            let picIDString = NSUUID().uuidString
            let exactBreezeImageryStorageReference = self.breezeShareableImageryStorageReference.child(picIDString)
            // MARS: - ^  ^
            
            exactBreezeImageryStorageReference.putData(imgForShareUploadData, metadata: nil) { (storageMeta, erro) in
                let imgTimeOfCreation = storageMeta?.timeCreated
                print("time of creation for posted is ", imgTimeOfCreation)
                
                if erro != nil {
                    print("putData func for image upload failed", erro?.localizedDescription)
                    return
                }  else {
                    
                    exactBreezeImageryStorageReference.downloadURL { (url, erro) in
                        guard let picChaURLString = url?.absoluteString else {
                            print("picChaURL failed")
                            return }
                        print("picChaURLString is  _", picChaURLString)
                        
                        self.sendDataUpToBaseFire(picURL: picChaURLString)
                    }
                }
            }
        }
    }
}

extension ImagerySharingViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if shareUpLabel.text == "Yay" {
            shareUpLabel.text = "What do you have in mind today?"
        }
    }
    
    func sendDataUpToBaseFire(picURL: String) {
        
        let dReference = Database.database().reference()
        let sharedPostsCollectionReference = dReference.child("PostsShared")
        
        guard let newSharedPostID = sharedPostsCollectionReference.childByAutoId().key else { return }
        print("Child Auto Id is ", newSharedPostID)
        
        let newSharedPostReference = sharedPostsCollectionReference.child(newSharedPostID)
        
        guard let posterUID = currentUserUID else { return }
                  
        newSharedPostReference.setValue(["picURL" : picURL, "poster": posterUID]) { (erro, dBaseRef) in
            if erro != nil {
                print("SharedPost value-setting failed", erro?.localizedDescription)
                return
            }
            print("SharedPost value-setting succeeded")
            
            self.shareUpLabel.text = "Success !"
            self.shareableImagery.image = UIImage(systemName: "checkmark.circle.fill")
            
            // self.tabBarController?.selectedIndex = 0 // customize this later
        }
    }
}
