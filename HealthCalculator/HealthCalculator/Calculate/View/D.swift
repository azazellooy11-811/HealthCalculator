//
//  D.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.02.2024.
//

import UIKit

class D: CalculateScreenViewController {
    let names = ["1", "2", "3"]
    
    override func viewDidLoad() {
        self.initLabels(names: names)
        self.initCheckboxs(count: names.count)
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
}
