//
//  Storyboarded.swift
//  Eventos
//
//  Created by Douglas Hennrich on 21/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

protocol Storyboarded {
    static func instantiateFromStoryboard(named storyboardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiateFromStoryboard(named storyboardName: String) -> Self {
        let fullName = NSStringFromClass(self)
        
        let className = fullName.components(separatedBy: ".")[1]
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: .main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: className)
            as? Self else {
            fatalError()
        }
        
        return vc
    }
}
