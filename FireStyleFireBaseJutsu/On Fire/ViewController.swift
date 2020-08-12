//
//  ViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/27/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
// import Firebase
import GoogleSignIn
import FirebaseDatabase

class ViewController: VelocityAnimaViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // MARS: - Above database code
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        // MARK: - seting key value pairs for database
        
        self.ref.child("cities").child("7").setValue(["namae": "santo domingo"])
        self.ref.child("cities").child("11").setValue(["namae": "san diego"])
        self.ref.child("cities").child("22").setValue(["namae": "hawaii"])
        
        
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
        
//         guard let userID = authResult?.user.uid else { return }
//              self.ref.child("user").child(userID).setValue(["Phone Number": "", "Zip Code": "", "Hobby": "", "Gender": ""])
//
//
//        if let userId = userID {
//              ref.child("user/\(userId)/Phone Number").setValue(phoneNumberTF.text)
//              ref.child("user/\(userId)/Hobby").setValue(hobbyTF.text)
//              ref.child("user/\(userId)/Zip Code").setValue(zipCodeTF.text)
//              ref.child("user/\(userId)/Gender").setValue(genderTF.text)
//            }
    
    }
}

// MARS: - StackOverFlow way

//        var citiesRef: DatabaseReference!
//        citiesRef = Database.database().reference().child("cities")
//
//        let anotherRef = citiesRef.observe(DataEventType.value, with: { (snapshot) in
//            let postDictionary = snapshot.value as? [String : AnyObject] ?? [:]
//
//            print(postDictionary)
//        })



// paste crashlytics code into buildphase -> run scripts

//       fatalError() // crash it first, stop building. Then launch it from simulator directly - it would sync to the cloud
// then refresh the crashlytics page

// do log events

//        Analytics.setScreenName("HomeScreen", screenClass: "viewController")
//        Analytics.logEvent("name", parameters: ["String" : "Any"]) // just random placeholder names currently




