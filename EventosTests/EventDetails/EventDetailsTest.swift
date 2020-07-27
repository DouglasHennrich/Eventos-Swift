//
//  EventDetailsTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import XCTest
@testable import Eventos

class EventDetailsTest: XCTestCase {
    
    // MARK: Properties
    var sut: EventDetailsViewController?
    let eventId: String = "1"
    
    // MARK: Life cycle
    override func setUp() {
        super.setUp()
        
        sut = EventDetailsViewController.instantiateFromStoryboard(named: "EventDetails")
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    // MARK: Actions
    func test_getEventDetails_should_return() {
        guard let sut = sut else {
            XCTFail("Não foi possível recuperar 'sut'")
            return
        }
        let expectation = XCTestExpectation(description: "getEventDetails")
        let viewModel = EventDetailsViewModelTest(eventId: eventId, expectation: expectation)
        
        sut.viewModel = viewModel
        sut.viewDidLoad()
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 5)
        
        XCTAssertNotNil(sut.viewModel?.event.value, "O evento não deve ser nulo")
    }
    
    //
    func test_tableView_should_dequeue_6_sections() {
        guard let sut = sut else {
            XCTFail("Não foi possível recuperar 'sut'")
            return
        }
        let expectation = XCTestExpectation(description: "getEventDetails")
        let viewModel = EventDetailsViewModelTest(eventId: eventId, expectation: expectation)
        
        sut.viewModel = viewModel
        sut.viewDidLoad()
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 5)
        
        let numberOfCells = sut.tableView.numberOfSections
        
        XCTAssertEqual(numberOfCells, 6, "Deve conter 6 sections referentes aos detalhes do evento")
    }
    
    //
    func test_tableView_should_dequeue_GenericDetailsTableViewCell() {
        guard let sut = sut else {
            XCTFail("Não foi possível recuperar 'sut'")
            return
        }
        let expectation = XCTestExpectation(description: "getEventDetails")
        let viewModel = EventDetailsViewModelTest(eventId: eventId, expectation: expectation)
        
        sut.viewModel = viewModel
        sut.viewDidLoad()
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 5)
        
        let cell = sut.tableView.cellForRow(
            at: IndexPath(row: 0, section: 0)) as? GenericDetailsTableViewCell
        
        XCTAssertNotNil(cell, "Deve fazer dequeue de uma GenericDetailsTableViewCell")
    }
    
    //
    func test_getEvents_should_fail() {
        guard let sut = sut
            else {
                XCTFail("Não foi possível recuperar 'sut'")
                return
        }
        let expectation = XCTestExpectation(description: "getEventDetails")
        
        let viewModel = EventDetailsViewModelTest(eventId: eventId, expectation: expectation)
        
        sut.viewModel = viewModel
        viewModel.apiShouldFail = true
        
        sut.viewDidLoad()
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 5)
        
        XCTAssertEqual(sut.viewModel?.error.value,
                       ServiceError.badRequest.message,
                       "Deve retornar erro da API")
    }
    
    //
    func test_makeCheckIn_should_success() {
        guard let sut = sut else {
            XCTFail("Não foi possível recuperar 'sut'")
            return
        }
        let expectation = XCTestExpectation(description: "getEventDetails && makeCheckIn")
        expectation.expectedFulfillmentCount = 3
        
        let viewModel = EventDetailsViewModelTest(eventId: eventId, expectation: expectation)
        
        sut.viewModel = viewModel
        sut.viewDidLoad()
        
        let index: Int? = sut.sectionsAndItems.firstIndex { $0.type == .checkIn }
        
        if index != nil {
            let cell = sut.tableView.cellForRow(
                at: IndexPath(row: 0, section: index!)) as? CheckInDetailsTableViewCell
            
            cell?.checkInButton.sendActions(for: .touchUpInside)
        }
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(viewModel.checkInFlag,
                      "Deve estar true para mostrar que foi chamado a função de checkIn")
    }
}
