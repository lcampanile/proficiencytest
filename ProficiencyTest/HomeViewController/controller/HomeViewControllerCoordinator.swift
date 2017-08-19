//
//  HomeViewController+UITableViewDelegate.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewControllerCoordinatorDelegate {
    func didSelectItem(at index: NSIndexPath)
}

class HomeViewControllerCoordinator: NSObject {
    
    // data model
    fileprivate var items = [HomeViewModel]()
    
    // uitableview
    private let tableView: UITableView!
    
    // delegate/subscriber to tableview events
    var delegate: HomeViewControllerCoordinatorDelegate?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        configure()
    }
    
    private func configure() {
        
        // registering custom uitableviewcell
        self.tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: HomeViewTableViewCell.cellIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // reload data method
    func reload(with items: [HomeViewModel]) {
        self.items = items
        tableView.reloadData()
    }
}

extension HomeViewControllerCoordinator: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let homeViewCell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.cellIdentifier) as? HomeViewTableViewCell {
            
            let currentItem = items[indexPath.row]
            homeViewCell.titleLabel?.text = currentItem.title ?? "No title"
            homeViewCell.descriptionLabel?.text = currentItem.itemDescription ?? "Empty description."
            homeViewCell.cellImageView?.setImage(fromPath: currentItem.imageHref ?? "")
            return homeViewCell
        }
        
        return UITableViewCell()
    }
}


