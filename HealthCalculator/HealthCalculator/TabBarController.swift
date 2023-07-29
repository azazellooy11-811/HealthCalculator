//
//  TabBarController.swift
//  HealthCalculator
//
//  Created by Азалия Халилова on 09.06.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    var login: String

    init(login: String) {
        self.login = login
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.tabBar.backgroundColor = .white
        view.tintColor = .black
        
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        viewControllers = [
            setupNavigationController(rootViewController: ProfileScreenViewController(login: login),
                                      title: "Profile",
                                      image: UIImage(systemName: "person.fill")?.withConfiguration(UIImage.SymbolConfiguration(hierarchicalColor: .green)) ?? .add),
            setupNavigationController(rootViewController: CalculateScreenViewController(login: login, viewModel: CalculateViewModel(login: login)),
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
        //navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}

