//
//  TasksViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class TasksCollectionViewController: UICollectionViewController {
    
    var tasks: [Task] = []
    
    var cards: [Card] = []
    
    var counter = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .orange
        
        collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: TasksCollectionViewCell.reuseId)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TasksCollectionViewCell.reuseId, for: indexPath) as! TasksCollectionViewCell
        cell.backgroundColor = .white
        return cell
    }
    
}

extension TasksCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
