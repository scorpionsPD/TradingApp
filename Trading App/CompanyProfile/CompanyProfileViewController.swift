//
//  CompanyProfileViewController.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import UIKit

class CompanyProfileViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tickerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let industryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weburlButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Visit Website", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var viewModel = CompanyProfileViewModal()
    
    var companySymbol: String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        viewModel.fetchCompanyDetail(symbol: companySymbol)
        viewModel.needToRefresh = { [weak self] in
            guard let self = self else { return }
            self.configureUI()
        }
    }
    
    init(companySymbol: String) {
        self.companySymbol = companySymbol
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(logoImageView)
        view.addSubview(nameLabel)
        view.addSubview(tickerLabel)
        view.addSubview(industryLabel)
        view.addSubview(marketCapLabel)
        view.addSubview(weburlButton)
        
        // Add target action to the weburlButton
        weburlButton.addTarget(self, action: #selector(visitWebsite), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tickerLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            tickerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tickerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            industryLabel.topAnchor.constraint(equalTo: tickerLabel.bottomAnchor, constant: 10),
            industryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            industryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            marketCapLabel.topAnchor.constraint(equalTo: industryLabel.bottomAnchor, constant: 10),
            marketCapLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            marketCapLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            weburlButton.topAnchor.constraint(equalTo: marketCapLabel.bottomAnchor, constant: 20),
            weburlButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func visitWebsite() {
        guard let companyProfile = viewModel.companyDetail, let url = URL(string: companyProfile.weburl) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    private func configureUI() {
        guard let companyProfile = viewModel.companyDetail else {
            return
        }
        DispatchQueue.main.async {
            self.nameLabel.text = companyProfile.name
            self.tickerLabel.text = companyProfile.ticker
            self.industryLabel.text = companyProfile.finnhubIndustry
            self.marketCapLabel.text = "Market Cap: \(companyProfile.marketCapitalization)"
            
            if let logoURL = URL(string: companyProfile.logo) {
                DispatchQueue.global().async { [weak self] in
                    if let imageData = try? Data(contentsOf: logoURL) {
                        let image = UIImage(data: imageData)
                        DispatchQueue.main.async {
                            self?.logoImageView.image = image
                        }
                    }
                }
            }
        }
    }
}
