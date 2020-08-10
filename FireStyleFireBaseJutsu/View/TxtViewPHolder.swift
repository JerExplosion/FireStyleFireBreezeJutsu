//
//  TxtViewPHolder.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/11/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

@IBDesignable class TxtViewWitPHolder: UITextView {

    override var text: String! {
        get {
            if showingPHolder {
                return ""
            }
            else { return super.text }
        }
        set { super.text = newValue }
    }
    @IBInspectable var pHolderTxtColor: UIColor = UIColor(red: 0.777, green: 0.770, blue: 0.822, alpha: 1.00)
    @IBInspectable var pHolderTxt: String = ""
    
    private var showingPHolder: Bool = true
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if text.isEmpty {
            showPHolderText()
        }
    }
    
    private func showPHolderText() {
        showingPHolder = true
        textColor = self.pHolderTxtColor
        text = self.pHolderTxt
    }
    
    override func resignFirstResponder() -> Bool {
        if text.isEmpty {
            showPHolderText()
        }
        return super.resignFirstResponder()
    }
    
    override func becomeFirstResponder() -> Bool {
        if showingPHolder {
            text = nil
            self.textColor = nil
            showingPHolder = false
        }
        return super.becomeFirstResponder()
    }
}
