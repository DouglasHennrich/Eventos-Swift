//
//  HomeViewModelTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

@testable import Eventos
import XCTest

class HomeViewModelTest: HomeViewModelDelegate {
    
    // MARK: Properties
    var navTitle: String = "Eventos"
    var events: Binder<[EventViewModel]> = Binder([])
    var loading: Binder<(actived: Bool, message: String?)> = Binder((false, nil))
    var error: Binder<String> = Binder("")
    
    private var service: HomeServiceDelegate
    var apiShouldFail: Bool = false
    var sections: [String: [EventViewModel]] = [:]
    var exp: XCTestExpectation
    
    // MARK: Init
    init(service: HomeServiceDelegate = HomeServiceTest(), expectation: XCTestExpectation) {
        self.service = service
        self.exp = expectation
    }
    
    // MARK: Actions
    func sortEventsAndCreateSections(events: [EventViewModel]) {
        let sortedEvents = events.sorted { eventA, eventB -> Bool in
            return eventA.timestamp > eventB.timestamp
        }
        
        sections = Dictionary(grouping: sortedEvents, by: { $0.formattedDate })
        self.events.value = sortedEvents
        exp.fulfill()
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
    
    func getEvents(reload: Bool) {
        
        if apiShouldFail {
            error.value = ServiceError.badRequest.message
            exp.fulfill()
            
            //
        } else {
            service.getEvents { [weak self] result in
                switch result {
                case .success(let events):
                    guard let events = events else { return }
                    let models = events.map { EventViewModel(event: $0) }
                    self?.sortEventsAndCreateSections(events: models)
                    
                case .failure(_): break
                }
            }
        }
    }
    
    func eventsCount(forSection at: Int) -> Int {
        return events.value.count
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
    
    func openEventDetails(section: Int, row: Int) {}
    
}
