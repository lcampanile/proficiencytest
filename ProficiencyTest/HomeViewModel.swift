//
//  HomeViewModel.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation

class HomeViewModel: DataProviderModel {

    /* Typically JSON item looks like this:
    
     {
        "title": "this is a title",
        "description":"this is a description",
        "imageHref":"https://dummyimage.com/verticalbanner"
     }
 
    */
    
    var title: String?
    var itemDescription: String?
    var imageHref: String?

    // data provider serializable protocol
    override class func serialize(from dictionary: [String : Any]) -> HomeViewModel {
        
        let model = HomeViewModel()
        
        // title
        if let title = dictionary["title"] as? String {
            model.title = title
        }
        
        // description
        if let itemDescription = dictionary["description"] as? String {
            model.itemDescription = itemDescription
        }
        
        // imageHref
        if let imageHref = dictionary["imageHref"] as? String {
            model.imageHref = imageHref
        }
        
        return model
    }
}
