//
//  VelocityAnimaViewController.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/11/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit
import ViewAnimator

class VelocityAnimaViewController: UIViewController {
    
    let fromAnimation = AnimationType.from(direction: .left, offset: 33.33)
    let zoomAnimation = AnimationType.zoom(scale: 0.222)
      
    var animaDelay = 0.3

    override func viewDidLoad() {
        super.viewDidLoad()
        rotator(animaDelay: 0.3)
    }
    
    override func viewWillAppear(_ animated: Bool) {   }
    
    func rotator(animaDelay: Double) {
         let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)

         UIView.animate(views: view.subviews,
                        animations: [rotateAnimation],
                        delay: animaDelay)
    }
}
