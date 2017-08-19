//
//  DataProviderModelSerializable.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation

protocol DataProviderModelSerializable {
    
    static func serialize(from dictionary: [String: Any]) -> DataProviderModel
    func deserialize() -> [String: Any]?
    
}
