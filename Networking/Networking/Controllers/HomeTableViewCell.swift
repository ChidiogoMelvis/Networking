//
//  HomeTableViewCell.swift
//  Networking
//
//  Created by Mac on 29/05/2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    let identifier = "HomeTableViewCell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
    }()
    
    lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupViews()

        // Configure the view for the selected state
    }
    
    func setupViews() {
        self.addSubview(nameLabel)
        self.addSubview(emailLabel)
        self.addSubview(profileImage)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            
            profileImage.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            profileImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
        ])
    }
    
        func configure(with result: Results) {
            nameLabel.text = "\(result.name.first) \(result.name.last)"
            emailLabel.text = result.email
            
            
            if let url = URL(string: result.picture.medium) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.profileImage.image = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
