//
//  CalculateViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 18.06.2023.
//

import UIKit

protocol CalculateViewModelProtocol {
    func get(gender: Gender, age: Int, height: Int, weight: Int)
    func get(steps: Int, cardio: Int, workout: Int)
    func get(goal: Goal)
    func returnCalories() -> CaloriesModel
}

class CalculateViewModel: CalculateViewModelProtocol {
    
    let profileInfo: ProfileInfoModel
    var startCcal: Int = 0
    var activeCcal: Int = 0
    var procentCcal: Int = 0
    var gender: Gender = .female
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var steps: Int = 0
    var cardio: Int = 0
    var workout: Int = 0
    var goal: Goal = .weightGain
    
    init(profileInfo: ProfileInfoModel) {
        self.profileInfo = profileInfo
    }
    
    func returnCalories() -> CaloriesModel {
        calculate()
    }
    
    func get(goal: Goal) {
        self.goal = goal
    }
    
    func get(steps: Int, cardio: Int, workout: Int) {
        self.steps = Int(0.03 * Double(steps))
        self.cardio = cardio / 7
        self.workout = (5 + workout )/7
    }
    
    func get(gender: Gender, age: Int, height: Int, weight: Int) {
        self.gender = gender
        self.age = 5 * age
        self.height = Int(6.25 * Double(height))
        self.weight = weight
    }
    
    func calculate() -> CaloriesModel {
        // изначальные ккал 1505.3
//        * для мужчин: 10 х вес (кг) + 6,25 x рост (см) – 5 х возраст (г) + 5;
//        * для женщин: 10 x вес (кг) + 6,25 x рост (см) – 5 x возраст (г) – 161.
        switch gender {
        case .male:
            startCcal = (10 * weight) + height - age + 5
            procentCcal = Int(Double(startCcal) * 0.1)
        case .female:
            startCcal = (10 * weight) + height - age - 161
            procentCcal = Int(Double(startCcal) * 0.1)
        }
        
//        * для мужчин: 10 х вес (кг) + 6,25 x рост (см) – 5 х возраст (г) + 5 + (()*0,1) + (0,03 *количество шагов);
//        * для женщин: 10 x вес (кг) + 6,25 x рост (см) – 5 x возраст (г) – 161 + (()*0,1) + (0,03 *количество шагов)

        switch goal {
        case .weightLoss:
            let ccal = startCcal + procentCcal
            let procent = Int(Double(ccal) * 0.1)
            activeCcal = ccal - procent + steps + cardio + workout
        case .weightRetention:
            let ccal = startCcal + procentCcal
            let procent = Int(Double(ccal) * 0.1)
            activeCcal = ccal + steps + cardio + workout
        case .weightGain:
            let ccal = startCcal + procentCcal
            let procent = Int(Double(ccal) * 0.1)
            activeCcal = ccal + procent + steps + cardio + workout
        }
        
        let proteins = (0.3 * Double(activeCcal)) / 4 //Int(1.9125 * Double(weight))
        let fats = (0.3 * Double(activeCcal)) / 9 //Int(1.06 * Double(weight))
        let carbohydrate = (0.4 * Double(activeCcal)) / 4 //Int(2.75208 * Double(weight))
        var result = CaloriesModel(calories: activeCcal, proteins: Int(proteins), fats: Int(fats), carbohydrate: Int(carbohydrate))
        
        
        let profileInfo = ProfileInfoModel(firstName: profileInfo.firstName, lastName: profileInfo.lastName, login: profileInfo.login, calories: String(result.calories), proteins: String(result.proteins), fats: String(result.fats), carbohydrate: String(result.carbohydrate))
        ProfileInfoPersistent.updateProfileInfo(with: profileInfo)
        
        return result
    }
}
