
import UIKit

struct FirebaseResponse: Codable {
    let statusCode: Int
    let statusMessage: String
}

final class Firebase: NetFetcher{
    
    private let apiKey = "AIzaSyDFhpl1x3KlfT_StXa4JVOdzwgn5KIOSSg"
    private let baseLink = "https://sbersprinttwoorange.firebaseio.com/Notes"
    private var apiKeyEnding: String {
        return ".json?avvrdd_token=\(apiKey)"
    }
    
    private let config = URLSessionConfiguration.default
    private var session: URLSession {
        return URLSession(configuration: config)
    }
    
    public func getNotes(block: @escaping ([Note]) -> Void ) {
        guard let url = URL(string: baseLink + apiKeyEnding) else {
            return
        }
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
        
        let task = session.dataTask(with: urlRequest){(data, response, error) in
            do {
                let rawNotes = try JSONDecoder().decode([String: Note].self, from: data!)
                let notes = Array(rawNotes.values)
                block(notes)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}

extension Firebase: NetSaver {
    
    public func pushNotesToNet(_ notes: [Note]){
        notes.forEach(){
            pushNoteToNet($0)
        }
    }
    
    private func pushNoteToNet(_ note: Note) {
        let url = URL(string: baseLink + "/\(note.id)" + apiKeyEnding)!
        sendNoteToCloud(url: url, responseType: FirebaseResponse.self, body: note)
    }
    
    private func sendNoteToCloud<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession(configuration: config).dataTask(with: request) { (data, response, error) in }
        task.resume()
    }
}
