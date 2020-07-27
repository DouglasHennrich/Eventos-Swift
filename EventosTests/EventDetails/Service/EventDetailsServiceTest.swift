//
//  EventDetailsServiceTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation
@testable import Eventos

class EventDetailsServiceTests: EventDetailsServiceDelegate {
    
    func getDetails(for eventId: String, onCompletion: @escaping ((Result<Event?, Error>) -> Void)) {
        let eventMock = Event.asMockDataWith(id: eventId)
        onCompletion(.success(eventMock))
    }
    
    func makeCheckIn(for eventId: String, onCompletion: @escaping ((Result<CheckInResponse?, Error>) -> Void)) {
        let checkInResponseMock = CheckInResponse(code: "200")
        
        onCompletion(.success(checkInResponseMock))
    }
    
    
}
