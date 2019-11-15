//
//  NetworkManager.swift
//  TrelloMockup
//
//  Created by Alexander on 15.11.2019.
//  Copyright © 2019 Alexander. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    private let apiKey = "a2796b3d96073316f3bc9a5a91e4b908"
    private lazy var token = AppDelegate.defaults.value(forKey: "token")
    
    static let shared = NetworkManager()
    
    private init() {}
    
    public func getAuthRequest() -> URLRequest {
        let urlString = "https://trello.com/1/authorize?expiration=1day&name=TrelloMockup&scope=read&response_type=token&key=\(apiKey)"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        return request
    }
    
    func genericFetchFunction<T: Decodable>(url: String, completion: @escaping (T?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 120)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects)
            } catch {
                print(error)
                return
            }
            
            
        }
        
        task.resume()
        
    }
    
    public func getBoards(completion: @escaping ([Board]?) -> Void) {
        guard let token = token else { return }
        let urlString = "https://api.trello.com/1/members/me/boards?key=\(apiKey)&token=\(token)"
        genericFetchFunction(url: urlString, completion: completion)
    }
    
    public func getLists(board: String, completion: @escaping ([List]?) -> Void) {
        guard let token = token else { return }
        let urlString = "https://api.trello.com/1/boards/\(board)/lists?key=\(apiKey)&token=\(token)"
        genericFetchFunction(url: urlString, completion: completion)
    }
    
    public func getCards(list: String, completion: @escaping ([Card]?) -> Void) {
        guard let token = token else { return }
        print(token)
        let urlString = "https://api.trello.com/1/boards/\(list)/cards?key=\(apiKey)&token=\(token)"
        genericFetchFunction(url: urlString, completion: completion)
    }
    
}
