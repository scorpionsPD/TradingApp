//
//  Modals.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation

struct Company {
    let acronym: String
    let updatedPrice: Double
    // Add more properties as needed
}

// MARK: - CompanyProfile
struct CompanyProfile: Codable {
    let country, currency, estimateCurrency, exchange: String
    let finnhubIndustry, ipo: String
    let logo: String
    let marketCapitalization: Double
    let name, phone: String
    let shareOutstanding: Double
    let ticker: String
    let weburl: String
}

