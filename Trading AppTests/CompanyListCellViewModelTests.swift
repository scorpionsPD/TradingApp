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
     viewModel.company = Company(acronym: "AAPL", updatedPrice: 150.50)
     
     // When
     let price = viewModel.getPrice()
     
     // Then
     XCTAssertEqual(price, "150.50")
 }
 
// func testGetValueColor_PositiveDifference() {
//     // Given
//     let viewModel = CompanyListCellViewModel()
//     viewModel.previousValue = 100.0
//     viewModel.value = 120.0
//     
//     // When
//     let color = viewModel.getValueColor()
//     
//     // Then
//     XCTAssertEqual(color, .green)
// }
// 
// func testGetValueColor_NegativeDifference() {
//     // Given
//     let viewModel = CompanyListCellViewModel()
//     viewModel.previousValue = 150.0
//     viewModel.value = 120.0
//     
//     // When
//     let color = viewModel.getValueColor()
//     
//     // Then
//     XCTAssertEqual(color, .red)
// }
   
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

