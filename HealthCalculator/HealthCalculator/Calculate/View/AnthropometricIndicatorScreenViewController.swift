//
//  AnthropometricIndicatorScreenViewController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.02.2024.
//

import UIKit

class AnthropometricIndicatorScreenViewController: CalculateScreenViewController {
    let names = ["female", "male"]
    let texts = ["Gender","Age","Height","Weight"]
    let placeholders = ["age","height","weight"]
    let buttonTitle: String = "Next"
    
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
            case 0: selectedGender = .female
            case 1: selectedGender = .male
            default: selectedGender = nil
            }
        } else {
            isButtonBlocked = true
        }
        
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        for _ in 0 ..< textFieldsList.count {
            if let age = textFieldsList[0].text,
               let height = textFieldsList[1].text,
               let weight = textFieldsList[2].text,
               let ageInt = Int(age),
               let heightInt = Int(height),
               let weightInt = Int(weight), let selectedGender {
                isButtonBlocked = false
                
                viewModel.get(age: ageInt , height: heightInt , weight: weightInt)
                viewModel.get(gender: selectedGender)
            } else {
                return isButtonBlocked = true
            }
        }
    }
}
