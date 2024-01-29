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
    static func getRecipes(completion: @escaping (Result<[DishModel], Error>) -> ()) {
        
        let stringUrl = baseUrl + "recipes/findByNutrients?" + "apiKey=" + apiKey + "&minCalories=250&maxCalories=600"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data,
                           error: error,
                           completion: completion)
        }
        
        session.resume()
    }
    
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            
            if let error = error {
                completion(.failure(error))
            }
        }
        
        session.resume()
    }
    
    // Handle response
    private static func handleResponse(data: Data?,
                                       error: Error?,
                                       completion: @escaping (Result<[DishModel], Error>) -> ()) {
        if let error {
            completion(.failure(NetworkingError.networkingError(error)))
        } else if let data {
            
            //let json = try? JSONSerialization.jsonObject(with: data, options: [])
            
            do {
                let model = try JSONDecoder().decode([DishModel].self, from: data)
                completion(.success(model))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        } else {
            completion(.failure(NetworkingError.unknown))
        }
    }
}
