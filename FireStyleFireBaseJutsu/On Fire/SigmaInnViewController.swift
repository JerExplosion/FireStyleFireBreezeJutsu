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
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }   

    @IBAction func sigmaInnAction(_ sender: UIButton) {
        guard let uEm = uEmTextField.text else { return }
        guard let pCode = pCodeTextField.text else { return }
        
//        Auth.auth().signIn(withEmail: uEm, password: pCode) { [weak self] (authRes, error) in
//            guard let selfStrong = self else { return }
//
//            print("Auth result is: ", authRes)
//            print("My error is \(error.debugDescription)")
//            print(selfStrong)
//        }
        
        Auth.auth().signIn(withEmail: uEm, password: pCode) { [weak self] (authRes, error) in
            guard let strongerSelf = self else { return }
            
            print("User's UID: \(authRes?.user.uid)")
            print("Sign in error is: \(error.debugDescription)")
            
            if error == nil {
                
                let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let xjViewController = sBoard.instantiateViewController(withIdentifier: "XJViewController")
                strongerSelf.present(xjViewController, animated: true)
            }
        }
    }
    
}       
