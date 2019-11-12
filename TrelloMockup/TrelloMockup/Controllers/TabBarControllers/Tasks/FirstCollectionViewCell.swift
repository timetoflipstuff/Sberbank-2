//
//  FirstCollectionViewCell.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    
    public static let reuseId = "columnCell"
    
    let tasksController = TasksViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(tasksController.view)
        tasksController.view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
