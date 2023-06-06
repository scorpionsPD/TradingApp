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
        
        // Do any additional setup after loading the view.
        
        initializeWebSocket()
        initializeTableView()
    }
    
    // Initialize the UITableView
    private func initializeTableView() {
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register UITableViewCell class for reuse
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Add the UITableView to the view hierarchy
        view.addSubview(tableView)
        
    }
    
    // Initialize the WebSocket
    private func initializeWebSocket() {
        viewModel = CompanyListViewModel()
        viewModel.fetchCompanyData()
        viewModel.needToRefresh = {
            self.tableView.reloadData()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension MainScreenViewController: UITableViewDelegate,UITableViewDataSource {
    
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
//        cell.symbolLabel.text = "AAPL"
//        cell.priceLabel.text = "$178.74"
//        cell.differenceLabel.text = "+2.34 (1.32%)"
        
        cell.cellData = company
        
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        print("Selected row \(indexPath.row + 1)")
    }
}
