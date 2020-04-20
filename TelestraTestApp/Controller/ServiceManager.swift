//
//  ServiceManager.swift
//  TelestraTestApp
//
//  Created by Sachin Randive on 19/04/20.
//  Copyright © 2020 Sachin Randive. All rights reserved.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    
    func requestForAPIData(completion: @escaping (UserModel?, Error?) -> Void) {
        
        guard let serviceURL = URL.init(string: TTAppConfig().authoriseBaseURL) else { return }
        URLSession.shared.dataTask(with: serviceURL) { (data, response, error) in
            if let err = error {
                completion(nil, err)
                print(err.localizedDescription)
            } else {
                guard let data = data else { return }
                let jsonString = String(decoding: data, as: UTF8.self)
                do {
                    let results = try JSONDecoder().decode(UserModel.self, from: jsonString.data(using: .utf8)!)
                    completion(results, nil)
                } catch {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            }
        }.resume()
    }
}
