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
    }
    
        func configure(with result: Results) {
            nameLabel.text = "\(result.name.first) \(result.name.last)"
            emailLabel.text = result.email
            
            // Load the profile image asynchronously
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
