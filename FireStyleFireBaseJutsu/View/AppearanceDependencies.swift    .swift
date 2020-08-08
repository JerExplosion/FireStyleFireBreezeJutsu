//
//  Appearance.swift    .swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 7/27/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

// MARS: - TXF
@IBDesignable class RTextfield: UITextField {
    @IBInspectable var cRadio: CGFloat = 2.22 {
        didSet {
            self.layer.cornerRadius = cRadio
        }}
    @IBInspectable var borColo: UIColor? {
        didSet {
            self.layer.borderColor = borColo?.cgColor
        }}
    
    @IBInspectable var borWii: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borWii
        }}
}

// MARS: - IMV
@IBDesignable class RImageView: UIImageView {
    
    @IBInspectable var cRadio: CGFloat = 5.55 {
        didSet {
            self.layer.cornerRadius = cRadio
    }}}

// MARS: - BTN
@IBDesignable class RoButton: UIButton {
    @IBInspectable var cRadio: CGFloat = 3.33 {
        didSet {
            self.layer.cornerRadius = cRadio
    }}}
