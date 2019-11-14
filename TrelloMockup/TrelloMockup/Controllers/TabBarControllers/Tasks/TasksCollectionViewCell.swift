//
//  TasksCollectionViewCell.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {
    
    public let nameLabel = UILabel()
    public static let reuseId = "taskCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        
        nameLabel.frame = self.contentView.frame
        nameLabel.center = self.contentView.center
        nameLabel.center.x += 15
        
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
