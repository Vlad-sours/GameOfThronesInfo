//
//  Networkmanager.swift
//  GameOfThronesInfo
//
//  Created by Vlad on 8.8.23..
//

import Foundation
import Alamofire

enum Links {
    static let link = "https://thronesapi.com/api/v2/Characters/"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}
class NetworkManager{
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping(Result<Data, NetworkError>) -> Void){
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return}
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchPersons(from url: String,
                      completion: @escaping(
                        Result<[PersonalInfo], AFError>
                      ) -> Void) {
                          AF.request(url)
                              .validate()
                              .responseJSON { dataResponse in
                                  switch dataResponse.result {
                                  case .success(let value):
                                      let persons = PersonalInfo.getPersons(from: value)
                                      completion(.success(persons))
                                  case .failure(let error):
                                      completion(.failure(error))
                                  }
                              }
                      }
    /*func fetch<T: Decodable>(_ type: T.Type,from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
     guard let url = URL(string: url) else {
     completion(.failure(.invalidURL))
     return }
     URLSession.shared.dataTask(with: url) { data, _, error in
     guard let data else {
     completion(.failure(.noData))
     print(error?.localizedDescription ?? "No error description")
     return
     }
     
     do {
     let type = try JSONDecoder().decode(T.self, from: data)
     DispatchQueue.main.async {
     completion(.success(type))
     }
     } catch {
     completion(.failure(.decodingError))
     }
     
     }.resume()
     }*/
    
}


