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
    var boards: [Board] = []
    var lists: [List] = []
    var cards: [Card] = []
    
    var boardId = String()
    
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.decelerationRate = .fast
        
        NetworkManager.shared.getBoards { (boards) in
            guard let boards = boards else { return }
            self.boards = boards
            for board in boards {
                //MARK: В прилоложении не реализован механизм множества досок.
                if board.name == "Keep Team Info Organized" {
                    self.boardId = board.id
                    print(self.boardId)
                }
            }
            
            NetworkManager.shared.getLists(board: self.boardId, completion: { (lists) in
                guard let lists = lists else { return }
                
                self.lists = lists
                
                for (index, list) in lists.enumerated() {
                    NetworkManager.shared.getCards(list: list.idBoard, completion: { (cards) in
                        self.cards = cards ?? []
                        
                        if index == lists.count - 1 {
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                            }
                        }
                        
                    })
                }
                
                
            })
            
            
        }
        
        
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddColumn))
        
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return lists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseId, for: indexPath) as! CardCollectionViewCell
        cell.columnName.text = "     \(lists[indexPath.row].name)"
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
            
            self.collectionView.scrollToItem(at: IndexPath(row: self.columns.count - 1, section: 0), at: .right, animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}



extension TasksViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 64, height: view.frame.height * 2 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
}


