//
//  HomeViewController.swift
//  Networking
//
//  Created by Mac on 29/05/2023.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    let viewModel = UserViewModel()
    
    lazy var searchTextField: UISearchTextField = {
        let search = UISearchTextField()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.delegate = self
        search.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        return search
        
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
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
                            self?.tableView.reloadData()
                        }
                    }
                }
            }
    
    @objc func searchTextChanged() {
        // Access the current text in the search text field
        let searchText = searchTextField.text ?? ""
        
        // Perform any desired actions based on the search text
        print("Search text changed: \(searchText)")
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath)
        return cell
    }
    
    func setupViews() {
        view.addSubview(searchTextField)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
        searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        
        tableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 16),
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    
}
