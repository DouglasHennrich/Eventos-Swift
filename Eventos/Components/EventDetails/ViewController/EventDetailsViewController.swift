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
    enum DetailsTypes: String {
        case titleAndDescription
        case date
        case price
        case location
        case checkIn
        case peoples
    }
    
    // MARK: Properties
    var viewModel: EventDetailsViewModelDelegate?
    var sectionsAndItems: [SectionsAndItemsDetails] = []
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.register(LocationDetailsTableViewCell.loadNib(),
                               forCellReuseIdentifier: LocationDetailsTableViewCell.identifier)
            
            tableView.register(CheckInDetailsTableViewCell.loadNib(),
                               forCellReuseIdentifier: CheckInDetailsTableViewCell.identifier)
            
            tableView.register(PeoplesDetailsTableViewHeader.loadNib(),
                               forHeaderFooterViewReuseIdentifier: PeoplesDetailsTableViewHeader.identifier)
            
            tableView.register(PeopleDetailsTableViewCell.loadNib(),
                               forCellReuseIdentifier: PeopleDetailsTableViewCell.identifier)
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeStatusBarViewColor(to: .primary)
        
        setUpBinds()
        viewModel?.getEventDetails()
    }
    
    // MARK: Actions
    private func setUpBinds() {
        
        viewModel?.loading.bind { [weak self] params in
            params.actived ? self?.view.startLoader(message: params.message) : self?.view.stopLoader()
        }
        
        viewModel?.error.bind { [weak self] message in
            guard let self = self else { return }
            UIAlertController.showAlert(vc: self, message: message, completion: {
                self.viewModel?.getEventDetails()
            })
        }
        
        viewModel?.event.bind { [weak self] event in
            self?.organizeSectionsAndItems(with: event)
        }
        
    }
    
    private func addEventImage(with image: String) {
        let imageView = UIImageView()
        imageView.kf.indicatorType = .activity
        imageView.contentMode = .scaleAspectFit
        imageView.kf.setImage(with: URL(string: image)) { [weak self] result in
            if case .failure = result {
                imageView.image = nil
            } else {
                self?.tableView.parallaxHeader.view = imageView
                self?.tableView.parallaxHeader.height = 300
                self?.tableView.parallaxHeader.minimumHeight = 0
                self?.tableView.parallaxHeader.mode = .topFill
            }
        }
    }
    
    @objc private func onRefresh() {
        sectionsAndItems.removeAll()
        viewModel?.getEventDetails()
    }
    
    private func organizeSectionsAndItems(with eventModel: EventViewModel?) {
        guard let event = eventModel else {
            return
        }
        
        //
        sectionsAndItems.removeAll()
        
        // Title & Description
        var titleAndDescription = SectionsAndItemsDetails(type: .titleAndDescription)
        titleAndDescription.data.append([
            "firstLabelKey": "Título",
            "firstLabelValue": event.title,
            "secondLabelKey": "Descrição",
            "secondLabelValue": event.description
        ])
        sectionsAndItems.append(titleAndDescription)
        
        // Price
        var price = SectionsAndItemsDetails(type: .price)
        price.data.append([
            "firstLabelKey": "De",
            "firstLabelValue": event.originalPrice as Any,
            "secondLabelKey": "Por",
            "secondLabelValue": event.discountPrice as Any
        ])
        sectionsAndItems.append(price)
        
        // Date
        var date = SectionsAndItemsDetails(type: .date)
        date.data.append([
            "date": event.fullDate
        ])
        sectionsAndItems.append(date)
        
        // Location
        var location = SectionsAndItemsDetails(type: .location)
        location.data.append([ "coords": event.coords ])
        sectionsAndItems.append(location)
        
        // Checkin
        sectionsAndItems.append(SectionsAndItemsDetails(type: .checkIn, data: [ ["Mock": "Fake"] ]))
        
        // Peoples
        for people in event.peoples {
            var newPeople = SectionsAndItemsDetails(type: .peoples)
            newPeople.data.append([
                "person": people
            ])
            
            sectionsAndItems.append(newPeople)
        }
        
        tableView.reloadData()
        addEventImage(with: event.image)
    }
    
    private func dequeueCell(of type: DetailsTypes, at: IndexPath) -> UITableViewCell {
        guard let data: [String: Any] = sectionsAndItems[at.section].data.first
            else {
                return UITableViewCell()
        }
        
        switch type {
        case .titleAndDescription, .price:
            return dequeueGeneric(data, at: at)
        case .date:
            return dequeueDateCell(data, at: at)
        case .location:
            return dequeueLocationCell(data, at: at)
        case .checkIn:
            return dequeueCheckInCell(data, at: at)
        case .peoples:
            return dequeuePeopleCell(data, at: at)
        }
    }
}

