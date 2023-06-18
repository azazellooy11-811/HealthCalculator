//
//  GoalModel.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 18.06.2023.
//

import Foundation

struct GoalModel {
    enum GoalEnum {
        case weightLoss
        case weightRetention
        case weightGain
    }
    
    let goal: GoalEnum
    
    //var selected: Bool = false
}
