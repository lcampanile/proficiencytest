//
//  API.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation

class API {
    
    // get items for home screen
    class func getItems(callback: @escaping (_ results: [HomeViewModel]?, _ error: String?) -> Void) {
        
        DataProvider.getItems { (items, error) in
            
            guard error == nil else {
                
                switch error!.type! {
                case .internet, .dataNotFound:
                    callback(nil, "We were not able to download the list of items. Please try again.")
                case .noValidFormat:
                    callback(nil, "Something went wrong. Please try again later.")
                }

                return
            }
            
            guard let models = items as? [HomeViewModel] else {
                callback(nil, "Something went wrong. Please try again later.")
                return
            }
            
            callback(models, nil)
        }
    }
}
