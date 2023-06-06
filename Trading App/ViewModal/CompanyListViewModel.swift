//
//  CompanyListViewModel.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation

class CompanyListViewModel {
    
    // Callback closure to notify when refresh is needed
    var needToRefresh: (() -> Void)?
    
    // Array to store the view models for companies
    private var companies: [CompanyListCellViewModel] = []
    
    // WebSocket client for fetching company data
    var client: FinnhubWebSocketClient!
    
    // Computed property to get the number of companies
    var numberOfCompanies: Int {
        return companies.count
    }
    
    // Get the view model for a company at a specific index
    func getCompany(at index: Int) -> CompanyListCellViewModel? {
        return companies[index]
    }
    
    // Fetch company data from the WebSocket client
    func fetchCompanyData() {
        client = FinnhubWebSocketClient()
        client.connect()
        
        // Callback when company data is fetched
        client.didFetchedCompanyData = { [weak self] data in
            guard let self = self else { return }
            
            // Create a new view model for the fetched company data
            let cellViewModel = CompanyListCellViewModel(company: data)
            
            // Check if the company already exists in the array
            if let index = self.companies.firstIndex(where: { $0.company?.acronym == data.acronym }) {
                // Update the existing view model with the new data
                self.companies[index].company = data
            } else {
                // Add the new view model to the array
                self.companies.append(cellViewModel)
            }
            
            // Notify the callback for refreshing the UI
            self.needToRefresh?()
        }
    }
}

