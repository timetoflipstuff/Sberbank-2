
import UIKit

class NotesViewController: UIViewController {

    var notes: [Note] = []
    
    let tableView = UITableView()
    
    private let dataSource: Net = Firebase()
    
    private let loadSpinner: UIActivityIndicatorView = {
        let loginSpinner = UIActivityIndicatorView()
        loginSpinner.color = .orange
        loginSpinner.transform = CGAffineTransform(scaleX: 4, y: 4)
        loginSpinner.translatesAutoresizingMaskIntoConstraints = false
        loginSpinner.hidesWhenStopped = true
        return loginSpinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Заметки: \(notes.count)"
        
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
        dataSource.getNotes(){ receivedNotes in
            self.notes = receivedNotes
            DispatchQueue.main.async {
                self.loadSpinner.stopAnimating()
                self.tableView.alpha = 1
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func handleAddNote() {
        let controller = AddItemViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension NotesViewController: AddItemDelegate {
    
    func didAddItem(name: String) {
        notes.append(Note(name: name, imgURL: nil))
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
