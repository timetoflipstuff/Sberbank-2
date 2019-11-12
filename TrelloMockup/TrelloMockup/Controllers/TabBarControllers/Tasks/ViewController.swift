//
//  ViewController.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var columns: [Column] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .orange
        collectionView.decelerationRate = .fast
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddColumn))
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FirstCollectionViewCell.reuseId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirstCollectionViewCell.reuseId, for: indexPath) as! FirstCollectionViewCell
        cell.tasksController.tasks[0].name = columns[indexPath.row].name
        return cell
    }
    
    @objc private func handleAddColumn() {
        let controller = AddColumnVC()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ViewController: AddColumnVCDelegate {
    
    func didAddColumn(name: String) {
        columns.append(Column(name: name))
        collectionView.reloadData()
        //tableView.insertRows(at: IndexPath.row, with: UITableView.RowAnimation) //good when you just need to add a couple of rows
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: 600)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 20, bottom: 0, right: 20)
    }
}

class Column {
    var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
