//
//  CardsCollectionViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

protocol CardsCollectionViewControllerDelegate {
    func didAddEntity()
}

class CardsCollectionViewController: UICollectionViewController {
    
    var cards: [String] = []
    var listId : String = ""
    var delegate: CardsCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .lighterGray
        
        collectionView.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseId)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseId, for: indexPath) as! CardCollectionViewCell
        
        if indexPath.item == cards.count {
            cell.backgroundColor = .lightGray
            cell.taskName.text = "Add card"
        } else {
            cell.taskName.text = cards[indexPath.item]
            cell.backgroundColor = .white
        }

        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == cards.count {
            let alert = UIAlertController(title: "Add card", message: "", preferredStyle: .alert)
            
            alert.addTextField()
            
            alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: { [] (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0]
                let cardName = textField?.text
                
                NetworkManager.shared.createCardWith(name: cardName ?? "", onList: self.listId, completion: {
                    self.delegate?.didAddEntity()
                })
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Card", message: cards[indexPath.item], preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [] (_) in
                self.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
}

extension CardsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}
