//
//  NotesViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var notesCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Заметки: \(notesCounter)"
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNote))
    }
    
    @objc private func handleAddNote() {
        let controller = AddNoteViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

}


extension NotesViewController: AddNewNoteViewControllerDelegate {
    
    func didAddNote() {
        notesCounter += 1
        navigationItem.title = "Заметки: \(notesCounter)"
    }
    
}
