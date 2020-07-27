//
//  GenericDetailsTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 25/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class GenericDetailsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var firstLabelKey: UILabel!
    
    @IBOutlet weak var firstLabelValue: UILabel!
    
    @IBOutlet weak var secondLabelKey: UILabel!
    
    @IBOutlet weak var secondLabelValue: UILabel!
    
    // MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    // MARK: Actions
    func config(firstLabelKey: String, firstLabelValue: Any?,
                secondLabelKey: String, secondLabelValue: String) {
        self.firstLabelKey.text = firstLabelKey
        
        if let attributed = firstLabelValue as? NSMutableAttributedString {
            self.firstLabelValue.attributedText = attributed
            
        } else {
            self.firstLabelValue.text = firstLabelValue as? String
        }
        
        self.secondLabelKey.text = secondLabelKey
        self.secondLabelValue.text = secondLabelValue
    }
    
}
