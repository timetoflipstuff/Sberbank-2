//
//  NotesViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    var notes: [Note] = []
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Заметки: \(notes.count)"
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true

        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.register(NotesViewCell.self, forCellReuseIdentifier: NotesViewCell.reuseId)
    }
    
    @objc private func handleAddNote() {
        let controller = AddItemViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

}


extension NotesViewController: AddItemDelegate {
    
    func didAddItem(name: String) {
        notes.append(Note(name: name))
        navigationItem.title = "Заметки: \(notes.count)"
        tableView.reloadData()
    }
    
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = NotesViewCellController()
        controller.innerText = notes[indexPath.row].name
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesViewCell.reuseId, for: indexPath) as! NotesViewCell
        
        let note = notes[indexPath.row]
        
        cell.nameLabel.text = note.name
        
        return cell
    }
    

}

class Note {
    var name = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
