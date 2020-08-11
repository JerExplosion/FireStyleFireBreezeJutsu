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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fromAnimation = AnimationType.from(direction: .left, offset: 30.0)
        let zoomAnimation = AnimationType.zoom(scale: 0.2)
        let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)

        UIView.animate(views: view.subviews,
                       animations: [rotateAnimation],
                       delay: 0.6)
    }
}
