//
//  HomeServiceTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation
@testable import Eventos

class HomeServiceTest: HomeServiceDelegate {
    
    func getEvents(onCompletion: @escaping ((Result<[Event]?, Error>) -> Void)) {
        var events: [Event] = []
        
        for index in 1...3 {
            events.append(Event.asMockDataWith(id: "\(index)"))
        }
        
        onCompletion(.success(events))
    }

}
