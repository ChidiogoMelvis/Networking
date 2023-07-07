//
//  NetworkManager.swift
//  Networking
//
//  Created by Mac on 29/05/2023.
//

import Foundation

class NetworkService {
    func getUsers(completion: @escaping (Result<[Results], Error>) -> Void) {
        let url = URL(string: "https://randomuser.me/api/?results=5")!
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let welcome = try decoder.decode(Welcome.self, from: data)
                    let results = welcome.results
                    completion(.success(results))
                    print(results.count)
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
}