// MARK: TableViewDataSource
extension EventDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsAndItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionsAndItems[section].data.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            return dequeueCell(of: sectionsAndItems[indexPath.section].type,
                               at: indexPath)
    }
    
}

// MARK: TableViewDelegate
extension EventDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let currentSection = sectionsAndItems.at(section) else { return .zero }
        if currentSection.type == .peoples {
            return 56
        }
        
        return .zero
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let currentSection = sectionsAndItems.at(section),
            let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: PeoplesDetailsTableViewHeader.identifier) as? PeoplesDetailsTableViewHeader
            else { return nil }
        
        if currentSection.type == .peoples {
            let backgroundView = UIView(frame: header.bounds)
            backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.8)
            header.backgroundView = backgroundView
            
            return header
        }
        
        return nil
    }
    
}

// MARK: Dequeue table view cells
extension EventDetailsViewController {
    
    //
    func dequeueGeneric(_ data: [String: Any], at: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GenericDetailsTableViewCell.identifier,
        for: at) as? GenericDetailsTableViewCell,
            let firstLabelKey = data["firstLabelKey"] as? String,
            let secondLabelKey = data["secondLabelKey"] as? String,
            let secondLabelValue = data["secondLabelValue"] as? String
            else {
                return UITableViewCell()
        }
        
        let firstLabelValue = data["firstLabelValue"]
        
        cell.config(firstLabelKey: firstLabelKey,
                    firstLabelValue: firstLabelValue,
                    secondLabelKey: secondLabelKey,
                    secondLabelValue: secondLabelValue)
        
        return cell
    }
    
    func dequeueDateCell(_ data: [String: Any], at: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: DateDetailsTableViewCell.identifier,
        for: at) as? DateDetailsTableViewCell,
            let date = data["date"] as? String
            else {
                return UITableViewCell()
        }
        
        cell.config(date: date)
        return cell
    }
    
    func dequeueLocationCell(_ data: [String: Any], at: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationDetailsTableViewCell.identifier,
        for: at) as? LocationDetailsTableViewCell,
            let coords = data["coords"] as? [String: Double]
            else {
                return UITableViewCell()
        }
        
        cell.config(with: coords)
        return cell
    }
    
    func dequeueCheckInCell(_ data: [String: Any], at: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CheckInDetailsTableViewCell.identifier,
            for: at) as? CheckInDetailsTableViewCell,
            let alreadyCheckIn = viewModel?.checkInFlag
            else {
                return UITableViewCell()
        }
        
        cell.config(with: alreadyCheckIn)
        
        cell.onButtonPress = { [weak self] button in
            self?.viewModel?.checkIn { success in
                if success {
                    button.setTitle("Você já fez o check-in", for: .normal)
                    button.isEnabled = false
                    button.backgroundColor = .secondary
                }
            }
        }
        return cell
    }
 
    func dequeuePeopleCell(_ data: [String: Any], at: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PeopleDetailsTableViewCell.identifier,
            for: at) as? PeopleDetailsTableViewCell,
        let person = data["person"] as? EventPerson
            else {
                return UITableViewCell()
        }
        
        cell.config(with: person)
        return cell
    }
    
}
