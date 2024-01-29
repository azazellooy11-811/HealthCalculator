//
//  DishModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 27.12.2023.
//

import UIKit

struct DishModel: Codable {
    let calories: Int
    let carbs: String
    let fat: String
    let id: Int
    let image: String
    let imageType: String
    let protein: String
    let title: String
    
    enum CodingKeys: CodingKey {
        case calories
        case carbs
        case fat
        case id
        case image
        case imageType
        case protein
        case title
    }
}
