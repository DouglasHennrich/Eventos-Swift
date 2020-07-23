//
//  LoginCoordinator.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol LoginCoordinatorDelegate: AnyObject {
    func openEventsList()
}

extension AppCoordinator: LoginCoordinatorDelegate {
    
    func openEventsList() {
        let viewModel = HomeViewModel(navigation: self)
        let vc = HomeViewController.instantiateFromStoryboard(named: "Home")
        vc.viewModel = viewModel
        
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(vc, animated: true)
    }
    
}
