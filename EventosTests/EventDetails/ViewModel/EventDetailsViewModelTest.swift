//
//  EventDetailsViewModelTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import XCTest
@testable import Eventos

class EventDetailsViewModelTest: EventDetailsViewModelDelegate {
    
    // MARK: Properties
    var loading: Binder<(actived: Bool, message: String?)> = Binder((false, nil))
    
    var error: Binder<String> = Binder("")
    
    var event: Binder<EventViewModel?> = Binder(nil)
    
    var checkInFlag: Bool = false
    
    let eventId: String
    
    private var service: EventDetailsServiceDelegate
    
    var expectation: XCTestExpectation
    
    var apiShouldFail: Bool = false
    
    // MARK: Init
    init(service: EventDetailsServiceDelegate = EventDetailsServiceTests(),
         eventId: String,
         expectation: XCTestExpectation) {
        self.service = service
        self.eventId = eventId
        self.expectation = expectation
    }
    
    // MARK: Actions
    func getEventDetails() {
        
        if apiShouldFail {
            error.value = ServiceError.badRequest.message
            expectation.fulfill()
            
        } else {
            service.getDetails(for: eventId) { [weak self] result in
                switch result {
                case .success(let event):
                    guard let event = event else { return }
                    self?.event.value = EventViewModel(event: event)
                    self?.expectation.fulfill()
                    
                case .failure(_): break
                }
            }
        }
    }
    
    func checkIn(onCompletion: @escaping ((Bool) -> Void)) {
        onCompletion(true)
        checkInFlag = true
        expectation.fulfill()
    }

}
