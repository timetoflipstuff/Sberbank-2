
import UIKit

class NotesViewController: UIViewController {

    var uiNotes: [UINote] = []
    
    let tableView = UITableView()
    
    private let dataSource: NetFetcher = Firebase()
    private let cloudSaver: NetSaver = Firebase()
    
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
        navigationItem.title = "Заметки: \(uiNotes.count)"
        
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
            self.uiNotes = receivedNotes.compactMap(){UINote($0)}
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
    
    public func didAddItem(_ uiNote: UINote) {//(name: String) {
        uiNotes.append(uiNote)
        navigationItem.title = "Заметки: \(uiNotes.count)"
        tableView.reloadData()
        //TODO: send all notes to cloud
        cloudSaver.pushNotesToNet(uiNotes.compactMap(){Note(name: $0.name, imgURL: nil)})
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = NotesViewCellController()
        controller.innerText = uiNotes[indexPath.row].name
        navigationController?.pushViewController(controller, animated: true)
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
