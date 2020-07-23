//
//  LoginViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    var users: Binder<[UserViewModel]> { get }
    func getUsers()
    func getUsersCount() -> Int
    func loginUser(at: Int)
    
    subscript(row: Int) -> UserViewModel { get }
}

class LoginViewModel {
    
    // MARK: Properties
    var navigation: LoginCoordinatorDelegate?
    let mockUsers: [User] = [
        User(id: "1", name: "Douglas Hennrich", email: "Douglas.hennrich@hotmail.com"),
        User(id: "2", name: "Otávio da Silva", email: "otavio_souza@gmail.com")
    ]
    
    var users: Binder<[UserViewModel]> = Binder([])
    
    // MARK: Init
    init(navigation: LoginCoordinatorDelegate? = nil) {
        self.navigation = navigation
    }
    
}

extension LoginViewModel: LoginViewModelDelegate {
    
    func getUsers() {
        users.value = mockUsers.map { UserViewModel(user: $0) }
    }
    
    func getUsersCount() -> Int {
        return users.value.count
    }
    
    func loginUser(at: Int) {
        User.saveUser(users.value[at].getUser())
        navigation?.openEventsList()
    }
    
    subscript(row: Int) -> UserViewModel {
        return users.value[row]
    }
    
}
