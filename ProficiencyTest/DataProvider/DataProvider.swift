//
//  DataProvider.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation

typealias DataProviderCallBack = ((_ results: [DataProviderModel]?, _ error: DataProviderError?) -> Void)

class DataProvider {
    
    enum DataProviderRequestType: String {
        case GET = "GET"
        case POST = "POST"
        case PUT = "PUT"
        case DELETE = "DELETE"
    }
    
    class func makeRequest(type: DataProviderRequestType, endpoint: String, params: [String: Any]? = nil, callback: @escaping (_ json: Any?, _ error: Error?) -> Void) {
        
        if let url = URL(string: Config.API.source + endpoint) {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                // error
                guard error == nil else {
                    callback(nil, error)
                    return
                }
              
                // no data found
                guard let data = data else {
                    callback([], nil)
                    return
                }
                
                // got data
                do {
                    
                    // json contains an array of items
                   let json = try JSONSerialization.jsonObject(with: data, options: [])
                    callback(json, nil)
                }
                catch let error {
                    callback(nil, error)
                }
            }
            
            task.resume()
        }
    }
}

extension DataProvider {
    
    // get items for home screen
    class func getItems(_ callback: @escaping DataProviderCallBack) {
        
        // TODO: move endpoint to config file?
        DataProvider.makeRequest(type: .GET,
                                 endpoint: "/bins/m47pd")
        { (json, error) in

            guard error == nil else {
                callback(nil, DataProviderError(type: .internet, errorDescription: error!.localizedDescription))
                return
            }
            
            // endpoint returns a dictionary of data
            guard let dictionary = json as? [String: Any] else {
                callback(nil, DataProviderError(type: .noValidFormat, errorDescription: "Format returned by API is not expected. Excpected Dictionary."))
                return
            }
            
            // rows is an array of dictionaries
            guard let rows = dictionary["rows"] as? [[String: Any]] else {
                callback(nil, DataProviderError(type: .dataNotFound, errorDescription: "The key 'rows' was not found in JSON file."))
                return
            }
            
            var items = [HomeViewModel]()
            
            for item in rows {
                items.append(HomeViewModel.serialize(from: item))
            }
            
            callback(items, nil)
        }
    }
}



