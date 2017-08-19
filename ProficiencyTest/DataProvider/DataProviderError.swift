//
//  DataProviderError.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation

enum DataProviderErrorType: Int {
    case internet = 0
    case noValidFormat = 1
    case dataNotFound = 2
}

struct DataProviderError {
    
    var type: DataProviderErrorType!
    var errorDescription: String?
}
