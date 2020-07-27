//
//  PeopleDetailsTableViewCell.swift
//  Eventos
//
//  Created by Douglas Hennrich on 26/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit
import Kingfisher

class PeopleDetailsTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.cornerRounded()
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
        super.prepareForReuse()
    }
    
    // MARK: Action
    func config(with person: EventPerson) {
        nameLabel.text = person.name
        
        photoImageView.kf.setImage(with: URL(string: person.picture)) { [weak self] result in
            if case .failure = result {
                self?.photoImageView.image = LetterImageGenerate.imageWith(name: person.name)
            }
        }
    }
}
