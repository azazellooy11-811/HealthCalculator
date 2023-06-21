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
    var firstName: String = "-"
    var lastName: String = "-"
    var login: String = "-"
    var calories: String = "-"
    var proteins: String = "-"
    var fats: String = "-"
    var carbohydrate: String = "-"
    
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
    
    init(firstName: String, lastName: String, login: String,calories: String, proteins: String, fats: String, carbohydrate: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.login = login
        self.calories = calories
        self.proteins = proteins
        self.fats = fats
        self.carbohydrate = carbohydrate
    }
}
