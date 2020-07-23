//
//  EventViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

struct EventViewModel: Codable {
    let event: Event
    
    var id: String {
        return event.id
    }
    
    var title: String {
        return event.title
    }
    
    var image: String {
        return event.image
    }
    
    var description: String {
        return event.eventDescription
    }
    
    var timestamp: Int {
        return event.date
    }
    
    var formattedDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(event.date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "BRT")
        dateFormatter.locale = NSLocale(localeIdentifier: "pt_br") as Locale
        dateFormatter.dateFormat = "dd/MMM"
        return dateFormatter.string(from: date)
    }
}
