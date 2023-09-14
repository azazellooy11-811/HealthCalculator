//
//  ApiManager.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 24.08.2023.
//

import UIKit

final class ApiManager {
    // MARK: - Properties
    private static let apiKey = "13f4e3224d5f412eb56ba84dc055e81c"
    private static let baseUrl = "https://api.spoonacular.com/"
    private static let path = "top-headlines"
    
    private static var result: String = ""
    
    // MARK: - Methods
    static func getRecipes(completion: @escaping (Result<[String], Error>) -> ()) {
        
        let stringUrl = baseUrl + "recipes/findByNutrients?" + "apiKey=" + apiKey + "&minCalories=250&maxCalories=600"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data,
                           error: error,
                           completion: completion)
        }
        
        session.resume()
    }
    
    // Handle response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[String], Error>) -> ()) {
        if let error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data {
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            print(json ?? "")
            
//            do {
//                let model = try JSONDecoder().decode(result, from: data)
//                completion(.success(model.articles))
//            } catch let decodeError {
//                completion(.failure(decodeError))
//            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
