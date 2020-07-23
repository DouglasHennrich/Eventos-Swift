//
//  HomeViewModel.swift
//  Eventos
//
//  Created by Douglas Hennrich on 22/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    var navTitle: String { get }
    var events: Binder<[EventViewModel]> { get }
    var loading: Binder<(actived: Bool, message: String?)> { get }
    var error: Binder<String> { get }
    
    func getEvents()
    func eventsCount(forSection at: Int) -> Int
    func sectionsCount() -> Int
    func getEventAt(section: Int, row: Int) -> EventViewModel?
    func getSectionAt(_ at: Int) -> (date: String, items: [EventViewModel])
    func openEventDetails(section: Int, row: Int)
}

class HomeViewModel {
    
    // MARK: Properties
    private var service: HomeServiceDelegate?
    private var navigation: HomeCoordinatorDelegate?
    var navTitle: String = "Eventos"
    var events: Binder<[EventViewModel]> = Binder([])
    var loading: Binder<(actived: Bool, message: String?)> = Binder((actived: false, message: nil))
    var error: Binder<String> = Binder("")
    var sections: [String: [EventViewModel]] = [:]
    
    // MARK: Init
    init(service: HomeServiceDelegate = HomeService(),
         navigation: HomeCoordinatorDelegate? = nil) {
        self.service = service
        self.navigation = navigation
    }
    
    // MARK: Actions
    func sortEventsAndCreateSections(events: [EventViewModel]) {
        let sortedEvents = events.sorted { eventA, eventB -> Bool in
            return eventA.timestamp > eventB.timestamp
        }
        
        sections = Dictionary(grouping: sortedEvents, by: { $0.formattedDate })
        self.events.value = sortedEvents
    }
    
    private func getSection(at: Int) -> (date: String, items: [EventViewModel]) {
        var selectedSection: (date: String, items: [EventViewModel]) = ("", [])
        
        for (index, section) in sections.enumerated() {
            // swiftlint:disable for_where
            if index == at {
                selectedSection = (section.key, section.value)
            }
        }
        
        return selectedSection
    }
    
}

extension HomeViewModel: HomeViewModelDelegate {
    
    func getEvents() {
        loading.value = (true, "Carregando eventos")
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { [weak self] timer in
            timer.invalidate()
            self?.service?.getEvents { [weak self] response in
                self?.loading.value = (false, nil)
                
                switch response {
                case .success(let events):
                    guard let events = events
                        else {
                        return
                    }
                    
                    let eventsViewModels = events.map { EventViewModel(event: $0) }
                    
                    self?.sortEventsAndCreateSections(events: eventsViewModels)
                    
                case .failure(let error):
                    guard let serviceError = error as? ServiceError else {
                        return
                    }
                    
                    self?.error.value = serviceError.message
                }
            }
        }
    }
    
    func eventsCount(forSection at: Int) -> Int {
        let selectedSection = getSection(at: at)
        return selectedSection.items.count
    }
    
    func sectionsCount() -> Int {
        return sections.count
    }
    
    func getEventAt(section: Int, row: Int) -> EventViewModel? {
        let selectedSection = getSection(at: section)
        return selectedSection.items.at(row)
    }
    
    func getSectionAt(_ at: Int) -> (date: String, items: [EventViewModel]) {
        return getSection(at: at)
    }
    
    func openEventDetails(section: Int, row: Int) {
        let selectedSection = getSection(at: section)
        guard let event = selectedSection.items.at(row) else {
            return
        }
        
        navigation?.openEventDetails(withId: event.id)
    }
    
}
