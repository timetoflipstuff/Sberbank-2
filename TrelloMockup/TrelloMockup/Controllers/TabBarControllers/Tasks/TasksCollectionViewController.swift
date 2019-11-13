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
        
        if indexPath.row == tasks.count {
            cell.taskName.text = "Добавить задачу"
            cell.backgroundColor = .lightGray
        } else {
            cell.backgroundColor = .white
            cell.taskName.text = tasks[indexPath.row].name
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == tasks.count {
            let alert = UIAlertController(title: "Введите задачу", message: "", preferredStyle: .alert)
            
            alert.addTextField()
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                let taskName = textField?.text
                
                self.tasks.append(Task(name: taskName ?? ""))
                self.collectionView.reloadData()
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    
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
