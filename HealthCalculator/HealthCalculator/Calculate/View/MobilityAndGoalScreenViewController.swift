//
//  MobilityAndGoalScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 30.08.2023.
//

import UIKit
import SnapKit

class MobilityAndGoalScreenViewController: CalculateScreenViewController {
    let names = ["weight loss", "weight retention", "weight gain"]
    let texts = ["Goal",
                 "Average number of steps per month",
                 "Cardio training in minutes in a week",
                 "Strength training in minutes"]
    let placeholders = ["number of steps",
                        "cardio in minutes",
                        "strength training in minutes"]
    let buttonTitle: String = "Show result"
    
    override func viewDidLoad() {
        self.initLabelsOfRadioButtons(names: names)
        self.initRadioButtons(count: names.count)
        self.initBoldLabels(texts: texts)
        self.initTextFields(placeholders: placeholders)
        self.initButton(title: buttonTitle)
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func toggleRadioButtons(sender: UIButton) {
        super.toggleRadioButtons(sender: sender)
        if sender.isSelected {
            isButtonBlocked = false
            
            switch sender.tag {
            case 0: selectedGoal = .weightLoss
            case 1: selectedGoal = .weightRetention
            case 2: selectedGoal = .weightGain
            default: selectedGoal = nil
            }
        } else {
            isButtonBlocked = true
        }
    }
    
    override func clickButton() {
        view.endEditing(true)
        guard !isButtonBlocked else { return initAlert(title: "Ошибка!",
                                                       message: "Заполните все поля",
                                                       preferredStyle: .alert) }
        let result = viewModel.returnCalories()
        initAlert(title: "КБЖУ", message: "Калории: \(result.calories)", preferredStyle: .alert)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        for _ in 0 ..< textFieldsList.count {
            if let steps = textFieldsList[0].text,
               let cardio = textFieldsList[1].text,
               let workout = textFieldsList[2].text,
               let stepsInt = Int(steps),
               let cardioInt = Int(cardio),
               let workoutInt = Int(workout), let selectedGoal {
                isButtonBlocked = false
                
                viewModel.get(steps: stepsInt, cardio: cardioInt, workout: workoutInt)
                viewModel.get(goal: selectedGoal)
            } else {
                return isButtonBlocked = true
            }
        }
    }
}
