//
//  CheckInDetailsTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 26/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class CheckInDetailsTableViewCell: UITableViewCell {
    
    // MARK: Properties
    var onButtonPress: ((_ button: UIButton) -> Void)?
    
    // MARK: IBOutlets
    @IBOutlet weak var checkInButton: UIButton! {
        didSet {
            checkInButton.cornerRounded(with: 5)
        }
    }
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        onButtonPress = nil
        checkInButton.isEnabled = true
        checkInButton.backgroundColor = .primary
        super.prepareForReuse()
    }
    
    // MARK: Config
    func config(with alreadyCheckIn: Bool) {
        if alreadyCheckIn {
            checkInButton.isEnabled = false
            checkInButton.setTitle("Você já fez o check-in", for: .normal)
            checkInButton.backgroundColor = .secondary
        }
    }
    
    // MARK: IBActions
    @IBAction func onAction(_ sender: UIButton) {
        onButtonPress?(sender)
    }
    
}
