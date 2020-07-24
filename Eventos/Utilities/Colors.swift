//
//  Colors.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let primary: UIColor = UIColor(red: 136/255.0, green: 197/255.0, blue: 69/255.0, alpha: 1.0)

    // Used in Letter Image Generate
    struct ImageLetter {
        static var letterImageGeneratorBackground: UIColor {
            return UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 1)
        }
        
        static var letterImageGeneratorLabel: UIColor {
            return UIColor(red: 198/255, green: 198/255, blue: 198/255, alpha: 1)
        }
    }
    
}
