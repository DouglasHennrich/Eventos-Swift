//
//  EventViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

struct EventViewModel: Codable {
    
    private let event: Event
    
    private var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        formatter.alwaysShowsDecimalSeparator = true
        
        return formatter
    }
    
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
    
    var fullDate: String {
        let date = Date(timeIntervalSince1970: TimeInterval(event.date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "BRT")
        dateFormatter.locale = NSLocale(localeIdentifier: "pt_br") as Locale
        dateFormatter.dateFormat = "dd.MM.yy 'às' HH:mm"
        return dateFormatter.string(from: date)
    }
    
    var originalPrice: NSAttributedString? {
        guard let price = self.formatter.string(for: event.price) else {
            return nil
        }
        
        let attributedString = NSMutableAttributedString(string: price)
        
        if event.cupons.count >= 1 {
            attributedString.addAttributes([
                NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.thick.rawValue,
                NSAttributedString.Key.strikethroughColor: UIColor.secondary,
                NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], range: NSRange(location: 0, length: attributedString.length))
            
            return attributedString
            
        } else {
            return attributedString
        }
    }
    
    var discountPrice: String? {
        var total: Double = event.price
        
        for discount in event.cupons {
            total -= discount.discount
        }
        
        if total < 0 {
            return "Grátis"
        }
        
        return self.formatter.string(for: total)
    }
    
    var coords: [String: Double] {
        return [
            "latitude": event.latitude,
            "longitude": event.longitude
        ]
    }
    
    var peoples: [EventPerson] {
        return event.peoples
    }
    
    // MARK: Init
    init(event: Event) {
        self.event = event
    }
    
}
