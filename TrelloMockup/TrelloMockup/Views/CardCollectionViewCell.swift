//
//  CardCollectionViewCell.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    let taskName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    public static let reuseId = "taskCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        taskName.frame = self.contentView.frame
        taskName.center = self.contentView.center
        
        layer.cornerRadius = 6
        
        addSubview(taskName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
