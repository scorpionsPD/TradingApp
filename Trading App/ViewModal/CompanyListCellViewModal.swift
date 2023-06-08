//
//  CompanyListCellViewModal.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import Foundation
import UIKit

class CompanyListCellViewModel {
    
    // MARK: - Properties
    
    var company: Company? {
        didSet {
            value = Float(company?.updatedPrice ?? 0)
        }
    }
    
    var acronym: String? {
        return company?.acronym
    }
    
    var diffrenceAndPercentage: String?
    
    var value: Float = 0.0 {
        didSet {
            diffrenceAndPercentage = Utility.calculatePercentage(prev: previousValue, current: value)
        }
        willSet {
            previousValue = value
        }
    }
    
    private var previousValue: Float = 0
    
    // MARK: - Public Methods
    
    func getPrice() -> String {
        return String(format: "%.2f", company?.updatedPrice ?? 0)
    }
    
    func getValueColor() -> UIColor {
        let diff = Utility.calculateDifference(prev: previousValue, current: value)
        return diff.sign == .minus ? .red : .green
    }
    
    // MARK: - Initialization
    
    init(company: Company? = nil) {
        self.company = company
    }
}


