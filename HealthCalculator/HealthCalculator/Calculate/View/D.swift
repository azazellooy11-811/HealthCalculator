//
//  D.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.02.2024.
//

import UIKit

class D: CalculateScreenViewController {
    let names = ["female", "male"]
    
    override func viewDidLoad() {
        self.initLabelsOfRadioButtons(names: names)
        self.initRadioButtons(count: names.count)
        self.initBoldLabels(texts: ["1","2","3","4"])
        self.initTextFields(placeholders: ["1","2","3"])
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    
    override func toggleRadioButtons(sender: UIButton) {
        super.toggleRadioButtons(sender: sender)
        
        switch sender.tag {
        case 0: selectedGender = .female
        case 1: selectedGender = .male
        default: print("no")
        }
    }
    
    override func textFieldDidEndEditing(_ textField: UITextField) {
        for _ in 0 ..< textFieldsList.count {
            if let age = textFieldsList[0].text,
               let height = textFieldsList[1].text,
               let weight = textFieldsList[2].text,
               let ageInt = Int(age),
               let heightInt = Int(height),
               let weightInt = Int(weight) {
                isButtonBlocked = false
                
                viewModel.get(age: ageInt , height: heightInt , weight: weightInt)
                
            } else {
                return isButtonBlocked = true
            }
        }
    }
}
