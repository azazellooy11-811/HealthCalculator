//
//  CalculateDataModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 16.06.2023.
//

import Foundation

struct CalculateDataModel {
    struct Gender {
        enum GenderEnum {
            case male
            case female
        }
        
        let gender: GenderEnum
        
        var selected: Bool = false
    }
    
    let age: Int
    let height: Int
    let weight: Int
    let steps: Int
    let cardio: Int
    let workout: Int
    
    struct Goal {
        enum GoalEnum {
            case weightLoss
            case weightRetention
            case weightGain
        }
        
        let goal: GoalEnum
        
        var selected: Bool = false
    }
    
    struct Level {
        enum LevelEnum {
            case amateur
            case professional
        }
        
        let level: LevelEnum
        
        var selected: Bool = false
        
    }
}

