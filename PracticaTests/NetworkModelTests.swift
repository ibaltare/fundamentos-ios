//
//  NetworkModelTests.swift
//  PracticaTests
//
//  Created by Nicolas on 21/07/22.
//

import XCTest
@testable import Practica

class NetworkModelTests: XCTestCase {

    private var sut: NetworkModel!
    
    override func setUpWithError() throws {
        sut = NetworkModel.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testLoginSuccess() throws {
        let expectation = expectation(description: "Login Succes")
        var retrievedMessage: String?
        
        sut.login(user: "ib4ltazar@gmail.com", password: "3456789") { response in
            retrievedMessage = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 8)
        XCTAssertNil(retrievedMessage)
    }
    
    func testLoginFail() throws {
        let expectation = expectation(description: "Login Fail")
        var retrievedMessage: String?
        
        sut.login(user: "ibaltazar", password: "3456789") { response in
            retrievedMessage = response
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 8)
        XCTAssertNotNil(retrievedMessage)
    }
    
    func testGetHeroesSuccess() throws {
        var heroes: [Hero] = []
        let expectation = expectation(description: "Succes")
        
        sut.login(user: "ib4ltazar@gmail.com", password: "3456789") { [weak self] _ in
            self?.sut.getHeroes { heroesResult, _ in
                heroes = heroesResult
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 8)
        
        XCTAssertGreaterThan(heroes.count, 0, "Available Heroes")
    }
    
    func testGetTransformationsSuccess() throws {
        var transformations: [Transformation] = []
        let expectation = expectation(description: "Succes")
        
        sut.login(user: "ib4ltazar@gmail.com", password: "3456789") { [weak self] _ in
            self?.sut.getTransformations(id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94", completion: { transformationsResult, _ in
                transformations = transformationsResult
                expectation.fulfill()
            })
        }

        waitForExpectations(timeout: 8)
        
        XCTAssertGreaterThan(transformations.count, 0, "Available Transformations")
    }
    
    func testGetTokenSuccess() throws {
        let expectation = expectation(description: "Succes Token")
        
        sut.login(user: "ib4ltazar@gmail.com", password: "3456789") { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 8)
        
        XCTAssertNotEqual(sut.getToken(), "", "Available Token")
    }
    
    func testGetTokenEmpty() throws {
        let expectation = expectation(description: "Succes Token")
        
        sut.login(user: "ibaltazar", password: "3456789") { _ in
            expectation.fulfill()
        }

        waitForExpectations(timeout: 8)
        
        XCTAssertEqual(sut.getToken(), "", "Empty Token")
    }
    
    func testGetTransformationsEmpty() throws {
        var transformations: [Transformation] = []
        let expectation = expectation(description: "Succes")
        
        sut.login(user: "ib4ltazar@gmail.com", password: "3456789") { [weak self] _ in
            self?.sut.getTransformations(id: "14BB8E98-6586-4EA7-B4D7-35D6A63F5AA3", completion: { transformationsResult, _ in
                transformations = transformationsResult
                expectation.fulfill()
            })
        }

        waitForExpectations(timeout: 8)
        
        XCTAssertEqual(transformations.count, 0, "Empty Transformations")
    }

}
