
import UIKit


struct FirebaseResponse: Codable {
    
    let statusCode: Int
    let statusMessage: String
    
}

extension FirebaseResponse: LocalizedError {
    var errorDescription: String? {
        return statusMessage
    }
}

class Firebase: NetFetcher{
    
    private let apiKey = "AIzaSyDFhpl1x3KlfT_StXa4JVOdzwgn5KIOSSg"
    private let baseLink = "https://sbersprinttwoorange.firebaseio.com/Notes"
    private var apiKeyEnding: String {
        return ".json?avvrdd_token=\(apiKey)"
    }
    
    private let config = URLSessionConfiguration.default
    private var session: URLSession {
        return URLSession(configuration: config)
    }
    
    func getNotes(block: @escaping ([Note]) -> Void ) {
        guard let url = URL(string: baseLink + apiKeyEnding) else {
            return
        }
        let urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
        
        let task = session.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            do {
                let rawNotes = try JSONDecoder().decode([String: Note].self, from: data!)
                let notes = Array(rawNotes.values)
                block(notes)
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}

extension Firebase: NetSaver {
    public func pushNotesToNet(_ notes: [Note]){
        for item in notes {
            item.id = item.id ?? UUID().uuidString
        }
        notes.forEach(){
            saveNote(index: $0.id ?? UUID().uuidString,
                     text: $0.name,
                     imgURL: $0.imgURL ?? "https://www.google.com/imgres?imgurl=https%3A%2F%2Favatars.mds.yandex.net%2Fget-pdb%2F245485%2Fbacb22b0-e978-448e-921b-0cd0b39c5f92%2Fs375&imgrefurl=https%3A%2F%2Fyandex.ru%2Fimages%2F&docid=EMUIokkVFzxHTM&tbnid=Du0z0amaw2dWwM%3A&vet=10ahUKEwiL1ZSk4vHlAhXu0qYKHQb6A7MQMwi1AigjMCM..i&w=375&h=479&bih=929&biw=1876&q=%D0%BA%D0%B0%D1%80%D1%82%D0%B8%D0%BD%D0%BA%D0%B8&ved=0ahUKEwiL1ZSk4vHlAhXu0qYKHQb6A7MQMwi1AigjMCM&iact=mrc&uact=8",
                     completion: {_,_ in })
        }
    }
    
    private func saveNote(index: String, text: String, imgURL: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = Note(name: text, imgURL: imgURL)
        let url = URL(string: baseLink + "/\(index)" + apiKeyEnding)!
        
        sendNoteToCloud(url: url, responseType: FirebaseResponse.self, body: body) { (response, error) in
            if let response = response {
                completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    private func sendNoteToCloud<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(FirebaseResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}
