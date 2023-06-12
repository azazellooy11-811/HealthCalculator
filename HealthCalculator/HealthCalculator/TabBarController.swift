//
//  TabBarController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 09.06.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        view.tintColor = .black
        self.tabBar.backgroundColor = .white
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            setupNavigationController(rootViewController: ProfileScreenViewController(),
                                      title: "",
                                      image: UIImage(systemName: "person.fill")?.withConfiguration(UIImage.SymbolConfiguration(hierarchicalColor: .green)) ?? .add),
            setupNavigationController(rootViewController: RegisterScreenViewController(),
                                      title: "Calculate",
                                      image: UIImage(systemName: "plus.forwardslash.minus")?.withConfiguration(UIImage.SymbolConfiguration(hierarchicalColor: .green)) ?? .add),
            setupNavigationController(rootViewController: RegisterScreenViewController(),
                                      title: "Menu",
                                      image: UIImage(systemName: "menucard")?.withConfiguration(UIImage.SymbolConfiguration(hierarchicalColor: .green)) ?? .add)
        ]
    }
    
    private func setupNavigationController(rootViewController: UIViewController,
                                           title: String,
                                           image: UIImage) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}

