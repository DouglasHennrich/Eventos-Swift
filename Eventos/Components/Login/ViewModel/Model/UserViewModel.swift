//
//  UserViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

struct UserViewModel {
    
    private let user: User
    
    var name: String {
        return user.name
    }
    
    var email: String {
        return user.email
    }
    
    init(user: User) {
        self.user = user
    }
    
    func getUser() -> User {
        return user
    }
    
}
