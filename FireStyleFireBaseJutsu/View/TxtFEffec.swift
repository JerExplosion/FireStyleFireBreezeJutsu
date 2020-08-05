//
//  TxtFEffec.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/5/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

open class TextFieldEffects : UITextField {

    public enum AnimationType: Int {
        case textEntry
        case textDisplay
    }
    
    public typealias AnimationCompletionHandler = (_ type: AnimationType)->()

    public let placeholderLabel = UILabel()

    open func animateViewsForTextEntry() {
        print("\(#function) must be overridden")
    }

    open func animateViewsForTextDisplay() {
        print("\(#function) must be overridden")
    }

    open var animationCompletionHandler: AnimationCompletionHandler?

    open func drawViewsForRect(_ rect: CGRect) {
        print("\(#function) must be overridden")
    }
    
    open func updateViewsForBoundsChange(_ bounds: CGRect) {
        print("\(#function) must be overridden")
    }
    
    // MARS: - Over-Ridden
    
    override open func draw(_ rect: CGRect) {
        guard isFirstResponder == false else { return }
        drawViewsForRect(rect)
    }
    
    override open func drawPlaceholder(in rect: CGRect) {  }
    
    override open var text: String? {
        didSet {
            if let text = text, text.aintEmpty || isFirstResponder {
                animateViewsForTextEntry()
            } else {
                animateViewsForTextDisplay()
            }
        }
    }
 
    override open func willMove(toSuperview newSuperview: UIView!) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing), name: UITextField.textDidEndEditingNotification, object: self)
            
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing), name: UITextField.textDidBeginEditingNotification, object: self)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }

    @objc open func textFieldDidBeginEditing() {
        animateViewsForTextEntry()
    }

    @objc open func textFieldDidEndEditing() {
        animateViewsForTextDisplay()
    }

    override open func prepareForInterfaceBuilder() {
        drawViewsForRect(frame)
    }
}
