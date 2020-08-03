//
//  SignaUppViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/28/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase


class SignaUppViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var pCodeTextField: RTextfield!
    
    @IBOutlet weak var uEmTextField: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        // MARS: - magical google account profile image
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "signin"), object: nil, queue: .main) { (notif) in
            let userInfo = notif.userInfo
            let user = userInfo!["user"] as! GIDGoogleUser
            
            DispatchQueue.global().async {
                let imageURL = user.profile.imageURL(withDimension: 150)
                print(imageURL)
       
                let data = try! Data.init(contentsOf: imageURL!)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imgView.image = image
                }
            }
        }
        
        // MARS: - 
        
        // MARK: - seting key value pairs for database
        
        self.ref.child("cities").child("7").setValue(["namae": "santo domingo"])
        self.ref.child("cities").child("11").setValue(["namae": "san diego"])
        self.ref.child("cities").child("22").setValue(["namae": "LA"])
        
        
        ref.child("cities").child("7").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let namae = value?["namae"] as? String ?? ""
            
            print("Namaeeee = \(namae)") // breakpoint + 'po namae' here
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        // MARS: - A comletion-block way of setting key value pairs
        ref.child("cities").child("22").setValue(["namae": "NYC"]) {
            (error:Error?, ref:DatabaseReference) in
            
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
        
        var citiesRef: DatabaseReference!
        citiesRef = Database.database().reference().child("cities")
        
        let anotherRef = citiesRef.observe(DataEventType.value, with: { (snapshot) in
            let postDictionary = snapshot.value as? [String : AnyObject] ?? [:]
            
            print(postDictionary)
        })
        
        
//
    }
    
            // MARS: - Ordering data sample code
    //        let postsByMostPopular = ref.child("posts").queryOrdered(byChild: "metrics/views")
    
// MARK: - <#Section Heading#>
    
    // julianne@julianne.com
    // julianne
    
    @IBAction func signaUpAction(_ sender: UIButton) {
        
        guard let uEm = uEmTextField.text else { return }
        guard let pCode = pCodeTextField.text else { return }
        
        Auth.auth().createUser(withEmail: uEm, password: pCode) { (authRes, error) in
            print("Auth result is: ", authRes)
            print("My error is \(error.debugDescription)")
        }
    }
    
    @IBAction func tempLogInAction(_ sender: UIButton) {
        
        guard let uEm = uEmTextField.text else { return }
        guard let pCode = pCodeTextField.text else { return }
        
        Auth.auth().signIn(withEmail: uEm, password: pCode) { [weak self] (authRes, error) in
            guard let selfStrong = self else { return }
            
            print("Auth result is: ", authRes)
            print("My error is \(error.debugDescription)")
            print(selfStrong)
            
        }
        
    }
}

// Client ID for Google sign
// 943009449310-59gnroclfji4fuukkrha5t34pjnpqcj7.apps.googleusercontent.com

// copy ios url ID from 
