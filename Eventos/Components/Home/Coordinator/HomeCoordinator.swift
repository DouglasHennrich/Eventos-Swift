//
//  HomeCoordinator.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol HomeCoordinatorDelegate: AnyObject {
    func openEventDetails(withId id: String)
}

extension AppCoordinator: HomeCoordinatorDelegate {
    
    func openEventDetails(withId eventId: String) {
        
    }
    
}
