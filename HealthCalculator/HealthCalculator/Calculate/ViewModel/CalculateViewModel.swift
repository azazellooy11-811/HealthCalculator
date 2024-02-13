//
//  CalculateViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 18.06.2023.
//

import UIKit

protocol CalculateViewModelProtocol {
    func get(gender: Gender)
    func get(age: Int, height: Int, weight: Int)
    func get(steps: Int, cardio: Int, workout: Int)
    func get(goal: Goal)
    func returnCalories() -> CaloriesModel
}

class CalculateViewModel: CalculateViewModelProtocol {
    
    let profileInfo: ProfileInfoModel
    var startCcal: Int = 0
    var activeCcal: Int = 0
    var percentCcal: Int = 0
    var gender: Gender = .female
    var age: Int = 0
    var height: Int = 0
    var weight: Int = 0
    var steps: Int = 0
    var cardio: Int = 0
    var workout: Int = 0
    var goal: Goal = .weightGain
    
    init(login: String) {
        self.profileInfo = ProfileInfoPersistent.fetchProfileInfo(login: login)
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
        self.workout = (5 + workout ) / 7
    }
    
    func get(gender: Gender) {
        self.gender = gender
    }
    
    func get(age: Int, height: Int, weight: Int) {
        self.age = 5 * age
        self.height = Int(6.25 * Double(height))
        self.weight = weight
    }
    
    func calculate() -> CaloriesModel {
        switch gender {
        case .male:
            startCcal = (10 * weight) + height - age + 5
            percentCcal = Int(Double(startCcal) * 0.1)
        case .female:
            startCcal = (10 * weight) + height - age - 161
            percentCcal = Int(Double(startCcal) * 0.1)
        }
        
        switch goal {
        case .weightLoss:
            let ccal = startCcal + percentCcal
            let percent = Int(Double(ccal) * 0.1)
            activeCcal = ccal - percent + steps + cardio + workout
        case .weightRetention:
            let ccal = startCcal + percentCcal
            activeCcal = ccal + steps + cardio + workout
        case .weightGain:
            let ccal = startCcal + percentCcal
            let percent = Int(Double(ccal) * 0.1)
            activeCcal = ccal + percent + steps + cardio + workout
        }
        
        let proteins = (0.3 * Double(activeCcal)) / 4
        let fats = (0.3 * Double(activeCcal)) / 9
        let carbohydrate = (0.4 * Double(activeCcal))
        
        let result = CaloriesModel(calories: activeCcal, proteins: Int(proteins), fats: Int(fats), carbohydrate: Int(carbohydrate))
        let profileInfo = ProfileInfoModel(firstName: profileInfo.firstName, lastName: profileInfo.lastName, login: profileInfo.login, calories: String(result.calories), proteins: String(result.proteins), fats: String(result.fats), carbohydrate: String(result.carbohydrate))
        
        ProfileInfoPersistent.updateProfileInfo(with: profileInfo)
        
        return result
    }
}
