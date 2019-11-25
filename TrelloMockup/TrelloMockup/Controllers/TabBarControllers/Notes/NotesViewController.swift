//
//  NotesViewController.swift
//  TrelloMockup
//
//  Created by Alexander on 08.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    private var notes = [Note]()
    private var uiNotes = [UINote]()
    
    private let tableView = UITableView()
    
    private let dataSource: NetFetcher = Firebase()
    private let cloudSaver: NetSaver = Firebase()
    private let firebase: Firebase = Firebase()
    
    private let loadSpinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView()
        loginSpinner.color = .orange
        loginSpinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadVisibleCellsImages()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Заметки"
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddNote))
        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        view.addSubview(tableView)
        tableView.alpha = 0
        
        tableView.register(NotesViewCell.self, forCellReuseIdentifier: NotesViewCell.reuseId)
        
        view.addSubview(loadSpinner)
        loadSpinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadSpinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadSpinner.startAnimating()
        dataSource.getNotes() { receivedNotes in
            self.notes = receivedNotes
            self.uiNotes = receivedNotes.compactMap(){UINote($0)}
            for i in 0..<self.notes.count {
                print(self.notes[i].imgURL ?? "No image")
            }
            
            print(self.uiNotes.count)
            DispatchQueue.main.async {
                self.navigationItem.title = "Заметки: \(self.uiNotes.count)"
                self.loadSpinner.stopAnimating()
                self.tableView.alpha = 1
                self.tableView.reloadData()
                self.loadVisibleCellsImages()
            }
        }
    }
    
    private func loadVisibleCellsImages() {
            for cell in tableView.visibleCells {
                guard let indexPath = tableView.indexPath(for: cell), let url = self.notes[indexPath.row].imgURL else { continue }
                firebase.downloadImage(link: url, completion: { image in
                    self.uiNotes[indexPath.row].img = image
                    print("cell #\(indexPath.row) has an image!")
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                })
            }
        }
    
    @objc private func handleAddNote() {
        let controller = AddItemViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension NotesViewController: AddItemDelegate {
    
    public func didAddItem(_ uiNote: UINote) {
        uiNotes.append(uiNote)
        let note = Note(name: uiNote.name, imgURL: nil, id: nil)
        self.navigationItem.title = "Заметки: \(self.uiNotes.count)"
        self.tableView.reloadData()
        Firebase().uploadImage(image: uiNote.img, handler: { imgUrl in
            note.imgURL = imgUrl
            self.notes.append(note)
            self.cloudSaver.pushNotesToNet(self.notes)
        })
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = NotesViewCellController()
        controller.innerText = uiNotes[indexPath.row].name
        navigationController?.pushViewController(controller, animated: true)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let dellAction = delAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [dellAction])
    }
    
    private func delAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "🗑"){ _,_,completion in
            Firebase().deleteNoteFromNet(self.notes[indexPath.row] ){ resultIsOK in
                guard resultIsOK else {
                    return
                }
                DispatchQueue.main.async {
                    self.uiNotes.remove(at: indexPath.row)
                    self.notes.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            completion(true)
        }
        action.backgroundColor = .red
        return action
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        loadVisibleCellsImages()
    }
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uiNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotesViewCell.reuseId, for: indexPath) as! NotesViewCell
        cell.setupUI(uiNotes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

