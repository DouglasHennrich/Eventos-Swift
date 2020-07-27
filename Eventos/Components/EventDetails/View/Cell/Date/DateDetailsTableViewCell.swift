//
//  DateDetailsTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 26/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class DateDetailsTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    // MARK: Config
    func config(date: String) {
        dateLabel.text = date
    }
}
