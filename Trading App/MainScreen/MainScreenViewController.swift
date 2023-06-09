//
//  MainScreenViewController.swift
//  Trading App
//
//  Created by Pradeep Dahiya on 06/06/2023.
//

import UIKit

class MainScreenViewController: UIViewController {
    var tableView: UITableView!
    private var viewModel: CompanyListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trading App"
        // Initialize the WebSocket and UITableView
        initializeWebSocket()
        initializeTableView()
    }
    
    // MARK: - View Setup
    
    private func initializeTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register UITableViewCell class for reuse
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Add the UITableView to the view hierarchy
        view.addSubview(tableView)
    }
    
    private func initializeWebSocket() {
        viewModel = CompanyListViewModel()
        
        // Fetch company data and update the table view
        viewModel.fetchCompanyData()
        viewModel.needToRefresh = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return viewModel.numberOfCompanies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        
        // Get the company for the current row
        let company = viewModel.getCompany(at: indexPath.row)
        
        // Configure the cell
        cell.cellData = company
        
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        if let company = viewModel.getCompany(at: indexPath.row), let acronym = company.acronym {
            let details = CompanyProfileViewController(companySymbol: acronym)
            self.navigationController?.pushViewController(details, animated: true)
        }
    }
}

