//
//  Model.swift
//  GameOfThronesInfo
//
//  Created by Vlad on 8.8.23..
//

struct PersonalInfo: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let fullName: String
    let title: String
    let family: String
    let image: String
    let imageUrl: String
    
    init(id: Int, firstName: String, lastName: String, fullName: String, title: String, family: String, image: String, imageUrl: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName
        self.title = title
        self.family = family
        self.image = image
        self.imageUrl = imageUrl
    }
    
    init(personData: [String: Any]){
        id = personData["id"] as? Int ?? 0
        firstName = personData["firstName"] as? String ?? ""
        lastName = personData["lastName"] as? String ?? ""
        fullName = personData["fullName"] as? String ?? ""
        title = personData["title"] as? String ?? ""
        family = personData["family"] as? String ?? ""
        image = personData["image"] as? String ?? ""
        imageUrl = personData["imageUrl"] as? String ?? ""
    }
    static func getPersons(from value: Any) -> [PersonalInfo] {
        guard let personsData = value as? [[String: Any]] else { return [] }
        return personsData.map { PersonalInfo(personData: $0)}
        
    }
}

