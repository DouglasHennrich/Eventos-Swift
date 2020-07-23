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
        self.navigationController = UINavigationController()
        self.navigationController.navigationBar.tintColor = .primary
        self.navigationController.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.primary
        ]
        self.navigationController.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.primary
        ]
    }
    
    // MARK: Actions
    func start() {
        let viewModel = HomeViewModel(navigation: self)
        let vc = HomeViewController.instantiateFromStoryboard(named: "Home")
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: false)
    }
    
}
