//
//  HomeViewController.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit
import Lottie

class HomeViewController: UIViewController, Storyboarded {

    // MARK: Properties
    var viewModel: HomeViewModelDelegate?
    private var refreshControl = UIRefreshControl()
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(EventTableViewCell.loadNib(),
                               forCellReuseIdentifier: EventTableViewCell.identifier)
            tableView.register(EventTableViewHeader.loadNib(),
                               forHeaderFooterViewReuseIdentifier: EventTableViewHeader.identifier)
            tableView.tableFooterView = UIView()
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.refreshControl = refreshControl
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.navTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        changeStatusBarViewColor(to: .primary)
        
        refreshControl.tintColor = .primary
        refreshControl.attributedTitle = NSAttributedString(string: "Recarregar eventos")
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        
        setUpBinders()
        viewModel?.getEvents(reload: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.isMovingFromParent {
            User.clear()
        }
    }
    
    // MARK: Actions
    private func setUpBinders() {
        
        viewModel?.loading.bind { [weak self] result in
            guard let self = self else { return }
            
            result.actived ? self.view.startLoader(message: result.message) : self.view.stopLoader()
        }
        
        viewModel?.error.bind { [weak self] message in
            let alert = UIAlertController(title: "Erro",
                                          message: message,
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            self?.present(alert, animated: true)
        }
        
        viewModel?.events.bind { [weak self] _ in
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
            //self?.view.layoutIfNeeded()
        }
        
    }

    @objc private func onRefresh() {
        viewModel?.getEvents(reload: true)
    }
}

// MARK: TableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //
        viewModel?.openEventDetails(section: indexPath.section, row: indexPath.row)
    }
    
}

// MARK: TableViewDataSource
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: EventTableViewHeader.identifier) as? EventTableViewHeader,
            let currentSection = viewModel?.getSectionAt(section)
            else {
                return nil
        }
        let backgroundView = UIView(frame: header.bounds)
        backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.8)
        header.backgroundView = backgroundView
        
        header.config(title: currentSection.date)
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.sectionsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.eventsCount(forSection: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EventTableViewCell.identifier,
            for: indexPath) as? EventTableViewCell,
            let event = viewModel?.getEventAt(section: indexPath.section, row: indexPath.row)
            else {
                return UITableViewCell()
        }
        
        cell.config(event: event)
        return cell
    }
}
