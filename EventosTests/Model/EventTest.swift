//
//  EventTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation
@testable import Eventos

extension Event {
    
    static func mockDataWith(id: String) -> Event {
        let person = EventPerson(id: "1", eventId: "1", name: "Douglas Hennrich", picture: "")
        let cupon = EventCupon(id: id, eventId: id, discount: 10.0)
        
        let event = Event(peoples: [person],
                          date: 1534784400000,
                          eventDescription: "Mock data",
                          image: "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png",
                          longitude: -51.2146267,
                          latitude: -30.0392981,
                          price: 29.99,
                          title: "Evento Teste \(id)",
            id: id,
            cupons: [cupon])
        
        return event
    }
    
}
