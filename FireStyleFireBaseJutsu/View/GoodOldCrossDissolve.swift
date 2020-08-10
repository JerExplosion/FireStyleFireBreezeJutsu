//
//  GoodOldCrossDissolve.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/10/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

extension UINavigationController {
    func crossDissolve(_ viewController: UIViewController) {
        
        let cdTransition = CATransition()
        cdTransition.duration = 0.47
        cdTransition.type = CATransitionType.fade
        view.layer.add(cdTransition, forKey: nil)
        pushViewController(viewController, animated: false)
    }
}
 
