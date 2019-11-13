//
//  TasksViewController.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class TasksViewController: UICollectionViewController {
    
    var columns: [Column] = []
    
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        
        
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddColumn))
        
        collectionView.register(ColumnCollectionViewCell.self, forCellWithReuseIdentifier: ColumnCollectionViewCell.reuseId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColumnCollectionViewCell.reuseId, for: indexPath) as! ColumnCollectionViewCell
        cell.columnName.text = "     \(columns[indexPath.row].name)"
        return cell
    }
    
    
    @objc private func handleAddColumn() {
        
        let alert = UIAlertController(title: "Введите название колонки", message: "", preferredStyle: .alert)

        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Назад", style: .default, handler: { [] (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let columnName = textField?.text
            
            self.columns.append(Column(name: columnName ?? ""))
            self.collectionView.reloadData()
            
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}



extension TasksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: view.frame.height * 2 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 0)
    }
}


