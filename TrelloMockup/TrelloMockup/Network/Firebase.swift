import UIKit
import Foundation

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

extension Firebase{

    public func deleteNoteFromNet(_ note: Note, compl: @escaping (Bool) -> Void){
        
        let url = URL(string: baseLink + "/\(note.id)" + apiKeyEnding)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(note)
        
        let task = URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            if httpResponse.statusCode == 200 {
                compl(true)
            }
        }
        task.resume()
    }
    
    func uploadImage(image: UIImage, handler: @escaping (String) -> Void) {
        //let compressedImage = image.jpegData(compressionQuality: 0)

        let imageData = image.jpegData(compressionQuality: 0.1)
        let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
        
        let url = URL(string: "https://api.imgur.com/3/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("CLIENT-ID 94b8df681dd5d46", forHTTPHeaderField: "Authorization")
        let bodyDict = ["image": "\(base64Image!)", "name": "\(arc4random()).jpg", "type": "base64"]
        if let jsonBody = try? JSONSerialization.data(withJSONObject: bodyDict, options: .prettyPrinted) {
            request.httpBody = jsonBody
        } else {
            print("poopie")
            return
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else {
                print("poop")
                return
            }
            do {
                let response = try JSONDecoder().decode(JsonResponse.self, from: data)
                let imageUrl = response.data.link
                print(imageUrl)
                handler(imageUrl)
            } catch {
                print(error)
            }
        }).resume()
    }
}

struct JsonResponse: Codable {
    struct JsonData: Codable {
        let link: String
    }
    let data: JsonData
}
