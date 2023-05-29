//
//  HomeViewController.swift
//  Networking
//
//  Created by Mac on 29/05/2023.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let viewModel = UserViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.getUsers { [weak self] error in
                    if let error = error {
                        // Handle error
                        print("Error fetching users: \(error)")
                    } else {
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        return cell
    }
    
    
}
