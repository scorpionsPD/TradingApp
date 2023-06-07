//
//  CompanyProfileViewModal.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation

class CompanyProfileViewModal {
    
    var needToRefresh:(()->Void)?
    
    var companyDetail: CompanyProfile?
    
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
    
    func fetchCompanyDetail() {
        // Implement your API request here to fetch the company detail data
        // Update the 'companyDetail' property with the fetched data
    }
}
