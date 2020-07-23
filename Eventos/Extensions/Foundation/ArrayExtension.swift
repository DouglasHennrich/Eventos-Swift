//
//  ArrayExtension.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

extension Array {
    
    func at(_ index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
    
}
