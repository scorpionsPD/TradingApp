//
//  CompanyListViewModelTests.swift
//  Trading AppTests
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import XCTest
@testable import Trading_App

final class CompanyListViewModelTests: XCTestCase {
    
    var viewModel: CompanyListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = CompanyListViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    /*
    func testNumberOfCompanies() {
        // Initially, there should be no companies
        XCTAssertEqual(viewModel.numberOfCompanies, 0)
        
        // Add a company
        viewModel.fetchCompanyData()
        
        // After adding a company, the count should be 1
        XCTAssertEqual(viewModel.numberOfCompanies, 1)
    }
    
    func testGetCompany() {
        // Initially, there should be no companies
        //XCTAssertNil(viewModel.getCompany(at: 0))

        // Add a company
        viewModel.fetchCompanyData()

        // Fetch the company at index 0
        let companyViewModel = viewModel.getCompany(at: 0)

        // The fetched company view model should not be nil
        XCTAssertNotNil(companyViewModel)
    }
    */
    func testFetchCompanyData() {
        // Initially, there should be no companies
        XCTAssertEqual(viewModel.numberOfCompanies, 0)
        
        // Fetch company data
        viewModel.fetchCompanyData()
        
        // Simulate receiving company data
        let companyData = Company(acronym: "AAPL", updatedPrice: 150.0)
        viewModel.client.didFetchedCompanyData?(companyData)
        
        // After fetching data, there should be one company
        XCTAssertEqual(viewModel.numberOfCompanies, 1)
        
        // Fetch the company view model
        let companyViewModel = viewModel.getCompany(at: 0)
        
        // The fetched company view model should not be nil
        XCTAssertNotNil(companyViewModel)
        
        // The fetched company view model should have the same data as received
        XCTAssertEqual(companyViewModel?.company?.acronym, "AAPL")
        XCTAssertEqual(companyViewModel?.company?.updatedPrice, 150.0)
    }
    
    func testFetchCompanyData_UpdateExistingCompany() {
        // Initially, there should be no companies
        XCTAssertEqual(viewModel.numberOfCompanies, 0)
        
        // Fetch company data
        viewModel.fetchCompanyData()
        
        // Simulate receiving company data
        let companyData1 = Company(acronym: "AAPL", updatedPrice: 150.0)
        viewModel.client.didFetchedCompanyData?(companyData1)
        
        // After fetching data, there should be one company
        XCTAssertEqual(viewModel.numberOfCompanies, 1)
        
        // Fetch the company view model
        let companyViewModel = viewModel.getCompany(at: 0)
        
        // The fetched company view model should not be nil
        XCTAssertNotNil(companyViewModel)
        
        // The fetched company view model should have the same data as received
        XCTAssertEqual(companyViewModel?.company?.acronym, "AAPL")
        XCTAssertEqual(companyViewModel?.company?.updatedPrice, 150.0)
        
        // Simulate receiving updated company data
        let companyData2 = Company(acronym: "AAPL", updatedPrice: 160.0)
        viewModel.client.didFetchedCompanyData?(companyData2)
        
        // The company should be updated with the new data
        XCTAssertEqual(companyViewModel?.company?.acronym, "AAPL")
        XCTAssertEqual(companyViewModel?.company?.updatedPrice, 160.0)
    }
    
    func testFetchCompanyData_AddNewCompany() {
        // Initially, there should be no companies
        XCTAssertEqual(viewModel.numberOfCompanies, 0)
        
        // Fetch company data
        viewModel.fetchCompanyData()
        
        // Simulate receiving company data
        let companyData1 = Company(acronym: "AAPL", updatedPrice: 150.0)
        viewModel.client.didFetchedCompanyData?(companyData1)
        
        // After fetching data, there should be one company
        XCTAssertEqual(viewModel.numberOfCompanies, 1)
        
        // Fetch the company view model
        let companyViewModel = viewModel.getCompany(at: 0)
        
        // The fetched company view model should not be nil
        XCTAssertNotNil(companyViewModel)
        
        // The fetched company view model should have the same data as received
        XCTAssertEqual(companyViewModel?.company?.acronym, "AAPL")
        XCTAssertEqual(companyViewModel?.company?.updatedPrice, 150.0)
        
        // Simulate receiving data for a new company
        let companyData2 = Company(acronym: "AMZN", updatedPrice: 2000.0)
        viewModel.client.didFetchedCompanyData?(companyData2)
        
        // After receiving data for a new company, there should be two companies
        XCTAssertEqual(viewModel.numberOfCompanies, 2)
        
        // Fetch the new company view model
        let newCompanyViewModel = viewModel.getCompany(at: 1)
        
        // The fetched new company view model should not be nil
        XCTAssertNotNil(newCompanyViewModel)
        
        // The fetched new company view model should have the same data as received
        XCTAssertEqual(newCompanyViewModel?.company?.acronym, "AMZN")
        XCTAssertEqual(newCompanyViewModel?.company?.updatedPrice, 2000.0)
    }
}

