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

class XJViewController: UIViewController, UITextFieldDelegate {
    
    let signedInUserUID = Auth.auth().currentUser?.uid
      
    @IBOutlet weak var pikachuImagery: UIImageView!
    @IBOutlet weak var profileImagery: UIImageView!
    var selectedImgForStorm: UIImage?
    @IBOutlet weak var kaedeUsernameTextfield: KaedeTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupProfileImageryForPicking()
        pickachuGIFLoader()
        kaedeUsernameTextfield.delegate = self
    }
    
    func pickachuGIFLoader() {
        pikachuImagery.layer.cornerRadius = pikachuImagery.frame.height / 2
        let pikachuGIF = UIImage.gifImageWithName("SurprisedPikachu")
        self.pikachuImagery.image = pikachuGIF
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
    
    @IBAction func userNameEntryReturn(_ sender: UIButton) {
        alertFormula(title: "Username Set!", message: nil, action: "Start Exploring")
        kaedeUsernameTextfield.resignFirstResponder()
    }
    
    @IBAction func addingPicTouched(_ sender: UIButton) {
        profileImgSelectorMethod()
    }
}


// let firebreezeStorageReference = Storage.storage().reference(forURL: "gs://fir-bniyon.appspot.com")

// fill out xj of profile
// img-picker-uploader -> StorageFire

// protocol NotificPacific { }

//var profileIDString = NSUUID().uuidString
//lazy var fireBreezeProfileImageryStorageReference = Storage.storage().reference(forURL: "gs://fir-bniyon.appspot.com").child("ProfileImagery").child(profileIDString)
