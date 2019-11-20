//
//  ListCollectionViewCell.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit


class ListCollectionViewCell: UICollectionViewCell {
    
    public static let reuseId = "columnCell"
    
    lazy var cardsController = CardsCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    
    var listId : String = ""
    var delegate: CardsCollectionViewControllerDelegate?
    
    var cards: [String]? = [] {
        didSet {
            addSubview(cardsController.view)
            cardsController.view.translatesAutoresizingMaskIntoConstraints = false
            cardsController.view.topAnchor.constraint(equalTo: listName.bottomAnchor, constant: 0).isActive = true
            cardsController.view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
            cardsController.view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
            cardsController.view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
            
            cardsController.view.heightAnchor.constraint(greaterThanOrEqualToConstant: 100).isActive = true
            cardsController.cards = cards ?? []
            
            cardsController.listId = listId
            cardsController.delegate = delegate
        }
    }
    
    let listName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.backgroundColor = .lighterGray
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubview(listName)
        listName.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        listName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        listName.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        listName.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
