//
//  Throwable.swift
//  Eventos
//
//  Created by Douglas Hennrich on 21/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

// https://medium.com/flawless-app-stories/how-to-safely-decode-arrays-using-decodable-result-type-in-swift-5b975ea11ff5
public struct Throwable<T: Decodable>: Decodable {
    
    public let result: Swift.Result<T, Error>

    public init(from decoder: Decoder) throws {
        let catching = { try T(from: decoder) }
        result = Swift.Result(catching: catching)
    }
}
