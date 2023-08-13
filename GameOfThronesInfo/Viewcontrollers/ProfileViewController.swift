//
//  ProfileViewController.swift
//  GameOfThronesInfo
//
//  Created by Vlad on 9.8.23..
//

import UIKit

final class ProfileViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var familyLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var userAction: PersonalInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = userAction?.fullName
        titleLabel.text = "Title: \(userAction?.title ?? "")"
        firstNameLabel.text = "First Name: \(userAction?.firstName ?? "")"
        lastNameLabel.text = "Last Name: \(userAction?.lastName ?? "")"
        familyLabel.text = "Family: \(userAction?.family ?? "")"
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    private func fetchImage(){
        NetworkManager.shared.fetchImage(from: userAction.imageUrl) { [self] result in
            switch result{
            case .success(let imageData):
                self.profileImageView.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
                self.profileImageView.image = UIImage(named: "gOfTh")
            }
        }
    }
}
