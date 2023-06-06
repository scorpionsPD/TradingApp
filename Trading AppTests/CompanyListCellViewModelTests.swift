//
//  CompanyListCellViewModelTests.swift
//  Trading AppTests
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import XCTest
@testable import Trading_App

class CompanyListCellViewModelTests: XCTestCase {
    
    func testGetPrice() {
        // Given
        let viewModel = CompanyListCellViewModel()
        viewModel.price = 123.456
        
        // When
        let result = viewModel.getPrice()
        
        // Then
        XCTAssertEqual(result, "123.46")
    }
    
    func testValueColor_WhenDifferenceIsNegative() {
        // Given
        let viewModel = CompanyListCellViewModel()
        viewModel.diffrence = -5.0
        
        // When
        let result = viewModel.getValueColor()
        
        // Then
        XCTAssertEqual(result, .red)
    }
    
    func testValueColor_WhenDifferenceIsPositive() {
        // Given
        let viewModel = CompanyListCellViewModel()
        viewModel.diffrence = 5.0
        
        // When
        let result = viewModel.getValueColor()
        
        // Then
        XCTAssertEqual(result, .green)
    }
    
    func testCalculateDifferenceAndPercentage() {
        // Given
        let viewModel = CompanyListCellViewModel()
        viewModel.value = 100.0
        viewModel.previousValue = 80.0
        
        // When
        let result = viewModel.calculateDifferenceAndPercentage(prev: viewModel.previousValue, current: viewModel.value)
        
        // Then
        XCTAssertEqual(result, "(25.0%) 20.0")
    }
    
    func testTradesDidSet() {
        // Given
        let viewModel = CompanyListCellViewModel()
        let company = Company(acronym: "AAPL", updatedPrice: 200.0)
        
        // When
        viewModel.company = company
        
        // Then
        XCTAssertEqual(viewModel.acronym, "AAPL")
        //XCTAssertEqual(viewModel.price, 200.0)
        XCTAssertEqual(viewModel.value, 200.0)
    }
}

