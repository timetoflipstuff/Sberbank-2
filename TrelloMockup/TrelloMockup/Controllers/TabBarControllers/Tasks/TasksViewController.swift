//
//  TasksViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

//class TasksViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .orange
//        navigationItem.title = "Задачи"
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
//
//
//
//}


class TasksViewController: UICollectionViewController {
    
    var tasks: [Task] = [Task(name: "Имя колонки"), Task(name: "Добавить задачу")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        tasks.insert(contentsOf: [Task(name: "Тестовая задача 1")], at: tasks.count - 1)
//        tasks.insert(contentsOf: [Task(name: "Тестовая задача 2")], at: tasks.count - 1)
        
        collectionView.backgroundColor = .white
        
        collectionView.register(TasksCollectionViewCell.self, forCellWithReuseIdentifier: TasksCollectionViewCell.reuseId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TasksCollectionViewCell.reuseId, for: indexPath) as! TasksCollectionViewCell
        
        let task = tasks[indexPath.row]
        cell.nameLabel.text = task.name
        
        return cell
    }
    
    
    
}

extension TasksViewController: AddTaskVCDelegate {
    
    func didAddTask(name: String) {
        tasks.insert(contentsOf: [Task(name: name)], at: tasks.count - 1)
        collectionView.reloadData()
        //tableView.insertRows(at: IndexPath.row, with: UITableView.RowAnimation) //good when you just need to add a couple of rows
    }
    
}

extension TasksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == tasks.count - 1 {
            return CGSize(width: view.frame.width - 64, height: 70)
        } else  if indexPath.row == 0 {
            return CGSize(width: view.frame.width - 64, height: 40)
        } else {
            return CGSize(width: view.frame.width - 64, height: 200)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.row == tasks.count - 1 {
            let controller = AddTaskVC()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
            // Не работает
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 20, bottom: 0, right: 20)
    }
}

class Task {
    var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
