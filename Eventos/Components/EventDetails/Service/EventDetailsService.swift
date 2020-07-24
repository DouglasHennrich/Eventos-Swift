//
//  EventDetailsService.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol EventDetailsServiceDelegate: AnyObject {
    func getDetails(for eventId: Int, onCompletion: @escaping ((Result<Event?, Error>) -> Void))
}

class EventDetailsService {
    
    // MARK: Enum
    enum Route: String {
        case getEvents = "events"
    }
    
    // MARK: Properties
    let service: ServiceClientDelegate
    
    // MARK: Init
    init(service: ServiceClientDelegate = ServiceClient()) {
        self.service = service
    }
    
}

extension EventDetailsService: EventDetailsServiceDelegate {
    
    func getDetails(for eventId: Int, onCompletion: @escaping ((Result<Event?, Error>) -> Void)) {
        let url = Route.getEvents.rawValue + "/\(eventId)"
        
        service.request(withUrl: url,
                        withMethod: .get,
                        andParameters: nil) { (response: Result<Event?, Error>) in
            
            switch response {
            case .success(let event):
                return onCompletion(.success(event))
            
            case .failure(let error):
                return onCompletion(.failure(error))
            }
        }
    }
    
}
