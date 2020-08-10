//
//  ImagerySharingViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/8/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import FirebaseStorage
import FirebaseAuth
import UIKit
import FirebaseDatabase

class ImagerySharingViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var shareableImagery: UIImageView!
    @IBOutlet weak var shareUpButton: UIButton!
    @IBOutlet weak var shareUpLabel: UILabel!
    
    @IBOutlet weak var captionTextView: UITextView!
    var selectedImgForStormy: UIImage?
    
    let breezeShareableImageryStorageReference = Storage.storage().reference(forURL: "gs://fir-bniyon.appspot.com").child("PostsShared")
    
     let currentUserUID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
        self.shareableImagery.image = UIImage(systemName: "camera.circle")
        
        captionTextView.delegate = self

        setupShareableImageryForPicking()
    }
    
    func setupShareableImageryForPicking() {
        
        shareableImagery.contentMode = .scaleAspectFill
        
        let tappingImageGesture = UITapGestureRecognizer(target: self, action: #selector(self.shareableImgSelectorMethod))
        
        shareableImagery.isUserInteractionEnabled = true
        shareableImagery.addGestureRecognizer(tappingImageGesture)
        
        print("tapppppppee")
    }
    
    @objc func shareableImgSelectorMethod() {
        let pickaControla = UIImagePickerController.init()
        pickaControla.allowsEditing = true
        pickaControla.sourceType = .photoLibrary
        pickaControla.delegate = self
        present(pickaControla, animated: true, completion: nil)
    }
    
    @IBAction func shareUpAction(_ sender: UIButton) {
        upIntoTheStormyCloud()
        // put an acitivityIndicator later
    }
}
