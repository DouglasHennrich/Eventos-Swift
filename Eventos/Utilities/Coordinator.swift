//
//  Coordinator.swift
//  Eventos
//
//  Created by Douglas Hennrich on 21/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

protocol Coordinator {
    
    var navigationController: UINavigationController { get set }
    
    func start()
    
}
