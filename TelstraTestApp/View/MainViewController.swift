//
//  ViewController.swift
//  TelstraTestApp
//
//  Created by Sachin Randive on 19/04/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    //MARK: - Parameters
    fileprivate let model = DataViewModel()
    let mainTableView = UITableView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // set delegate here
        model.delegate = self
        // refresh view initialization
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        mainTableView.refreshControl = refreshControl
        mainTableView.register(CustomTableCell.self, forCellReuseIdentifier: TTAppConfig.cellIdentifier)
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.backgroundColor = UIColor.themeColor
        self.navigationController?.navigationBar.barTintColor = UIColor.themeColor
        setupTableView()
        model.getResponceFromAPI()
        mainTableView.accessibilityIdentifier = "table--mainTableView"
    }
    //setupTableView here
    func setupTableView() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.themeColor
        view.addSubview(mainTableView)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mainTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainTableView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            guide.bottomAnchor.constraint(equalToSystemSpacingBelow: mainTableView.bottomAnchor, multiplier: 1.0)
        ])
        
    }
    
    // Refresh Activity
    @objc func pullToRefresh(refreshControl: UIRefreshControl) {
        model.listOfArray.removeAll()
        mainTableView.reloadData()
        model.getResponceFromAPI()
        refreshControl.endRefreshing()
    }
}

// MARK: - Delegate and DataSource Methods
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TTAppConfig.cellIdentifier, for: indexPath) as? CustomTableCell else { return CustomTableCell() }
        cell.accessibilityIdentifier = "myCell_\(indexPath.row)"
        let currentLastItem = model.listOfArray[indexPath.row]
        cell.setCellInformation(row: currentLastItem)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.listOfArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Protocal Delegate
extension MainViewController: DataViewModelProtocal {
    func didUpdateData() {
        mainTableView.reloadData()
        self.navigationItem.title = UserDefaults.standard.object(forKey:"title") as? String
    }
    
    func didErrorDisplay() {
        let alert = UIAlertController(title: "Error", message: "Fail to load data from server. Please try after sometime.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}



