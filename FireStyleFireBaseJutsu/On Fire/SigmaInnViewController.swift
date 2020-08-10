//
//  SigmaInnViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/28/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import FirebaseAuth
import Firebase
import GoogleSignIn
import UIKit

class SigmaInnViewController: UIViewController {
    
    @IBOutlet weak var pCodeTextField: UITextField!
    @IBOutlet weak var uEmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

         gidConfigurationHelper()
    }
    
    func gidConfigurationHelper() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
 //       GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }   

    @IBAction func sigmaInnAction(_ sender: UIButton) {
        guard let uEm = uEmTextField.text else { return }
        guard let pCode = pCodeTextField.text else { return }
        
        
        Auth.auth().signIn(withEmail: uEm, password: pCode) { [weak self] (authRes, error) in
            guard let strongerSelf = self else { return }
            
            print("User's UID: \(authRes?.user.uid)")
            print("Sign in error is: \(error.debugDescription)")
            
            if error == nil {
                
                let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let tabTabViewController = sBoard.instantiateViewController(withIdentifier: "tabTabSBoardID")
           //     strongerSelf.present(xjViewController, animated: true)
                strongerSelf.navigationController?.crossDissolve(tabTabViewController)
            }
        }
    }
    
    @IBAction func shiftToSignUp(_ sender: UIButton) {

        let primaryStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let destination = primaryStoryboard.instantiateViewController(withIdentifier: "upSBoardID") as? SignaUppViewController else {
            print("destination unclear bud")
            return
        }
        navigationController?.crossDissolve(destination)
    }  
}


//        Auth.auth().signIn(withEmail: uEm, password: pCode) { [weak self] (authRes, error) in
//            guard let selfStrong = self else { return }
//
//            print("Auth result is: ", authRes)
//            print("My error is \(error.debugDescription)")
//            print(selfStrong)
//        }
