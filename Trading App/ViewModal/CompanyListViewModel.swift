//
//  CompanyListViewModel.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation

class CompanyListViewModel {
    
    var needTorefresh:(()->Void)?
    
    private var companies: [Company]? {
        didSet {
            guard let _ = companies else {
                return
            }
            needTorefresh?()
        }
    }
    
    private var client: FinnhubWebSocketClient!
    
    var numberOfCompanies: Int {
        return companies?.count ?? 0
    }
    
    func getCompany(at index: Int) -> Company? {
        return companies?[index]
    }
    
    func fetchCompanyData() {
        client = FinnhubWebSocketClient()
        client.connect()
        client.didFetchedCompanyData = { data in
            self.companies = data
        }
    }
}
