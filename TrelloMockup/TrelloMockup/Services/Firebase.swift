
import UIKit

class Firebase: Net{
    
    private let apiKey = "AIzaSyDFhpl1x3KlfT_StXa4JVOdzwgn5KIOSSg"
    private var notesLink: String {
        return "https://sbersprinttwoorange.firebaseio.com/Notes.json?avvrdd_token=\(apiKey)"
    }
    private let config = URLSessionConfiguration.default
    private var session: URLSession {
        return URLSession(configuration: config)
    }
    
    func getNotes(block: @escaping ([Note]) -> Void ) {
        guard let url = URL(string: notesLink) else {
            return
        }
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
        
        let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            do {
                let rawNotes = try JSONDecoder().decode([String: Note].self, from: data!)
                let notes = Array(rawNotes.values)
                print("Received objects")
                notes.forEach(){
                    print($0.name)
                    print($0.imgURL ?? "noImgURL")
                }
                block(notes)
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}

extension Firebase: CloudSaver {
    func saveToCloud(_ notes: [Note]){
        
    }
}
