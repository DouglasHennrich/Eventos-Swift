//
//  EventTableViewHeader.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class EventTableViewHeader: UITableViewHeaderFooterView {

    // MARK: IBOutlets
    @IBOutlet weak var containerView: UIView! {
        didSet {
            containerView.cornerRounded(with: 5)
        }
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    // MARK: Actions
    func config(title: String) {
        let date = title.components(separatedBy: "/")
        dayLabel.text = date.first
        monthLabel.text = date.last?.uppercased()
    }

}
