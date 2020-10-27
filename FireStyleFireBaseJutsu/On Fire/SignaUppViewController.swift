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
// import GoogleSignIn
import FirebaseDatabase

class SignaUppViewController: VelocityAnimaViewController {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var pCodeTextField: RTextfield!
    
    @IBOutlet weak var uEmTextField: UITextField!
    
    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        let pikachuGIF = UIImage.gifImageWithName("SurprisedPikachu")
        self.imgView.image = pikachuGIF
        
    //    GIDSignIn.sharedInstance()?.presentingViewController = self
        
 //       googoroSignIn()
    }
    
//    func googoroSignIn() {
//
//        // The next line automatically signs in the user.
//        // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//
//         NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "signin"), object: nil, queue: .main) { (notif) in
//             let userInfo = notif.userInfo
//    //         let user = userInfo!["user"] as! GIDGoogleUser
//
//             DispatchQueue.global().async {
//      //           let imageURL = user.profile.imageURL(withDimension: 150)
//
//                 let data = try! Data.init(contentsOf: imageURL!)
//                 let image = UIImage(data: data)
//                 DispatchQueue.main.async {
//                // magical google account profile image link-up
//                     self.imgView.image = image
//                     self.sendToTabTab()
//                    print("googoroSignin( ) successfully sending toTabTab")
//                 }
//             }
//
//         }
//    }
        
    
// MARK: - <#Section Heading#>
    
    // julianne@julianne.com
    // julianne
    
    @IBAction func signaUpAction(_ sender: UIButton) {
        
        guard let uEm = uEmTextField.text else { return }
        guard let pCode = pCodeTextField.text else { return }
        
        Auth.auth().createUser(withEmail: uEm, password: pCode) { (authRes, error) in

            print("My error is \(error.debugDescription)")
            
            if let ergo = error {
                print(ergo.localizedDescription)
                let errorMessage = ergo.localizedDescription
                
                var validPasswordOrNaw = true
                
                if uEm.isEmpty {
                    self.formulaAlert(title: nil, message: "Enter an email address buddy", action: "Try again")
                }
                else if (uEm.isValidEmailOrNaw == false) {
                    self.formulaAlert(title: nil, message: "Enter a valid email address buddy", action: "Try again")
                }
                else if pCode.count < 6 {
                    self.mustBeLongerThanSixCharsAlert()
                }
            }

            guard let authedUserUID = Auth.auth().currentUser?.uid else { return }
            guard let pUserUID = authRes?.user.uid else { return }
            
            print(authedUserUID, "is authedUser different than pUser?", pUserUID)

            let userInfoDict = ["uID": pUserUID, "email":  uEm, " userName": "mystery", "friendz": ["so lonely in here"], "friendzCount": 1] as [String : Any]
            
            self.ref.child("Users").child(pUserUID).setValue(userInfoDict)

            print("successfully sending user  \(pUserUID)  to the cloud")
            print("separator ------------------")
            
            self.sendToTabTab()
        }
    }
    
    func sendToTabTab() {
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
             let tabTabViewController = sBoard.instantiateViewController(withIdentifier: "tabTabSBoardID")
        navigationController?.crossDissolve(tabTabViewController)
    }

    @IBAction func shiftToSignIn(_ sender: UIButton) {
        let primaryStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let destination = primaryStoryboard.instantiateViewController(withIdentifier: "inSBoardID") as? SigmaInnViewController else {
            print("destination unclear bud")
            return
        }
        navigationController?.crossDissolve(destination)
    }
}

extension SignaUppViewController {
    
    func mustBeLongerThanSixCharsAlert() {
        let alertCon = UIAlertController(title: nil, message: "Passwords must be 6 characters or longer buddy", preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Got it", style: .cancel, handler: nil)
        alertCon.addAction(dismissAction)
        present(alertCon, animated: true, completion: nil)
    }
           
}

extension String {
    var isThisAValidEmailOrNaw: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}








// Client ID for Google sign
// 943009449310-59gnroclfji4fuukkrha5t34pjnpqcj7.apps.googleusercontent.com

// copy ios url ID from 


        // MARK: - seting key value pairs for database
//
//        self.ref.child("cities").child("7").setValue(["namae": "santo domingo"])
//        self.ref.child("cities").child("11").setValue(["namae": "san diego"])
//        self.ref.child("cities").child("22").setValue(["namae": "LA"])
//
//
//        ref.child("cities").child("7").observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user value
//            let value = snapshot.value as? NSDictionary
//            let namae = value?["namae"] as? String ?? ""
//
//            print("Namaeeee = \(namae)") // breakpoint + 'po namae' here
//
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//
//        // MARS: - A comletion-block way of setting key value pairs
//        ref.child("cities").child("22").setValue(["namae": "NYC"]) {
//            (error:Error?, ref:DatabaseReference) in
//
//            if let error = error {
//                print("Data could not be saved: \(error).")
//            } else {
//                print("Data saved successfully!")
//            }
//        }
//
//        var citiesRef: DatabaseReference!
//        citiesRef = Database.database().reference().child("cities")
//
//        let anotherRef = citiesRef.observe(DataEventType.value, with: { (snapshot) in
//            let postDictionary = snapshot.value as? [String : AnyObject] ?? [:]
//
//            print(postDictionary)
//        })
//
//
////
//    }
//
//            // MARS: - Ordering data sample code
//    //        let postsByMostPopular = ref.child("posts").queryOrdered(byChild: "metrics/views")

//    @IBAction func tempLogInAction(_ sender: UIButton) {
//
//        guard let uEm = uEmTextField.text else { return }
//        guard let pCode = pCodeTextField.text else { return }
//
//        Auth.auth().signIn(withEmail: uEm, password: pCode) { [weak self] (authRes, error) in
//            guard let selfStrong = self else { return }
//
//            print("Auth result is: ", authRes)
//            print("My error is \(error.debugDescription)")
//            print(selfStrong)
//
//        }
//
//    }
