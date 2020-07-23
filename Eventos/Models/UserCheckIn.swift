//
//  UserCheckIn.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

struct UserCheckIn: Encodable {
    let name: String
    let email: String
    let eventId: String
}
