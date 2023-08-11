//
//  MainCollectionViewController.swift
//  GameOfThronesInfo
//
//  Created by Vlad on 8.8.23..
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    
    private var persons: [PersonalInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPersons()
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath)
        guard let cell = cell as? UserActionCell
        else {return UICollectionViewCell()}
        let person = persons[indexPath.row]
        cell.configure(with: person)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath
    ) {
        let profileSelection = persons[indexPath.item]
        performSegue(withIdentifier: "showProfile", sender: profileSelection)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let profileVC = segue.destination as? ProfileViewController
        else { return }
        profileVC.userAction = sender as? PersonalInfo
        
    }
}
extension MainCollectionViewController {
    private func fetchPersons(){
        NetworkManager.shared.fetch([PersonalInfo].self, from: link) {
            [self] result in
            switch result {
            case .success(let personsInfo):
                persons = personsInfo
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
