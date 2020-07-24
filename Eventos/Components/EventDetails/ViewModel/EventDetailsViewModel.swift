//
//  EventDetailsViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol EventDetailsViewModelDelegate: AnyObject {
    func getEventDetails()
    
    var loading: Binder<(actived: Bool, message: String?)> { get }
    var error: Binder<String> { get }
    var event: Binder<Event?> { get }
}

class EventDetailsViewModel {
    
    // MARK: Properties
    let eventId: String
    var service: EventDetailsServiceDelegate?
    var loading: Binder<(actived: Bool, message: String?)> = Binder((actived: false, message: nil))
    var error: Binder<String> = Binder("")
    var event: Binder<Event?> = Binder(nil)
    
    // MARK: Init
    init(eventId: String, service: EventDetailsServiceDelegate? = EventDetailsService()) {
        self.eventId = eventId
        self.service = service
    }
    
    // MARK: Actions
    
}

extension EventDetailsViewModel: EventDetailsViewModelDelegate {
    func getEventDetails() {
        
    }
}
