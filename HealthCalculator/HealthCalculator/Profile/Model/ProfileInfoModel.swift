//
//  ProfileInfoModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 12.06.2023.
//

import Foundation

struct ProfileInfoModel {
    let imageUrl: String? = nil
    let image: Data? = nil
    let firstName: String
    let lastName: String
    let login: String
    let calories: String = "-"
    let proteins: String = "-"
    let fats: String = "-"
    let carbohydrate: String = "-"
    
    init(profileInfo: ProfileInfo) {
        self.firstName = profileInfo.firstName ?? ""
        self.lastName = profileInfo.lastName ?? ""
        self.login = profileInfo.login ?? ""
    }
    
    init(firstName: String = "" , lastName: String = "", login: String = "") {
        self.firstName = firstName
        self.lastName = lastName
        self.login = login
    }
}
