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
}

