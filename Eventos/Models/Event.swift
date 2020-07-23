//
//  Events.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

struct Event: Codable {
    let people: [EventPerson]
    let date: Int
    let eventDescription: String
    let image: String
    let longitude: Double
    let latitude: Double
    let price: Double
    let title: String
    let id: String
    let cupons: [EventCupon]

    enum CodingKeys: String, CodingKey {
        case people, date
        case eventDescription = "description"
        case image, longitude, latitude, price, title, id, cupons
    }
}

// MARK: - Cupon
struct EventCupon: Codable {
    let id: String
    let eventId: String
    let discount: Int
}

// MARK: - Person
struct EventPerson: Codable {
    let id: String
    let eventId: String
    let name: String
    let picture: String
}
