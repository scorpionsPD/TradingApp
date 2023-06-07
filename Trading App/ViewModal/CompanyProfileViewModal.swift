//
//  CompanyProfileViewModal.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation
import NetworkManager

class CompanyProfileViewModal {
    
    var needToRefresh:(()->Void)?
    
    var companyDetail: CompanyProfile? {
        didSet{
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
    
    func fetchCompanyDetail(symbol:String) {
        let url = String(describing: "https://finnhub.io/api/v1/stock/profile2?symbol=\(symbol)&token=chvefopr01qrqeng5q7gchvefopr01qrqeng5q80")
        
        NetworkManager.shared.request(urlString: url) { (result: Result<CompanyProfile, NetworkError>) in
            switch result {
            case .success(let data):
                self.companyDetail = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
