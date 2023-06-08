//
//  CompanyProfileViewModal.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation
import NetworkManager

class CompanyProfileViewModal {
    
    // MARK: - Properties
    
    var needToRefresh: (() -> Void)?
    
    var companyDetail: CompanyProfile? {
        didSet {
            needToRefresh?()
        }
    }
    
    var companyName: String {
        return companyDetail?.name ?? ""
    }
    
    var companyAcronym: String {
        return companyDetail?.ticker ?? ""
    }
    
    var companyLogo: String? {
        return companyDetail?.logo
    }
    
    var industrySector: String {
        return companyDetail?.finnhubIndustry ?? ""
    }
    
    // MARK: - Public Methods
    
    func fetchCompanyDetail(symbol: String) {
        guard let token = ProcessInfo.processInfo.environment["FINNHUB_API_KEY"] else {
            print("FINNHUB_API_KEY environment variable is missing")
            return
        }
        
        // Construct the URL for the API request
        var urlComponents = URLComponents(string: "https://finnhub.io/api/v1/stock/profile2")
        urlComponents?.queryItems = [
            URLQueryItem(name: "symbol", value: symbol),
            URLQueryItem(name: "token", value: token)
        ]
        
        guard let url = urlComponents?.url else {
            print("Invalid URL")
            return
        }
        
        // Send a network request to fetch the company profile data
        NetworkManager.shared.request(urlString: url.absoluteString) { (result: Result<CompanyProfile, NetworkError>) in
            switch result {
            case .success(let data):
                self.companyDetail = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
