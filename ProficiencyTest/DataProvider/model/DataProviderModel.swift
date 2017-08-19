//
//  DataProviderModel.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation

// data provider models are models that are being serialized from an API request
class DataProviderModel: DataProviderModelSerializable {
    
    class func serialize(from dictionary: [String : Any]) -> DataProviderModel {
        return DataProviderModel()
    }
    
    func deserialize() -> [String : Any]? {
        return [:]
    }
}
