//
//  EncodableExtension.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

extension Encodable {
    
    func asDictionary() throws -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data,
                                                              options: .allowFragments)
            
            if let dictionary = jsonObject as? [String: Any] {
                return dictionary
            }
            
            return [:]
        } catch {
            throw error
        }
    }
    
}
