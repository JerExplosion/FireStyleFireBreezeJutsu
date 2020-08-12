//
//  FreshedKaoViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/7/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
  
  //  assertNotNil( FirebaseManager.shared)

class FreshedKaoViewController: VelocityAnimaViewController {
    
    @IBOutlet weak var pokeFiTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.77) {
            self.animatePokeFi()
        }
    }
    
    func refExperimentation() {
        
        Auth.auth().createUser(withEmail: "kiikii@kiikii.com", password: "kiikii") { (result, erro) in
            if erro != nil {
                print(erro?.localizedDescription)
                return
            } else {
                let experimentalRef =  Database.database().reference()
                
                let ufoReference = experimentalRef.child("UFO")
                
                // MARS: -
                
                guard let ufoUID = result?.user.uid else { return }  // of Auth.auth().currentUser?.uid (约等于)
                guard let ufoUIDSecondVersion = Auth.auth().currentUser?.uid else { return }
                print("ufoUID is", ufoUID)
                print("ufoUIDSecondVersion is", ufoUIDSecondVersion)
                
                // MARS: -
                
                let newUfoReference = ufoReference.child(ufoUID)
                
                let ufoDict = ["ufoName":  "KisBia", "ufoEmail": "kis@kis.com"]
                newUfoReference.setValue(ufoDict)
                
                print("description is", newUfoReference.description())
            }
        }
    }     
    
    
    func animatePokeFi() {
        self.pokeFiTextLabel.text = ""
        let fullDisplay = "Pokémon FighterZ"
        var unitCount = 0
        
        for singleTextUnit in fullDisplay {
            Timer.scheduledTimer(withTimeInterval: Double(unitCount) * 0.1, repeats: false) { (timer) in
                self.pokeFiTextLabel.text?.append(singleTextUnit)
            }
            unitCount += 1
        }
    }

}
