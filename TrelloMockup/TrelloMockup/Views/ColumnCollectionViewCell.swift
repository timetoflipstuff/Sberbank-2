//
//  ColumnCollectionViewCell.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

//protocol AddNewTaskViewControllerDelegate {
//    func didAddTask(task: String)
//}

class ColumnCollectionViewCell: UICollectionViewCell {
    
    public static let reuseId = "columnCell"
    var delegate: AddTaskDelegate?
    
    var columnName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .orange
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 30)
        return label
    }()
    
    var tasksController = TasksCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    override init(frame: CGRect) {
        //let tasksController = TasksCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        super.init(frame: frame)
        layer.cornerRadius = 16
        layer.masksToBounds = true

        addSubview(columnName)
        columnName.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        columnName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        columnName.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        columnName.heightAnchor.constraint(equalToConstant: 80).isActive = true

        addSubview(tasksController.view)
        tasksController.view.translatesAutoresizingMaskIntoConstraints = false
        tasksController.view.topAnchor.constraint(equalTo: columnName.bottomAnchor, constant: 0).isActive = true
        tasksController.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        tasksController.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        tasksController.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.columnName.text = ""
        self.tasksController.tasks.removeAll()
        self.tasksController.collectionView.reloadData()
    }
    
}
