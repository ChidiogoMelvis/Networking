//
//  HomeViewController.swift
//  Networking
//
//  Created by Mac on 29/05/2023.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var results: [Results] = []
    let viewModel = UserViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .gray
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .white
        viewModel.getUsers { [weak self] error in
            if let error = error {
                print("Error fetching users: \(error)")
            } else {
                DispatchQueue.main.async {
                    self?.results = self?.viewModel.users ?? []
                    self?.tableView.reloadData()
                }
            }
        }

            }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let result = results[indexPath.row]
        cell.configure(with: result)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func setupViews() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    
}
