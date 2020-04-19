//
//  ViewController.swift
//  TelestraTestApp
//
//  Created by Sachin Randive on 19/04/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

     //MARK: - Parameters
        
        let cellIndentifier = "CustomCell"
        var listOfArray : [Row]  = [Row]()

        //MARK: - View Lifecycle
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
            tableView.refreshControl = refreshControl
            tableView.register(CustomTableCell.self, forCellReuseIdentifier: cellIndentifier)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.backgroundColor = UIColor.themeColor
            self.tableView.tableFooterView = UIView()
            self.navigationController?.navigationBar.barTintColor = UIColor.themeColor
        }
        override func viewWillAppear(_ animated: Bool) {
            
            super.viewWillAppear(animated)
            getResponceFromAPI()
        }
        
        
        //MARK: - Private Methods
        
        func getResponceFromAPI() {
            
            TTActivityIndicatorView.show()
            ServiceManager.shared.requestForAPIData { (data, error) in
                DispatchQueue.main.async {
                    TTActivityIndicatorView.dismiss()
                    if data != nil {
                        self.navigationItem.title = data?.title
                        self.listOfArray = data!.rows.filter{ $0.title != nil }
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Error", message: "Fail to load data from server. Please try after sometime.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
        
        @objc func pullToRefresh(refreshControl: UIRefreshControl) {
            
            listOfArray.removeAll()
            tableView.reloadData()
            getResponceFromAPI()
            refreshControl.endRefreshing()
        }
        
        //MARK: - Delegate and DataSource Methods
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? CustomTableCell else { return CustomTableCell() }
            let currentLastItem = listOfArray[indexPath.row]
            cell.setCellInformation(row: currentLastItem)
            cell.selectionStyle = .none
            return cell
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return listOfArray.count
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return UITableView.automaticDimension
        }
    }




