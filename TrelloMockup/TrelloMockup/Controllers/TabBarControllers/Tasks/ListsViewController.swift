//
//  TasksViewController.swift
//  TrelloMockup
//
//  Created by Alex Mikhaylov on 12/11/2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class ListsViewController: UICollectionViewController {

    var lists: [List] = []
    var cards: [String: [String]] = [:]
    var boardId: String = ""
    
    
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .orange
        collectionView.decelerationRate = .fast
        
        
        collectionView.contentInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        
        getDataFromTrello()
        
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddColumn))
        
        collectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.reuseId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseId, for: indexPath) as! ListCollectionViewCell
        let list = lists[indexPath.row]
        cell.listName.text = "     \(list.name)"
        cell.listId = list.id
        
        cell.delegate = self
        cell.cards = cards[list.id]
        
        cell.cardsController.collectionView.reloadData()
        return cell
    }
    
    @objc private func handleAddColumn() {
        
        
        let alert = UIAlertController(title: "Add list", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        
        alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: { [] (_) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            let listName = textField?.text
            
            NetworkManager.shared.createListWith(name: listName ?? "", onBoard: self.boardId) {
                self.getDataFromTrello()
            }
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension ListsViewController: CardsCollectionViewControllerDelegate {
    func didAddEntity() {
        self.getDataFromTrello()
    }
}


extension ListsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: view.frame.height * 2 / 3)
    }
    
}





extension ListsViewController {
    
    private func getDataFromTrello() {
        
        cards = [:]
        
        NetworkManager.shared.getBoards { (boards) in
            guard let boards = boards else { return }
            for board in boards {
                print(board.name)
                // В прилоложении не реализован механизм множества досок.
                if board.name == "Тестовая доска от оранжевой команды" {
                    self.boardId = board.id
                    self.getListsFrom(board: board.id)
                }
                
            }
            
            
            
        }
    }
    
    private func getListsFrom(board: String) {
        NetworkManager.shared.getLists(board: board) { (lists) in
            self.lists = lists ?? []
            if let lists = lists {
                for list in lists {
                    self.getCardsFrom(list: list)
                }
            }
            
        }
    }
    
    private func getCardsFrom(list: List) {
        NetworkManager.shared.getCards(list: list.id) { (cards) in

            for card in cards! {
                self.cards.append(element: card.name, toValueOfKey: list.id)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }

        }
    }
    
}
