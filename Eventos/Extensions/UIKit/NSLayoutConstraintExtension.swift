//
//  NSLayoutConstraintExtension.swift
//  Eventos
//
//  Created by Douglas Hennrich on 21/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    @IBInspectable var iPhone5: CGFloat {
        get { return constant }
        set {
            if UIScreen.main.nativeBounds.height == 1136 {
                constant = newValue
            }
        }
    }
    
    @IBInspectable var iPhone678: CGFloat {
        get { return constant }
        set {
            if UIScreen.main.nativeBounds.height == 1334 {
                constant = newValue
            }
        }
    }
    
    @IBInspectable var iPhonePlus: CGFloat {
        get { return constant }
        set {
            if UIScreen.main.nativeBounds.height == 2208 {
                constant = newValue
            }
        }
    }
    
    @IBInspectable var iPhoneX: CGFloat {
        get { return constant }
        set {
            if #available(iOS 11.0, *) {
                if UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 24 {
                    constant = newValue
                }
            }
        }
    }
}
