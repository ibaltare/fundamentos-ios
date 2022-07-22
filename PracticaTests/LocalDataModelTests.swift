//
//  LocalDataModel.swift
//  PracticaTests
//
//  Created by Nicolas on 21/07/22.
//

import XCTest
@testable import Practica

class LocalDataModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        LocalDataModel.deleteEmail()
    }

    func testSaveEmail() throws {
        //Given
        let storedEmail = "test@test.net"
        //When
        LocalDataModel.save(email: storedEmail)
        //Then
        let retreivedEmail = LocalDataModel.getEmail()
        XCTAssertEqual(retreivedEmail, storedEmail, "email doesn't match")
    }
    
    func testGetEmailNotSaved() throws {
        //Then
        let retreivedEmail = LocalDataModel.getEmail()
        XCTAssertNil(retreivedEmail,"Email not Saved")
    }
    
    func testDeleteEmail() throws {
        //Given
        let storedEmail = "testdelete@test.net"
        LocalDataModel.save(email: storedEmail)
        //When
        LocalDataModel.deleteEmail()
        //Then
        let retreivedEmail = LocalDataModel.getEmail()
        XCTAssertNil(retreivedEmail,"Email not Saved")
    }

}

