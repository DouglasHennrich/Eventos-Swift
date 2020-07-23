//
//  Binder.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

class Binder<T> {

    typealias Listener = ((T) -> Void)

    private(set) var listener: Listener?

    var onSetEvents: Int = 0

    func bind(listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(listener: Listener?) {
        self.listener = listener
        callListener()
    }

    var value: T {
        didSet {
            onSetEvents += 1
            callListener()
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func isBinded() -> Bool {
        return listener != nil
    }

    private func callListener() {
        if Thread.isMainThread {
            listener?(value)
            
        } else {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }
    
}
