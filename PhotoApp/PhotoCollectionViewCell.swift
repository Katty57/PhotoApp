//
//  PhotoCollectionViewCell.swift
//  PhotoApp
//
//  Created by  User on 10.04.2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    var image: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        image.image = UIImage(named: "imageApp")
        
        addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
