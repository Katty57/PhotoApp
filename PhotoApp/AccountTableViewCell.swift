//
//  AccountTableViewCell.swift
//  PhotoApp
//
//  Created by  User on 10.04.2022.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    var nicknameLabel: UILabel!
    var profilePhotoImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profilePhotoImageView = UIImageView()
        profilePhotoImageView.backgroundColor = .white
        
        
        nicknameLabel = UILabel()
        nicknameLabel.backgroundColor = .white
        nicknameLabel.text = ""
        nicknameLabel.font = UIFont(name: "Arial", size: 25.0)
        
        addSubview(nicknameLabel)
        addSubview(profilePhotoImageView)
        
        profilePhotoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhotoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            profilePhotoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            profilePhotoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9)
        ])
        
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nicknameLabel.centerYAnchor.constraint(equalTo: profilePhotoImageView.centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: 20),
            profilePhotoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            profilePhotoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
