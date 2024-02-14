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
}
