//
//  FormulaAlert.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/10/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertFormula(title: String?, message: String?, action: String?) {
        let alertCon = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: action, style: .cancel, handler: nil)
        alertCon.addAction(dismissAction)
        present(alertCon, animated: true, completion: nil)
    }
}
 
