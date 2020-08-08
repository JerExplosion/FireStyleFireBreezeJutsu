//
//  FreshedKaoViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/7/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import Firebase
import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth

class FreshedKaoViewController: UIViewController {
    

    @IBOutlet weak var pokeFiTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        animatePokeFi()
        
        
        refExperimentation()
    }
    
    func refExperimentation() {
        
        Auth.auth().createUser(withEmail: "kinsa@kinsa.com", password: "kinsakinsa") { (result, erro) in
            if erro != nil {
                print(erro?.localizedDescription)
                return
            } else {
                let experimentalRef =  Database.database().reference()
                
                let ufoReference = experimentalRef.child("UFO")
                
                guard let ufoUID = result?.user.uid else { return }
                print("ufoUID is", ufoUID)
                
                let newUfoReference = ufoReference.child(ufoUID)
                
                let ufoDict = ["ufoName":  "KinsaBia", "ufoEmail": "kinsa@kinsa.com"]
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
