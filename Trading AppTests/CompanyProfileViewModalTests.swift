//
//  CompanyProfileViewModalTests.swift
//  Trading AppTests
//
//  Created by Pradeep Dahiya on 08/06/2023.
//

import XCTest
@testable import Trading_App

class CompanyProfileViewModalTests: XCTestCase {
    
    var viewModal: CompanyProfileViewModal!
    
    override func setUp() {
        super.setUp()
        viewModal = CompanyProfileViewModal()
    }
    
    override func tearDown() {
        viewModal = nil
        super.tearDown()
    }
    
    func testFetchCompanyDetail_WithInvalidSymbol_ShouldNotFetchData() {
        // Given
        let symbol = "INVALID"
        
        // When
        viewModal.fetchCompanyDetail(symbol: symbol)
        
        // Then
        XCTAssertNil(viewModal.companyDetail, "Company profile data should be nil for an invalid symbol")
    }
    
    func testCompanyName_WithNilCompanyDetail_ShouldReturnEmptyString() {
        // Given
        viewModal.companyDetail = nil
        
        // When
        let companyName = viewModal.companyName
        
        // Then
        XCTAssertEqual(companyName, "", "Company name should be an empty string")
    }
}

