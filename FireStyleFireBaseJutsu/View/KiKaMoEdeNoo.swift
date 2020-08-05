//
//  SpecialTextEffectField.swift
//  FireStyleFireBaseJutsu
//
//  Created by Jerry Ren on 8/6/20.
//  Copyright © 2020 Jerry Ren. All rights reserved.
//

import UIKit

@IBDesignable open class KaedeTextField: TextFieldEffects {

    @IBInspectable dynamic open var placeholderColor: UIColor? {
        didSet {
            updatePlaceholder()
        }
    }

    @IBInspectable dynamic open var placeholderFontScale: CGFloat = 0.8 {
        didSet {
            updatePlaceholder()
        }
    }

    @IBInspectable dynamic open var foregroundColor: UIColor? {
        didSet {
            updateForegroundColor()
        }
    }

    @IBInspectable dynamic open var placeholderSplit: CGFloat = 0.6

    override open var placeholder: String? {
        didSet {
            updatePlaceholder()
        }
    }

    override open var bounds: CGRect {
        didSet {
            drawViewsForRect(bounds)
        }
    }

    private let foregroundView = UIView()
    private let placeholderInsets = CGPoint(x: 10, y: 5)
    private let textFieldInsets = CGPoint(x: 10, y: 0)

    // MARS: - Effectsoo

    override open func drawViewsForRect(_ rect: CGRect) {
        let frame = CGRect(origin: .zero, size: CGSize(width: rect.size.width, height: rect.size.height))

        foregroundView.frame = frame
        foregroundView.isUserInteractionEnabled = false
        placeholderLabel.frame = frame.insetBy(dx: placeholderInsets.x, dy: placeholderInsets.y)
        placeholderLabel.font = placeholderFontFromFont(font!)

        updateForegroundColor()
        updatePlaceholder()

        if text!.aintEmpty || isFirstResponder {
            animateViewsForTextEntry()
        }
        addSubview(foregroundView)
        addSubview(placeholderLabel)
    }

    override open func animateViewsForTextEntry() {
        let directionOverride: CGFloat

        if #available(iOS 9.0, *) {
            directionOverride = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft ? -1.0 : 1.0
        } else {
            directionOverride = 1.0
        }

        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
            self.placeholderLabel.frame.origin = CGPoint(x: self.frame.size.width * (self.placeholderSplit + 0.05) * directionOverride, y: self.placeholderInsets.y)
        }), completion: nil)

        UIView.animate(withDuration: 0.45, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.5, options: .beginFromCurrentState, animations: ({
            self.foregroundView.frame.origin = CGPoint(x: self.frame.size.width * self.placeholderSplit * directionOverride, y: 0)
        }), completion: { _ in
            self.animationCompletionHandler?(.textEntry)
        })
    }

    override open func animateViewsForTextDisplay() {
        if text!.isEmpty {
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.placeholderLabel.frame.origin = self.placeholderInsets
            }), completion: nil)

            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 2.0, options: .beginFromCurrentState, animations: ({
                self.foregroundView.frame.origin = CGPoint.zero
            }), completion: { _ in
                self.animationCompletionHandler?(.textDisplay)
            })
        }
    }

    // MARS: -

    private func updateForegroundColor() {
        foregroundView.backgroundColor = foregroundColor
    }

    private func updatePlaceholder() {
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor
    }

    private func placeholderFontFromFont(_ font: UIFont) -> UIFont! {
       let smallerFont = UIFont(descriptor: font.fontDescriptor, size: font.pointSize * placeholderFontScale)
        return smallerFont
    }

    // MARS: - Over-Ridden

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        var frame = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width * placeholderSplit, height: bounds.size.height))

        if #available(iOS 9.0, *) {
            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft {
                frame.origin = CGPoint(x: bounds.size.width - frame.size.width, y: frame.origin.y)
            }
        }

        return frame.insetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return editingRect(forBounds: bounds)
    }

}

