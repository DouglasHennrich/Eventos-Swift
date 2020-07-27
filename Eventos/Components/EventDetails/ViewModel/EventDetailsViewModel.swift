//
//  EventDetailsViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 23/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import UIKit

protocol EventDetailsViewModelDelegate: AnyObject {
    var loading: Binder<(actived: Bool, message: String?)> { get }
    var error: Binder<String> { get }
    var event: Binder<EventViewModel?> { get }
    var checkInFlag: Bool { get }
    
    func getEventDetails()
    func checkIn(onCompletion: @escaping ((_ success: Bool) -> Void))
}

class EventDetailsViewModel {
    
    // MARK: Properties
    private var service: EventDetailsServiceDelegate?
    let eventId: String
    
    var loading: Binder<(actived: Bool, message: String?)> = Binder((actived: false, message: nil))
    var error: Binder<String> = Binder("")
    var event: Binder<EventViewModel?> = Binder(nil)
    
    var checkInFlag: Bool = false
    
    // MARK: Init
    init(eventId: String, service: EventDetailsServiceDelegate? = EventDetailsService()) {
        self.eventId = eventId
        self.service = service
    }
    
}

extension EventDetailsViewModel: EventDetailsViewModelDelegate {
    
    func getEventDetails() {
        loading.value = (true, "Buscando detalhes")
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] timer in
            timer.invalidate()
            guard let self = self else { return }
            
            self.service?.getDetails(for: self.eventId) { [weak self] response in
                self?.loading.value = (false, nil)
                
                switch response {
                case .success(let event):
                    guard let eventDetails = event else {
                        return
                    }
                    
                    self?.event.value = EventViewModel(event: eventDetails)
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    self?.error.value = error.message
                }
            }
        }
    }
    
    func checkIn(onCompletion: @escaping ((_ success: Bool) -> Void)) {
        loading.value = (true, "Realizando Check-In")
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [weak self] timer in
            timer.invalidate()
            guard let self = self else { return }
            
            self.service?.makeCheckIn(for: self.eventId) { [weak self] result in
                self?.loading.value = (false, nil)
                switch result {
                case .success(_):
                    self?.checkInFlag = true
                    return onCompletion(true)
                    
                case .failure(let error):
                    guard let error = error as? ServiceError else { return }
                    self?.error.value = error.message
                    self?.checkInFlag = false
                    return onCompletion(false)
                }
            }
        }
    }
    
}
