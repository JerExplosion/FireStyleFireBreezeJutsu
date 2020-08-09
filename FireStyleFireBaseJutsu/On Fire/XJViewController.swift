//
//  XJViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/29/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

// xj = 细节

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
import Firebase

class XJViewController: UIViewController {
    
    let signedInUserUID = Auth.auth().currentUser?.uid
    
    let fireBreezeProfileImageryStorageReference = Storage.storage().reference(forURL: "gs://fir-bniyon.appspot.com").child("ProfileImagery")
    
    @IBOutlet weak var profileImagery: UIImageView!
    var selectedImgForStorm: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupProfileImageryForPicking()
    }
    
    func setupProfileImageryForPicking() {
        
        profileImagery.layer.cornerRadius = profileImagery.frame.height / 2
        
        let tappingImageGesture = UITapGestureRecognizer(target: self, action: #selector(XJViewController.profileImgSelectorMethod))
        
        profileImagery.addGestureRecognizer(tappingImageGesture)
        profileImagery.isUserInteractionEnabled = true
    }
    
    @objc func profileImgSelectorMethod() {

        let pickaControl = UIImagePickerController.init()
        pickaControl.sourceType = .photoLibrary
        pickaControl.allowsEditing = true
        pickaControl.delegate = self
        present(pickaControl, animated: true, completion: nil)
    }
    
    @IBAction func addingPicTouched(_ sender: UIButton) {
        profileImgSelectorMethod()
    }
}


// let firebreezeStorageReference = Storage.storage().reference(forURL: "gs://fir-bniyon.appspot.com")

// fill out xj of profile
// img-picker-uploader -> StorageFire

// protocol NotificPacific { }
