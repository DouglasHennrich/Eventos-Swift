//
//  HomeService.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol HomeServiceDelegate: AnyObject {
    func getEvents(onCompletion: @escaping ((Result<[Event]?, Error>) -> Void))
}

class HomeService {
    
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

extension HomeService: HomeServiceDelegate {
    
    func getEvents(onCompletion: @escaping ((Result<[Event]?, Error>) -> Void)) {
        service.request(withUrl: Route.getEvents.rawValue,
                        withMethod: .get,
                        andParameters: nil) { (response: Result<[Event]?, Error>) in
            
            switch response {
            case .success(let events):
                return onCompletion(.success(events))
            
            case .failure(let error):
                return onCompletion(.failure(error))
            }
        }
    }

}
