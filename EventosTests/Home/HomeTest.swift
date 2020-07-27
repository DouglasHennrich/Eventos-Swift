//
//  HomeTest.swift
//  EventosTests
//
//  Created by Douglas Hennrich on 27/07/20.
//  Copyright © 2020 Douglas Hennrich. All rights reserved.
//

import XCTest
@testable import Eventos

class HomeTest: XCTestCase {

    var sut: HomeViewController?
    
    override func setUp() {
        super.setUp()
        sut = HomeViewController.instantiateFromStoryboard(named: "Home")
    }
    
    //
    func test_getEvents_should_have_three_events() {
        guard let sut = sut
            else {
                XCTFail("Não foi possível recuperar 'sut'")
                return
        }
        let expetation = XCTestExpectation(description: "getEvents")
        let viewModel = HomeViewModelTest(expetation: expetation)
        
        sut.viewModel = viewModel
        
        sut.viewDidLoad()
        sut.viewModel?.getEvents(reload: false)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expetation], timeout: 5)
        
        XCTAssertEqual(sut.viewModel?.events.value.count, 3, "Deve conter 3 eventos")
    }
    
    //
    func test_getEvents_should_fail() {
        guard let sut = sut
            else {
                XCTFail("Não foi possível recuperar 'sut'")
                return
        }
        let expetation = XCTestExpectation(description: "getEvents")
        let viewModel = HomeViewModelTest(expetation: expetation)
        
        sut.viewModel = viewModel
        viewModel.apiShouldFail = true
        
        sut.viewDidLoad()
        sut.viewModel?.getEvents(reload: false)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expetation], timeout: 5)
        
        XCTAssertEqual(sut.viewModel?.error.value,
                       ServiceError.badRequest.message,
                       "Deve retornar erro da API")
    }
    
    //
    func test_tableView_should_dequeue_EventTableViewCell() {
        guard let sut = sut
            else {
                XCTFail("Não foi possível recuperar 'sut'")
                return
        }
        let expetation = XCTestExpectation(description: "getEvents")
        let viewModel = HomeViewModelTest(expetation: expetation)
        
        sut.viewModel = viewModel
        
        sut.viewDidLoad()
        sut.viewModel?.getEvents(reload: false)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expetation], timeout: 5)
        
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? EventTableViewCell
        
        XCTAssertNotNil(cell, "Deve ser uma EventTableViewCell")
    }
    
    //
    func test_should_get_a_single_event() {
        guard let sut = sut
            else {
                XCTFail("Não foi possível recuperar 'sut'")
                return
        }
        let expetation = XCTestExpectation(description: "getEvents")
        let viewModel = HomeViewModelTest(expetation: expetation)
        
        sut.viewModel = viewModel
        
        sut.viewDidLoad()
        sut.viewModel?.getEvents(reload: false)
        
        let waiter = XCTWaiter()
        waiter.wait(for: [expetation], timeout: 5)
        
        let event = sut.viewModel?.getEventAt(section: 0, row: 0)
        
        XCTAssertNotNil(event, "Deve existir o evento")
    }
}
