//
//  MainTableViewCell.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    var symbolLabel: UILabel!
    var priceLabel: UILabel!
    var differenceLabel: UILabel!

    var cellData: CompanyListCellViewModel? {
        didSet {
            guard let data = cellData else {
                return
            }
            symbolLabel.text = data.acronym
            priceLabel.text = data.getPrice()
            differenceLabel.text = data.diffrenceAndPercentage
            differenceLabel.textColor = data.getValueColor()
        }
    }
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCell()
    }

    // MARK: - Private Methods
    
    private func setupCell() {
        // Create and configure symbol label
        symbolLabel = UILabel()
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(symbolLabel)

        // Create and configure price label
        priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(priceLabel)

        // Create and configure difference label
        differenceLabel = UILabel()
        differenceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(differenceLabel)

        // Set up constraints
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            priceLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),

            differenceLabel.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 16),
            differenceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            differenceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}


