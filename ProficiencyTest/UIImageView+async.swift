//
//  UIImageView+async.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func setImage(fromPath path: String) {
        
        guard let url = URL(string: path) else {
            print("could not download image")
            return
        }
        
        let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.center = self.center
        self.image = nil
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            activity.removeFromSuperview()
            
            guard error == nil else {
                print("error downloading image")
                return
            }
            
            guard data != nil else {
                print("no image found")
                return
            }
            
            guard let image = UIImage(data: data!) else {
                print("image not valid")
                return
            }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
     
        task.resume()
    }
}
