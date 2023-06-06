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
            guard let data = company else {
                return
            }
            acronym = data.acronym
            price = Float(data.updatedPrice)
            value = Float(data.updatedPrice)
        }
    }
    
    var acronym: String?
    var diffrenceAndPercentage: String?
    var value: Float = 0.0 {
        didSet {
            diffrenceAndPercentage = calculateDifferenceAndPercentage(prev: previousValue, current: value)
        }
        willSet {
            previousValue = value
        }
    }
    
    private var price: Float?
    private var diffrence: Float = 0
    private var previousValue: Float = 0
    
    // MARK: - Public Methods
    
    func getPrice() -> String {
        return String(format: "%.2f", price ?? 0)
    }
    
    func getValueColor() -> UIColor {
        return diffrence.sign == .minus ? .red : .green
    }
    
    // MARK: - Initialization
    
    init(company: Company? = nil) {
        self.company = company
    }
    
    // MARK: - Private Methods
    
    private func calculateDifferenceAndPercentage(prev: Float, current: Float) -> String {
        diffrence = ((current - prev) * 100).rounded() / 100
        let diffPercentage = abs((((diffrence * 100) / value) * 100).rounded() / 100)
        return "(\(diffPercentage)%) \(diffrence)"
    }
}

