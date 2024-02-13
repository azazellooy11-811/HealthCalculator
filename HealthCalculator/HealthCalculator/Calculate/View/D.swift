//
//  D.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 13.02.2024.
//

import UIKit

class D: CalculateScreenViewController {
    let names = ["1", "2", "3"]
    let count = 3
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initLabels(names: names)
        initCheckboxs(count: count)
    }
}
