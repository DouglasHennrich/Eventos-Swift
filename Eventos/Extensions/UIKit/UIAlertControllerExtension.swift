//
//  UIAlertControllerExtension.swift
//  Eventos
//
//  Created by Douglas Hennrich on 25/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    class func showAlert(vc: UIViewController,
                         title: String = "Alerta",
                         message: String,
                         confirmAction: UIAlertAction? = nil,
                         cancelAction: UIAlertAction? = nil,
                         completion: (() -> Void)? = nil,
                         showCancelAction: Bool = true) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let unConfirmAction = confirmAction {
            alertController.addAction(unConfirmAction)
            if showCancelAction {
                let cancelAction = cancelAction ?? UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
            }
        } else {
            alertController.addAction(UIAlertAction(title: "OK",
                                                    style: UIAlertAction.Style.cancel,
                                                    handler: nil))
        }
        
        vc.present(alertController, animated: true, completion: completion)
    }
    
}
