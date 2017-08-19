//
//  HomeViewTableViewCell.swift
//  ProficiencyTest
//
//  Created by Loris Campanile on 19/08/2017.
//  Copyright © 2017 Loris Campanile. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "homeViewCell"
    
    // labels on cell
    var titleLabel: UILabel?
    var descriptionLabel: UILabel?
    var cellImageView: UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureLayout()
    }
    
    private func configureLayout() {
        
        self.selectionStyle = .none
        
        // titleLabel
        self.titleLabel = UILabel()
        self.titleLabel!.font = Config.Font.titleFont
        self.titleLabel!.textColor = Config.Colors.blue
        self.titleLabel!.numberOfLines = 0
        self.contentView.addSubview(self.titleLabel!)
        
        // description label
        self.descriptionLabel = UILabel()
        self.descriptionLabel!.font = Config.Font.bodyFont
        self.descriptionLabel!.textColor = Config.Colors.black
        self.descriptionLabel!.numberOfLines = 0
        self.contentView.addSubview(self.descriptionLabel!)
        
        // cell image view
        self.cellImageView = UIImageView()
        self.cellImageView?.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.cellImageView!)
        
        // set up auto layout
        self.titleLabel!.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.contentView.snp.leading).offset(5.0)
            maker.top.equalTo(self.contentView.snp.top).offset(20.0)
            maker.trailing.equalTo(self.contentView.snp.trailing).offset(5.0)
            maker.bottom.equalTo(self.descriptionLabel!.snp.top).offset(-20.0)
        }
        
        self.cellImageView!.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(self.titleLabel!.snp.trailing)
            maker.width.equalTo(self.contentView.snp.width).multipliedBy(1.0/3.0) // 1 third of the size of the cell
            maker.height.equalTo(50.0)
            maker.centerY.equalTo(self.contentView.snp.centerY)
        }
        
        self.descriptionLabel!.snp.makeConstraints { (maker) in
            maker.leading.equalTo(self.titleLabel!.snp.leading)
            maker.trailing.equalTo(self.cellImageView!.snp.leading).offset(10.0)
            maker.bottom.equalTo(self.contentView.snp.bottom).offset(-20.0)
        }
    }
}
