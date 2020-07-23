//
//  User.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

class User: Codable {
    // MARK: Properties
    let id: String
    let name: String
    let email: String
    
    // MARK: Init
    init(id: String, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    // MARK: Shared
    private static var privateShared: User?
}

extension User {
    
    static func current() -> User? {
        return privateShared
    }
    
    static func saveUser(_ user: User) {
        privateShared = user
    }
    
    static func clear() {
        privateShared = nil
    }
    
}
