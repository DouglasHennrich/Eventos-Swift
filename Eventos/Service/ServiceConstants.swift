//
//  ServiceConstants.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

struct ServiceConstants {
    
    // The API's base URL
    static let baseUrl = "http://5b840ba5db24a100142dcd8c.mockapi.io/api"
    
    // The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    // The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
