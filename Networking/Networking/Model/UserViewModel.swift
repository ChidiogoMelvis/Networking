//
//  UserViewModel.swift
//  Networking
//
//  Created by Mac on 29/05/2023.
//

import Foundation

class UserViewModel {
    private let networkService = NetworkService()
    private(set) var users: [Welcome] = []
    
    func getUsers(completion: @escaping (Error?) -> Void) {
        networkService.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}
