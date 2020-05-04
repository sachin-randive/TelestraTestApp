//
//  DataViewModel.swift
//  TelstraTestApp
//
//  Created by Sachin Randive on 04/05/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation
import UIKit

protocol DataViewModelProtocal {
    func didUpdateData()
    func didErrorDisplay()
}

class DataViewModel: NSObject {
    var delegate: DataViewModelProtocal?
    var listOfArray : [Row]  = [Row]()
    
    //MARK: - getResponceFromAPI Methods
    func getResponceFromAPI() {
        ServiceManager.shared.requestForAPIData { (data, error) in
            DispatchQueue.main.async {
                guard let data = data  else {
                    self.delegate?.didErrorDisplay()
                    return
                }
                self.listOfArray = data.rows
                UserDefaults.standard.set(data.title, forKey:"title")
                self.delegate?.didUpdateData()
            }
        }
    }
}
