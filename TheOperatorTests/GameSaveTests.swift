//
//  GameSaveTests.swift
//  menuTest
//
//  Created by Daniel Robertson on 21/04/2016.
//  Copyright © 2016 Daniel Robertson. All rights reserved.
//

import XCTest
@testable import TheOperator

class GameSaveTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    
    func testModelCreation() {
        let gameSave = GameSave(name: "test", progress: 1)
        XCTAssertNotNil(gameSave)
        XCTAssertEqual(gameSave.name, "test")
        XCTAssertEqual(gameSave.progress, 1)
    }

}
