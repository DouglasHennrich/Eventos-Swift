//
//  AppCoordinator.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: Properties
    var navigationController: UINavigationController
    
    // MARK: Init
    init() {
        navigationController = UINavigationController()
        navigationController.navigationBar.tintColor = .primary
        navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.primary
        ]
        navigationController.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.primary
        ]
    }
    
    // MARK: Actions
    func start() {
        let viewModel = LoginViewModel(navigation: self)
        let vc = LoginViewController.instantiateFromStoryboard(named: "Login")
        vc.viewModel = viewModel
        
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: false)
    }
    
}
