//
//  CarCustomiserTests.swift
//  CarCustomiserTests
//
//  Created by Guo, Dylan (Coll) on 12/01/2023.
//

import XCTest
@testable import CarCustomiser

class CarCustomiserTests: XCTestCase {

    func testNewCarGivesMeACarWithAllAttributesSet() {
        //arrange
        //act
        let car = Car(make:"Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        //assert
        XCTAssertEqual(car.make, "Mazda")
        XCTAssertEqual(car.model, "MX-5")
        XCTAssertEqual(car.topSpeed, 125)
        XCTAssertEqual(car.acceleration, 7.7)
        XCTAssertEqual(car.handling, 5)
    }
    
    func testDisplayStatsMethod() {
        let car = Car(make:"Mazda", model: "MX-5", topSpeed: 125, acceleration: 7.7, handling: 5)
        let expectedResult = """
Make: Mazda
Model: MX-5
Top Speed: 125mph
Acceleration (0-60): 7.7s
Handling: 5
"""
        let result = car.displayStats()
        XCTAssertEqual(expectedResult, result)
    }
}
 
