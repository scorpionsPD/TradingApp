//
//  UtilityTests.swift
//  Trading AppTests
//
//  Created by Pradeep Dahiya on 07/06/2023.
//

import XCTest
@testable import Trading_App

final class UtilityTests: XCTestCase {
    
    func testCalculateDifference_PositiveValues() {
        // Given
        let prev: Float = 10.5
        let current: Float = 15.3
        
        // When
        let difference = Utility.calculateDifference(prev: prev, current: current)
        
        // Then
        XCTAssertEqual(difference, 4.8)
    }
    
    func testCalculateDifference_NegativeValues() {
        // Given
        let prev: Float = -7.8
        let current: Float = -3.2
        
        // When
        let difference = Utility.calculateDifference(prev: prev, current: current)
        
        // Then
        XCTAssertEqual(difference, 4.6)
    }
    
    func testCalculateDifference_ZeroValues() {
        // Given
        let prev: Float = 0.0
        let current: Float = 0.0
        
        // When
        let difference = Utility.calculateDifference(prev: prev, current: current)
        
        // Then
        XCTAssertEqual(difference, 0.0)
    }
    
    func testCalculatePercentage_PositiveDifference() {
        // Given
        let prev: Float = 10.0
        let current: Float = 15.0
        
        // When
        let result = Utility.calculatePercentage(prev: prev, current: current)
        
        // Then
        XCTAssertEqual(result, "+50.00% 5.0")
    }
    
    func testCalculatePercentage_NegativeDifference() {
        // Given
        let prev: Float = 15.0
        let current: Float = 10.0
        
        // When
        let result = Utility.calculatePercentage(prev: prev, current: current)
        
        // Then
        XCTAssertEqual(result, "-33.33% -5.0")
    }
    
    func testCalculatePercentage_ZeroDifference() {
        // Given
        let prev: Float = 10.0
        let current: Float = 10.0
        
        // When
        let result = Utility.calculatePercentage(prev: prev, current: current)
        
        // Then
        XCTAssertEqual(result, "0.00% 0.0")
    }
}

