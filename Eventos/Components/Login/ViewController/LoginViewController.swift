//
//  LoginViewController.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, Storyboarded {
    
    // MARK: Properties
    var viewModel: LoginViewModelDelegate?
    
    // MARK: IBOutlets
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.alpha = 0
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.alpha = 0
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBinds()
        
        viewModel?.getUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateContents(show: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateContents(show: false)
    }
    
    // MARK: Actions
    private func setUpBinds() {
        viewModel?.users.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    private func animateContents(show: Bool) {
        UIView.animate(withDuration: 0.7, animations: { [weak self] in
            let value: CGFloat = show ? 1 : 0
            self?.infoLabel.alpha = value
            self?.tableView.alpha = value
        })
    }

}

// MARK: TableView Delegate
extension LoginViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel?.loginUser(at: indexPath.row)
    }
    
}

// MARK: TableView DataSource
extension LoginViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoginUserTableViewCell.identifier,
                                                       for: indexPath ) as? LoginUserTableViewCell,
        let viewModel = viewModel
            else {
            return UITableViewCell()
        }
        
        cell.config(user: viewModel[indexPath.row])
        return cell
    }
    
}
