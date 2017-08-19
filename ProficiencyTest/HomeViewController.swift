//
//  ViewController.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    // controller coordinator
    fileprivate var coordinator: HomeViewControllerCoordinator!

    // tableview
    fileprivate var tableView: UITableView!
    private var labelEmpty: UILabel?
    
    // uiviewcontroller state 
    fileprivate var state: UIViewControllerState = .normal {
        didSet {
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
            
            if self.labelEmpty != nil {
                self.labelEmpty?.removeFromSuperview()
                self.labelEmpty = nil
            }
            
            switch state {
            case .normal:
                
                self.tableView.isHidden = false
                
            case .loading:
                
                let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
                activity.startAnimating()
                
                // if you would like to hide table view while loading, uncomment
               // self.tableView.isHidden = true
                
            case .empty:
                
                self.tableView.isHidden = true
                
                self.labelEmpty = UILabel()
                self.labelEmpty!.textAlignment = .center
                self.labelEmpty!.text = "There are no items to show."
                self.labelEmpty!.font = UIFont(name: "Helvetica-Neue", size: 15.0)
                self.labelEmpty!.textColor = UIColor.black
                self.view.addSubview(self.labelEmpty!)
                
                self.labelEmpty!.snp.makeConstraints({ (maker) in
                    maker.center.equalTo(self.view.snp.center)
                    maker.leading.equalTo(self.view.snp.leading)
                    maker.trailing.equalTo(self.view.snp.trailing)
                    maker.height.equalTo(50.0)
                })
            }
        }
    }
}

// life cycle
extension HomeViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.backgroundColor = UIColor.white
        self.title = "Cool App"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
        
        configureTableView()
        self.coordinator = HomeViewControllerCoordinator(tableView: self.tableView)
        refreshData()
    }
}

// setup 
extension HomeViewController {
    
    fileprivate func configureTableView() {
        
        self.tableView = UITableView(frame: self.view.bounds)
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
        self.view.addSubview(self.tableView)
    }
}

// networking
extension HomeViewController {
    
    @objc fileprivate func refreshData() {
        
        self.state = .loading
        
        API.getItems { (items, error) in
            
            // perform in main thread
            DispatchQueue.main.async {
                
                guard error == nil, items != nil else {
                    self.state = .empty
                    
                    let alertController = UIAlertController(title: "Error", message: error!, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                guard items!.count > 0 else {
                    self.state = .empty
                    return
                }
                
                self.state = .normal
                self.coordinator.reload(with: items!)
            }
        }
    }
}
