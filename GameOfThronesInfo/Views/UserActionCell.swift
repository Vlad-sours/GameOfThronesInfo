//
//  UserActionCell.swift
//  GameOfThronesInfo
//
//  Created by Vlad on 8.8.23..
//

import UIKit

final class UserActionCell: UICollectionViewCell {
    
    @IBOutlet weak var userActionImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
        
    func configure(with person: PersonalInfo){
        fullNameLabel.text = person.fullName
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        NetworkManager.shared.fetchImage(from: person.imageUrl) { [self] result in
            switch result{
            case .success(let imageData):
                    self.userActionImageView.image = UIImage(data: imageData)
                    self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
                    self.userActionImageView.image = UIImage(named: "gOfTh")
            }
        }
    }
}
