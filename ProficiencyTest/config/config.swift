//
//  config.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation
import UIKit


struct Config {
    
    struct API {
        static let source = "https://api.myjson.com"
        static let acceptabledTimeoutPolicy = 10.0
    }
    
    struct Font {
        static let titleFont = UIFont.systemFont(ofSize: UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.title1).pointSize)
        static let bodyFont = UIFont.systemFont(ofSize: UIFontDescriptor.preferredFontDescriptor(withTextStyle: UIFontTextStyle.body).pointSize)
    }
    
    struct Colors {
        static let blue = UIColor(red: 52.0/255.0, green: 152.0/255.0, blue: 219.0/255.0, alpha: 1.0)
        static let black = UIColor(red: 52.0/255.0, green: 73.0/255.0, blue: 94.0/255.0, alpha: 1.0)
    }
}
