//
//  Utility.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 07/06/2023.
//

import Foundation

class Utility {
    // Calculates the difference between two float values
    static func calculateDifference(prev: Float, current: Float) -> Float {
        let difference = ((current - prev) * 100).rounded() / 100
        return (difference * 100).rounded() / 100
    }
    
    // Calculates the percentage difference between two float values and returns a formatted string
    static func calculatePercentage(prev: Float, current: Float) -> String {
        let difference = current - prev
        let percentage = (difference / prev) * 100
        let formattedPercentage = String(format: "%.2f", abs(percentage))
        
        if difference > 0 {
            return "+\(formattedPercentage)% \(difference)"
        } else if difference < 0 {
            return "-\(formattedPercentage)% \(difference)"
        } else {
            return "\(formattedPercentage)% \(difference)"
        }
    }
}

