//
//  CalculateViewModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 18.06.2023.
//

import UIKit

protocol CalculateViewModelProtocol {
    func get(gender: GenderModel, age: Int, height: Int, weight: Int)
    func get(steps: Int, cardio: Int, workout: Int)
    func get(goal: GoalModel)
    func returnCalories() -> CaloriesModel
}

class CalculateViewModel: CalculateViewModelProtocol {
    func returnCalories() -> CaloriesModel {
        return CaloriesModel()
    }
    
    func get(goal: GoalModel) {
        self.goal = goal
    }
    
    func get(steps: Int, cardio: Int, workout: Int) {
        self.steps = steps
        self.cardio = cardio
        self.workout = workout
    }
    
    func get(gender: GenderModel, age: Int, height: Int, weight: Int) {
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
    }
    
    func calculate() {
        // изначальные ккал 1505.3
//        * для мужчин: 10 х вес (кг) + 6,25 x рост (см) – 5 х возраст (г) + 5;
//        * для женщин: 10 x вес (кг) + 6,25 x рост (см) – 5 x возраст (г) – 161.
        switch gender.gender {
        case .female:
            startCcal = (10 * weight) + (6.25 * height) - (5 * age) - 161
            print("start ccal for woman : \(startCcal)")
        case.male:
            startCcal = (10 * weight) + (6.25 * height) - (5 * age) + 5
            print("start ccal for man : \(startCcal)")
        }
        
//        * для мужчин: 10 х вес (кг) + 6,25 x рост (см) – 5 х возраст (г) + 5 + (()*0,1) + (0,03 *количество шагов);
//        * для женщин: 10 x вес (кг) + 6,25 x рост (см) – 5 x возраст (г) – 161 + (()*0,1) + (0,03 *количество шагов)

        switch goal.goal {
        case weightLoss:
            activeCcal = activeCcal + (activeCcal * 0.1) + (0.03 * steps)
        case weightRetention:
        case weightGain:
        }
        //activeCcal =
    }
    
    var startCcal: Int
    var activeCcal: Int
    var gender: GenderModel
    var age: Int
    var height: Int
    var weight: Int
    var steps: Int
    var cardio: Int
    var workout: Int
    var goal: GoalModel
    
    
    init() {
        returnCalories()
    }
}
