//
//  ProfileInfoModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 12.06.2023.
//

import Foundation

struct ProfileInfoModel {
    let imageUrl: String?
    let image: Data?
    let firstName: String
    let lastName: String
    let calories: String = "-"
    let proteins: String = "-"
    let fats: String = "-"
    let carbohydrate: String = "-"
}
