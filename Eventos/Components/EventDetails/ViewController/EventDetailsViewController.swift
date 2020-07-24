//
//  EventDetailsViewController.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit
import ParallaxHeader
import Kingfisher

class EventDetailsViewController: UIViewController, Storyboarded {
    
    // MARK: Enum
    enum DetailsTypes {
        case titleAndDescription
        case dateAndPrice
        case location
        case peoples
        case checkIn
        case cupons
    }
    
    // MARK: Properties
    var viewModel: EventDetailsViewModelDelegate?
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinds()
        
        addEventImage(with: "https://asdasded.com.de")
    }
    
    // MARK: Actions
    private func setUpBinds() {
        
    }
    
    private func addEventImage(with image: String) {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: URL(string: image)) { result in
            if case .failure = result {
                imageView.image = nil
            }
        }
        imageView.contentMode = .scaleAspectFit
        
        if imageView.image == nil {
            return
        }
              
        tableView.parallaxHeader.view = imageView
        tableView.parallaxHeader.height = 300
        tableView.parallaxHeader.minimumHeight = 0
        tableView.parallaxHeader.mode = .topFill
    }
    
}
