//
//  EventTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var eventImageView: UIImageView!
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectView = UIView()
        selectView.frame = self.frame
        selectView.backgroundColor = .primary
        
        selectedBackgroundView = selectView
    }
    
    override func prepareForReuse() {
        eventImageView.image = nil
        eventTitleLabel.text = ""
        eventDescriptionLabel.text = ""
        
        super.prepareForReuse()
    }
    
    // MARK: Config
    func config(event: EventViewModel) {
        eventImageView.downloaded(from: event.image)
        eventTitleLabel.text = event.title
        eventDescriptionLabel.text = event.description
    }
    
}
