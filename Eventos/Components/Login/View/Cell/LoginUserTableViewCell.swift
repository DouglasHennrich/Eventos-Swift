//
//  LoginUserTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class LoginUserTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectView = UIView()
        selectView.frame = self.frame
        selectView.backgroundColor = .white
        
        selectedBackgroundView = selectView
    }
    
    // MARK: Actions
    func config(user: UserViewModel) {
        nameLabel.text = user.name
        emailLabel.text = user.email
    }

}
