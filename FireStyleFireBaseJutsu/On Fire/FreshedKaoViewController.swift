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

class FreshedKaoViewController: UIViewController {

    @IBOutlet weak var pokeFiTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pokeFiTextLabel.text = ""
        navigationController?.isNavigationBarHidden = true

        animatePokeFi()
    }
    
    func animatePokeFi() {
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
